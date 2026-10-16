package com.example.projectcandybaby.ui

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.projectcandybaby.data.db.PortfolioDao
import com.example.projectcandybaby.data.model.Holding
import com.example.projectcandybaby.data.model.PortfolioPoint
import com.example.projectcandybaby.data.model.StockTicker
import com.example.projectcandybaby.data.repository.AuthRepository
import com.example.projectcandybaby.data.repository.PiMarketRepository
import com.example.projectcandybaby.data.repository.UserPreferencesRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class MainViewModel(
    private val portfolioDao: PortfolioDao,
    private val userPrefs: UserPreferencesRepository,
    private val authRepository: AuthRepository,
    private val piMarketRepository: PiMarketRepository,
) : ViewModel() {

    private val _isBypassed = MutableStateFlow(false)
    val isBypassed = _isBypassed.asStateFlow()

    private val _holdings = MutableStateFlow<List<Holding>>(emptyList())
    val holdings = _holdings.asStateFlow()

    private val _sugarCoins = MutableStateFlow(1000.0)
    val sugarCoins = _sugarCoins.asStateFlow()

    val currentUser = authRepository.currentUser
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
        viewModelScope.launch { refreshPortfolio() }
        viewModelScope.launch {
            combine(currentUser, isBypassed) { _, _ -> }
                .collect { refreshPortfolio() }
        }
    }

    fun acceptDisclaimer() {
        viewModelScope.launch {
            userPrefs.setDisclaimerAccepted(true)
        }
    }

    fun bypassAuth() {
        _isBypassed.value = true
        viewModelScope.launch { refreshPortfolio() }
    }

    fun buyStock(ticker: StockTicker, quantity: Int) {
        viewModelScope.launch {
            try {
                piMarketRepository.placeTrade(ticker.symbol, "BUY", quantity)
                refreshPortfolio()
            } catch (error: Exception) {
                Log.e(TAG, "Buy failed", error)
            }
        }
    }

    fun sellStock(ticker: StockTicker, quantity: Int) {
        viewModelScope.launch {
            try {
                piMarketRepository.placeTrade(ticker.symbol, "SELL", quantity)
                refreshPortfolio()
            } catch (error: Exception) {
                Log.e(TAG, "Sell failed", error)
            }
        }
    }

    private suspend fun refreshPortfolio() {
        try {
            val (coins, remoteHoldings) = piMarketRepository.fetchPortfolio()
            _sugarCoins.value = coins
            _holdings.value = remoteHoldings
            val total = coins + remoteHoldings.sumOf { holding ->
                val price = stocks.value.find { it.symbol == holding.symbol }?.currentPrice ?: 0.0
                holding.quantity * price
            }
            portfolioDao.insertPoint(PortfolioPoint(totalValue = total))
        } catch (error: Exception) {
            Log.e(TAG, "Failed to refresh portfolio from Pi", error)
        }
    }

    companion object {
        private const val TAG = "MainViewModel"
    }
}
