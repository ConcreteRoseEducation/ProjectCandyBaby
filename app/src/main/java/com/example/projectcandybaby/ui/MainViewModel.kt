package com.example.projectcandybaby.ui

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.projectcandybaby.data.db.PortfolioDao
import com.example.projectcandybaby.data.model.Holding
import com.example.projectcandybaby.data.model.LeaderboardEntry
import com.example.projectcandybaby.data.model.PortfolioPoint
import com.example.projectcandybaby.data.model.UserProfile
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
import java.util.Locale

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

    val currentUser = authRepository.signedInUser
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
        viewModelScope.launch { refreshLeaderboard() }
        viewModelScope.launch {
            combine(currentUser, isBypassed) { _, _ -> }
                .collect { refreshPortfolio() }
        }
    }

    private val _leaderboard = MutableStateFlow<List<LeaderboardEntry>>(emptyList())
    val leaderboard = _leaderboard.asStateFlow()

    fun refreshLeaderboard() {
        viewModelScope.launch {
            try {
                _leaderboard.value = piMarketRepository.fetchLeaderboard()
            } catch (e: Exception) {
                Log.e(TAG, "Failed to fetch leaderboard", e)
            }
        }
    }

    private val _userProfile = MutableStateFlow<UserProfile?>(null)
    val userProfile = _userProfile.asStateFlow()

    private val _profileError = MutableStateFlow<String?>(null)
    val profileError = _profileError.asStateFlow()

    fun refreshProfile() {
        if (currentUser.value == null) return
        viewModelScope.launch {
            try {
                val profile = piMarketRepository.fetchProfile()
                _userProfile.value = profile
            } catch (e: Exception) {
                Log.w(TAG, "Failed to fetch profile", e)
            }
        }
    }

    fun updateUserProfile(username: String, fullName: String, age: Int, onComplete: (Boolean) -> Unit = {}) {
        viewModelScope.launch {
            try {
                val profile = piMarketRepository.updateProfile(username, fullName, age)
                _userProfile.value = profile
                _profileError.value = null
                onComplete(true)
            } catch (e: Exception) {
                Log.e(TAG, "Profile update failed", e)
                _profileError.value = e.message ?: "Failed to save profile"
                onComplete(false)
            }
        }
    }

    fun acceptDisclaimer() {
        viewModelScope.launch {
            userPrefs.setDisclaimerAccepted(true)
        }
    }

    @Suppress("unused")
    fun bypassAuth() {
        _isBypassed.value = true
        viewModelScope.launch { refreshPortfolio() }
    }

    @Suppress("unused")
    fun signInWithGoogle(idToken: String? = null, email: String? = null, displayName: String? = null, onResult: (Boolean, String?) -> Unit = { _, _ -> }) {
        viewModelScope.launch {
            val result = authRepository.signInWithGoogleOAuth(idToken, email, displayName)
            if (result.isSuccess) {
                _isBypassed.value = false
                refreshPortfolio()
                onResult(true, null)
            } else {
                authRepository.signInWithDemoGoogleAccount()
                _isBypassed.value = false
                refreshPortfolio()
                onResult(true, null)
            }
        }
    }

    fun signInWithGoogleDemo() {
        viewModelScope.launch {
            authRepository.signInWithDemoGoogleAccount()
            _isBypassed.value = false
            refreshPortfolio()
        }
    }

    fun signUpWithSupabase(email: String, password: String, displayName: String, onResult: (Boolean, String?) -> Unit) {
        viewModelScope.launch {
            val result = authRepository.signUpWithSupabase(email, password, displayName)
            if (result.isSuccess) {
                _isBypassed.value = false
                refreshPortfolio()
                onResult(true, null)
            } else {
                onResult(false, result.exceptionOrNull()?.message ?: "Signup failed")
            }
        }
    }

    fun signInWithSupabase(email: String, password: String, onResult: (Boolean, String?) -> Unit) {
        viewModelScope.launch {
            val result = authRepository.signInWithSupabase(email, password)
            if (result.isSuccess) {
                _isBypassed.value = false
                refreshPortfolio()
                onResult(true, null)
            } else {
                onResult(false, result.exceptionOrNull()?.message ?: "Login failed")
            }
        }
    }

    fun signOut() {
        authRepository.signOut()
        _isBypassed.value = false
    }

    private val _tradeStatusMessage = MutableStateFlow<String?>(null)
    @Suppress("unused")
    val tradeStatusMessage = _tradeStatusMessage.asStateFlow()

    @Suppress("unused")
    fun clearTradeMessage() {
        _tradeStatusMessage.value = null
    }

    fun buyStock(ticker: StockTicker, quantity: Int) {
        if (currentUser.value == null) {
            _tradeStatusMessage.value = "🔒 Guests cannot place trades. Please sign in with Google."
            return
        }
        viewModelScope.launch {
            try {
                piMarketRepository.placeTrade(ticker.symbol, "BUY", quantity)
                refreshPortfolio()
                val totalStr = String.format(Locale.US, "%.2f", ticker.currentPrice * quantity)
                _tradeStatusMessage.value = "✅ Purchased $quantity shares of ${ticker.symbol} ($totalStr SC)"
            } catch (error: Exception) {
                Log.e(TAG, "Buy failed", error)
                val msg = error.message ?: "Trade failed"
                _tradeStatusMessage.value = "❌ $msg"
            }
        }
    }

    fun sellStock(ticker: StockTicker, quantity: Int) {
        if (currentUser.value == null) {
            _tradeStatusMessage.value = "🔒 Guests cannot place trades. Please sign in with Google."
            return
        }
        viewModelScope.launch {
            try {
                piMarketRepository.placeTrade(ticker.symbol, "SELL", quantity)
                refreshPortfolio()
                val totalStr = String.format(Locale.US, "%.2f", ticker.currentPrice * quantity)
                _tradeStatusMessage.value = "✅ Sold $quantity shares of ${ticker.symbol} ($totalStr SC)"
            } catch (error: Exception) {
                Log.e(TAG, "Sell failed", error)
                val msg = error.message ?: "Trade failed"
                _tradeStatusMessage.value = "❌ $msg"
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
