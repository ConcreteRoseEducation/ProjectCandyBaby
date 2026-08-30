package com.example.projectcandybaby.ui

import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.projectcandybaby.ui.screens.DashboardScreen
import com.example.projectcandybaby.ui.screens.DisclaimerScreen
import com.example.projectcandybaby.ui.screens.LearnScreen
import com.example.projectcandybaby.ui.screens.LoginScreen
import com.example.projectcandybaby.ui.screens.MarketDetailScreen
import com.example.projectcandybaby.ui.screens.MarketScreen

@Composable
fun CandyBabyApp(viewModel: MainViewModel) {
    val navController = rememberNavController()
    val currentUser by viewModel.currentUser.collectAsState()
    val isBypassed by viewModel.isBypassed.collectAsState()
    val disclaimerAccepted by viewModel.disclaimerAccepted.collectAsState()
    val sugarCoins by viewModel.sugarCoins.collectAsState()
    val holdings by viewModel.holdings.collectAsState()
    val stocks by viewModel.stocks.collectAsState()
    val portfolioHistory by viewModel.portfolioHistory.collectAsState()
    val sectorAllocation by viewModel.sectorAllocation.collectAsState()
    val profitLoss by viewModel.profitLoss.collectAsState()

    if (currentUser == null && !isBypassed) {
        LoginScreen(
            onSignInClick = { /* TODO: Launch Google Sign In */ },
            onBypassClick = { viewModel.bypassAuth() }
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
                    onMarketClick = { navController.navigate("market") }
                )
            }
            composable("market") {
                MarketScreen(
                    stocks = stocks,
                    onStockClick = { stock -> navController.navigate("market/${stock.symbol}") },
                    onBack = { navController.popBackStack() }
                )
            }
            composable("market/{symbol}") { backStackEntry ->
                val symbol = backStackEntry.arguments?.getString("symbol")
                val stock = stocks.find { it.symbol == symbol }
                if (stock != null) {
                    MarketDetailScreen(
                        stock = stock,
                        onBuy = { qty -> viewModel.buyStock(stock, qty) },
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
