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
import com.example.projectcandybaby.data.repository.PiMarketRepository
import com.example.projectcandybaby.data.repository.UserPreferencesRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import java.util.Locale

class MainViewModel(
    private val holdingDao: HoldingDao,
    private val transactionDao: TransactionDao,
    private val portfolioDao: PortfolioDao,
    private val userPrefs: UserPreferencesRepository,
    piMarketRepository: PiMarketRepository,
) : ViewModel() {

    val holdings: StateFlow<List<Holding>> = holdingDao.getAllHoldings()
        .stateIn(viewModelScope, SharingStarted.Eagerly, emptyList())

    val sugarCoins: StateFlow<Double> = userPrefs.sugarCoinsFlow
        .stateIn(viewModelScope, SharingStarted.Eagerly, 1000.0)

    val stocks = piMarketRepository.getGlobalStocks()
        .stateIn(viewModelScope, SharingStarted.Lazily, emptyList())

    val serverType = piMarketRepository.serverType
    val marketEvents = piMarketRepository.marketEvents

    val disclaimerAccepted = userPrefs.disclaimerAcceptedFlow
        .stateIn(viewModelScope, SharingStarted.Lazily, false)

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
        hList.associate { h ->
            val stock = sList.find { it.symbol == h.symbol }
            val currentVal = (stock?.currentPrice ?: 0.0) * h.quantity
            val purchaseVal = h.averagePurchasePrice * h.quantity
            h.symbol to (currentVal - purchaseVal)
        }
    }.stateIn(viewModelScope, SharingStarted.Lazily, emptyMap())

    init {
        viewModelScope.launch {
            combine(sugarCoins, holdings, stocks) { coins, hList, sList ->
                val holdingsVal = hList.sumOf { h ->
                    val price = sList.find { it.symbol == h.symbol }?.currentPrice ?: 0.0
                    h.quantity * price
                }
                coins + holdingsVal
            }.collect { totalVal ->
                portfolioDao.insertPoint(PortfolioPoint(totalValue = totalVal))
            }
        }
    }

    fun acceptDisclaimer() {
        viewModelScope.launch {
            userPrefs.setDisclaimerAccepted(true)
        }
    }

    private val _tradeStatusMessage = MutableStateFlow<String?>(null)
    val tradeStatusMessage = _tradeStatusMessage.asStateFlow()

    fun clearTradeMessage() {
        _tradeStatusMessage.value = null
    }

    fun buyStock(ticker: StockTicker, quantity: Int) {
        viewModelScope.launch {
            val totalCost = ticker.currentPrice * quantity
            val currentCoins = sugarCoins.value
            if (currentCoins < totalCost) {
                _tradeStatusMessage.value = "❌ Insufficient Sugar Coins to buy $quantity shares."
                return@launch
            }

            userPrefs.updateSugarCoins(currentCoins - totalCost)

            transactionDao.insertTransaction(
                Transaction(
                    symbol = ticker.symbol,
                    type = TransactionType.BUY,
                    quantity = quantity,
                    pricePerUnit = ticker.currentPrice,
                )
            )

            val existingHolding = holdingDao.getHoldingBySymbol(ticker.symbol)
            if (existingHolding != null) {
                val newQty = existingHolding.quantity + quantity
                val newAvg = ((existingHolding.quantity * existingHolding.averagePurchasePrice) + totalCost) / newQty
                holdingDao.updateHolding(existingHolding.copy(quantity = newQty, averagePurchasePrice = newAvg))
            } else {
                holdingDao.insertHolding(
                    Holding(
                        symbol = ticker.symbol,
                        quantity = quantity,
                        averagePurchasePrice = ticker.currentPrice,
                    )
                )
            }

            val totalStr = String.format(Locale.US, "%.2f", totalCost)
            _tradeStatusMessage.value = "✅ Purchased $quantity shares of ${ticker.symbol} ($totalStr SC)"
        }
    }

    fun sellStock(ticker: StockTicker, quantity: Int) {
        viewModelScope.launch {
            val existingHolding = holdingDao.getHoldingBySymbol(ticker.symbol)
            val ownedQty = existingHolding?.quantity ?: 0
            if (ownedQty < quantity) {
                _tradeStatusMessage.value = "❌ You don't own $quantity shares of ${ticker.symbol}."
                return@launch
            }

            val totalRevenue = ticker.currentPrice * quantity
            val currentCoins = sugarCoins.value

            userPrefs.updateSugarCoins(currentCoins + totalRevenue)

            transactionDao.insertTransaction(
                Transaction(
                    symbol = ticker.symbol,
                    type = TransactionType.SELL,
                    quantity = quantity,
                    pricePerUnit = ticker.currentPrice,
                )
            )

            val newQty = ownedQty - quantity
            if (newQty > 0) {
                holdingDao.updateHolding(existingHolding!!.copy(quantity = newQty))
            } else {
                holdingDao.deleteHolding(existingHolding!!)
            }

            val totalStr = String.format(Locale.US, "%.2f", totalRevenue)
            _tradeStatusMessage.value = "✅ Sold $quantity shares of ${ticker.symbol} ($totalStr SC)"
        }
    }
}
