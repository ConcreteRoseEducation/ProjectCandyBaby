package com.example.projectcandybaby.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.projectcandybaby.data.db.HoldingDao
import com.example.projectcandybaby.data.db.PortfolioDao
import com.example.projectcandybaby.data.db.TransactionDao
import com.example.projectcandybaby.data.model.Holding
import com.example.projectcandybaby.data.model.PortfolioPoint
import com.example.projectcandybaby.data.model.StockTicker
import com.example.projectcandybaby.data.model.Transaction
import com.example.projectcandybaby.data.model.TransactionType
import com.example.projectcandybaby.data.repository.AuthRepository
import com.example.projectcandybaby.data.repository.FirestoreMarketRepository
import com.example.projectcandybaby.data.repository.UserPreferencesRepository
import com.example.projectcandybaby.logic.MarketEngine
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import kotlin.random.Random

class MainViewModel(
    private val holdingDao: HoldingDao,
    private val transactionDao: TransactionDao,
    private val portfolioDao: PortfolioDao,
    private val userPrefs: UserPreferencesRepository,
    private val authRepository: AuthRepository,
    private val firestoreMarketRepository: FirestoreMarketRepository,
    private val marketEngine: MarketEngine
) : ViewModel() {

    private val _isBypassed = MutableStateFlow(false)
    val isBypassed = _isBypassed.asStateFlow()

    val currentUser = authRepository.currentUser
    val stocks = firestoreMarketRepository.getGlobalStocks()
        .stateIn(viewModelScope, SharingStarted.Lazily, emptyList())
    
    val holdings = holdingDao.getAllHoldings().stateIn(viewModelScope, SharingStarted.Lazily, emptyList())
    val sugarCoins = userPrefs.sugarCoinsFlow.stateIn(viewModelScope, SharingStarted.Lazily, 1000.0)
    val disclaimerAccepted = userPrefs.disclaimerAcceptedFlow.stateIn(viewModelScope, SharingStarted.Lazily, false)

    val portfolioHistory = portfolioDao.getHistory()
        .map { points -> points.map { it.totalValue } }
        .stateIn(viewModelScope, SharingStarted.Lazily, emptyList())

    val sectorAllocation = combine(holdings, stocks) { hList, sList ->
        hList.groupBy { h -> sList.find { it.symbol == h.symbol }?.sector?.displayName ?: "Unknown" }
            .mapValues { (_, hGroup) ->
                hGroup.sumOf { h ->
                    val price = sList.find { it.symbol == h.symbol }?.currentPrice ?: 0.0
                    h.quantity * price
                }
            }
    }.stateIn(viewModelScope, SharingStarted.Lazily, emptyMap())

    val profitLoss = combine(holdings, stocks) { hList, sList ->
        hList.map { h ->
            val stock = sList.find { it.symbol == h.symbol }
            val currentVal = (stock?.currentPrice ?: 0.0) * h.quantity
            val purchaseVal = h.averagePurchasePrice * h.quantity
            h.symbol to (currentVal - purchaseVal)
        }.toMap()
    }.stateIn(viewModelScope, SharingStarted.Lazily, emptyMap())

    init {
        // Seed initial data if empty
        viewModelScope.launch {
            val history = portfolioDao.getHistory().first()
            if (history.isEmpty()) {
                val startValue = 1000.0
                val points = List(20) { i ->
                    val variance = (Random.nextDouble() * 2 - 1) * 50.0
                    PortfolioPoint(
                        timestamp = System.currentTimeMillis() - (20 - i) * 60000,
                        totalValue = startValue + variance + (i * 5)
                    )
                }
                points.forEach { portfolioDao.insertPoint(it) }
            }
        }

        // Record portfolio value every 30 seconds
        viewModelScope.launch {
            while (true) {
                val total = sugarCoins.value + holdings.value.sumOf { holding ->
                    val currentPrice = stocks.value.find { it.symbol == holding.symbol }?.currentPrice ?: 0.0
                    holding.quantity * currentPrice
                }
                portfolioDao.insertPoint(PortfolioPoint(totalValue = total))
                delay(30000)
            }
        }
    }

    fun acceptDisclaimer() {
        viewModelScope.launch {
            userPrefs.setDisclaimerAccepted(true)
        }
    }

    fun bypassAuth() {
        _isBypassed.value = true
    }

    fun buyStock(ticker: StockTicker, quantity: Int) {
        viewModelScope.launch {
            val cost = ticker.currentPrice * quantity
            val currentBalance = sugarCoins.value
            if (currentBalance >= cost) {
                val newBalance = currentBalance - cost
                userPrefs.updateSugarCoins(newBalance)

                val existingHolding = holdingDao.getHoldingBySymbol(ticker.symbol)
                if (existingHolding != null) {
                    val newQuantity = existingHolding.quantity + quantity
                    val newAvgPrice = ((existingHolding.averagePurchasePrice * existingHolding.quantity) + cost) / newQuantity
                    holdingDao.updateHolding(existingHolding.copy(quantity = newQuantity, averagePurchasePrice = newAvgPrice))
                } else {
                    holdingDao.insertHolding(Holding(ticker.symbol, quantity, ticker.currentPrice))
                }

                transactionDao.insertTransaction(
                    Transaction(symbol = ticker.symbol, type = TransactionType.BUY, quantity = quantity, pricePerUnit = ticker.currentPrice)
                )
            }
        }
    }

    fun sellStock(ticker: StockTicker, quantity: Int) {
        viewModelScope.launch {
            val existingHolding = holdingDao.getHoldingBySymbol(ticker.symbol)
            if (existingHolding != null && existingHolding.quantity >= quantity) {
                val proceeds = ticker.currentPrice * quantity
                val newBalance = sugarCoins.value + proceeds
                userPrefs.updateSugarCoins(newBalance)

                val newQuantity = existingHolding.quantity - quantity
                if (newQuantity > 0) {
                    holdingDao.updateHolding(existingHolding.copy(quantity = newQuantity))
                } else {
                    holdingDao.deleteHolding(existingHolding)
                }

                transactionDao.insertTransaction(
                    Transaction(symbol = ticker.symbol, type = TransactionType.SELL, quantity = quantity, pricePerUnit = ticker.currentPrice)
                )
            }
        }
    }
}
