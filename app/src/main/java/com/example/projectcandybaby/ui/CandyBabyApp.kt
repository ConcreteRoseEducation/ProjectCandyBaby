package com.example.projectcandybaby.ui

import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.projectcandybaby.ui.components.ProfileOnboardingDialog
import com.example.projectcandybaby.ui.screens.DashboardScreen
import com.example.projectcandybaby.ui.screens.DisclaimerScreen
import com.example.projectcandybaby.ui.screens.LeaderboardScreen
import com.example.projectcandybaby.ui.screens.LearnScreen
import com.example.projectcandybaby.ui.screens.LoginScreen
import com.example.projectcandybaby.ui.screens.MarketDetailScreen
import com.example.projectcandybaby.ui.screens.MarketScreen

@Composable
fun CandyBabyApp(viewModel: MainViewModel) {
    val navController = rememberNavController()
    val currentUser by viewModel.currentUser.collectAsState()
    val disclaimerAccepted by viewModel.disclaimerAccepted.collectAsState()
    val sugarCoins by viewModel.sugarCoins.collectAsState()
    val holdings by viewModel.holdings.collectAsState()
    val stocks by viewModel.stocks.collectAsState()
    val portfolioHistory by viewModel.portfolioHistory.collectAsState()
    val sectorAllocation by viewModel.sectorAllocation.collectAsState()
    val profitLoss by viewModel.profitLoss.collectAsState()
    val serverType by viewModel.serverType.collectAsState()
    val marketEvents by viewModel.marketEvents.collectAsState()
    val leaderboard by viewModel.leaderboard.collectAsState()
    val userProfile by viewModel.userProfile.collectAsState()
    val profileError by viewModel.profileError.collectAsState()

    var showProfileDialog by remember { mutableStateOf(false) }

    val isGuest = currentUser == null

    LaunchedEffect(currentUser) {
        if (currentUser != null) {
            viewModel.refreshProfile()
        }
    }

    LaunchedEffect(userProfile, currentUser) {
        if (currentUser != null && (userProfile?.username.isNullOrBlank() || userProfile?.age == null)) {
            showProfileDialog = true
        } else {
            showProfileDialog = false
        }
    }

    if (showProfileDialog && currentUser != null) {
        ProfileOnboardingDialog(
            initialUsername = userProfile?.username ?: "",
            initialFullName = userProfile?.fullName ?: currentUser?.displayName ?: "",
            initialAge = userProfile?.age?.toString() ?: "",
            errorMessage = profileError,
            onSaveProfile = { username, fullName, age ->
                viewModel.updateUserProfile(username, fullName, age) { success ->
                    if (success) {
                        showProfileDialog = false
                    }
                }
            },
            onDismiss = { showProfileDialog = false }
        )
    }

    if (currentUser == null) {
        LoginScreen(
            onSignInClick = { viewModel.signInWithGoogleDemo() },
            onSupabaseSignIn = { email, password, onResult ->
                viewModel.signInWithSupabase(email, password, onResult)
            },
            onSupabaseSignUp = { email, password, name, onResult ->
                viewModel.signUpWithSupabase(email, password, name, onResult)
            }
        )
    } else if (!disclaimerAccepted) {
        DisclaimerScreen(onAccept = { viewModel.acceptDisclaimer() })
    } else {
        NavHost(navController = navController, startDestination = "dashboard") {
            composable("dashboard") {
                DashboardScreen(
                    sugarCoins = sugarCoins,
                    holdings = holdings,
                    portfolioHistory = portfolioHistory,
                    sectorAllocation = sectorAllocation,
                    profitLoss = profitLoss,
                    serverType = serverType,
                    marketEvents = marketEvents,
                    userName = userProfile?.username?.let { "@$it" } ?: currentUser?.displayName,
                    onSignInClick = { viewModel.signInWithGoogleDemo() },
                    onSignOutClick = { viewModel.signOut() },
                    onLeaderboardClick = {
                        viewModel.refreshLeaderboard()
                        navController.navigate("leaderboard")
                    },
                    onMarketClick = { navController.navigate("market") }
                )
            }
            composable("leaderboard") {
                LeaderboardScreen(
                    leaderboard = leaderboard,
                    currentUserName = userProfile?.username ?: currentUser?.displayName,
                    onRefresh = { viewModel.refreshLeaderboard() },
                    onBack = { navController.popBackStack() }
                )
            }
            composable("market") {
                MarketScreen(
                    stocks = stocks,
                    serverType = serverType,
                    marketEvents = marketEvents,
                    onStockClick = { stock -> navController.navigate("market/${stock.symbol}") },
                    onBack = { navController.popBackStack() }
                )
            }
            composable("market/{symbol}") { backStackEntry ->
                val symbol = backStackEntry.arguments?.getString("symbol")
                val stock = stocks.find { it.symbol == symbol }
                if (stock != null) {
                    val ownedShares = holdings.find { it.symbol == stock.symbol }?.quantity ?: 0
                    MarketDetailScreen(
                        stock = stock,
                        serverType = serverType,
                        sugarCoins = sugarCoins,
                        ownedShares = ownedShares,
                        isGuest = isGuest,
                        onSignInClick = { viewModel.signInWithGoogleDemo() },
                        onBuy = { qty -> viewModel.buyStock(stock, qty) },
                        onSell = { qty -> viewModel.sellStock(stock, qty) },
                        onBack = { navController.popBackStack() }
                    )
                }
            }
            composable("learn") {
                LearnScreen(onBack = { navController.popBackStack() })
            }
        }
    }
}
