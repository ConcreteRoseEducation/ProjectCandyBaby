package com.example.projectcandybaby.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.projectcandybaby.data.model.Holding
import com.example.projectcandybaby.ui.components.AllocationChart
import com.example.projectcandybaby.ui.components.StockChart

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DashboardScreen(
    sugarCoins: Double,
    holdings: List<Holding>,
    portfolioHistory: List<Double>,
    sectorAllocation: Map<String, Double>,
    profitLoss: Map<String, Double>,
    onMarketClick: () -> Unit
) {
    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(title = { Text("CandyBaby Dashboard") })
        },
        floatingActionButton = {
            ExtendedFloatingActionButton(onClick = onMarketClick) {
                Text("Go to Market 🍬")
            }
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
                .padding(16.dp)
        ) {
            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.secondaryContainer)
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text("Current Balance", style = MaterialTheme.typography.labelLarge)
                        Text(
                            "${String.format("%.2f", sugarCoins)} SC",
                            style = MaterialTheme.typography.headlineLarge,
                            fontWeight = FontWeight.Bold
                        )
                    }
                }
            }
            
            item { Spacer(modifier = Modifier.height(24.dp)) }

            item {
                Text("Portfolio Performance", style = MaterialTheme.typography.titleLarge, fontWeight = FontWeight.Bold)
                Spacer(modifier = Modifier.height(8.dp))
                if (portfolioHistory.isNotEmpty()) {
                    StockChart(priceHistory = portfolioHistory)
                } else {
                    Box(modifier = Modifier.fillMaxWidth().height(200.dp)) {
                        Text("Tracking performance... check back soon!")
                    }
                }
            }

            if (sectorAllocation.isNotEmpty()) {
                item {
                    Spacer(modifier = Modifier.height(24.dp))
                    Text("Sector Allocation (SC)", style = MaterialTheme.typography.titleLarge, fontWeight = FontWeight.Bold)
                    Spacer(modifier = Modifier.height(8.dp))
                    AllocationChart(data = sectorAllocation)
                }
            }

            if (profitLoss.isNotEmpty()) {
                item {
                    Spacer(modifier = Modifier.height(24.dp))
                    Text("Profit / Loss by Stock (SC)", style = MaterialTheme.typography.titleLarge, fontWeight = FontWeight.Bold)
                    Spacer(modifier = Modifier.height(8.dp))
                    AllocationChart(data = profitLoss)
                }
            }

            item {
                Spacer(modifier = Modifier.height(24.dp))
                Text("Your Holdings", style = MaterialTheme.typography.titleLarge, fontWeight = FontWeight.Bold)
                Spacer(modifier = Modifier.height(8.dp))
            }
            
            if (holdings.isEmpty()) {
                item {
                    Text("You don't own any candy stocks yet. Head to the market to start investing!")
                }
            } else {
                items(holdings) { holding ->
                    ListItem(
                        headlineContent = { Text(holding.symbol) },
                        supportingContent = { Text("${holding.quantity} shares") },
                        trailingContent = { 
                            Text("Avg: ${String.format("%.2f", holding.averagePurchasePrice)} SC")
                        }
                    )
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DashboardPreview() {
    DashboardScreen(
        sugarCoins = 1250.50,
        holdings = listOf(
            Holding("FIZ", 10, 10.5),
            Holding("GUM", 5, 95.0)
        ),
        portfolioHistory = listOf(1000.0, 1100.0, 1050.0, 1250.5),
        sectorAllocation = mapOf("Fizzy Drinks" to 200.0, "GumTech" to 500.0),
        profitLoss = mapOf("FIZ" to 20.0, "GUM" to -50.0),
        onMarketClick = {}
    )
}
