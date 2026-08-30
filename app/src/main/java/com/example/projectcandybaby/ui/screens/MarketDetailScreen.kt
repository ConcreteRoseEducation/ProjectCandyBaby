package com.example.projectcandybaby.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.projectcandybaby.data.model.StockTicker
import com.example.projectcandybaby.ui.components.StockChart

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MarketDetailScreen(
    stock: StockTicker,
    onBuy: (Int) -> Unit,
    onBack: () -> Unit
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(stock.name) },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Text("←")
                    }
                }
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
                .padding(16.dp)
        ) {
            Text(
                text = "${String.format("%.2f", stock.currentPrice)} SC",
                style = MaterialTheme.typography.headlineLarge,
                fontWeight = FontWeight.Bold,
                color = MaterialTheme.colorScheme.primary
            )
            Text(stock.symbol, style = MaterialTheme.typography.titleMedium)
            
            Spacer(modifier = Modifier.height(24.dp))
            
            Text("Price History", style = MaterialTheme.typography.titleLarge, fontWeight = FontWeight.Bold)
            Spacer(modifier = Modifier.height(8.dp))
            
            if (stock.priceHistory.isNotEmpty()) {
                StockChart(priceHistory = stock.priceHistory)
            } else {
                Box(modifier = Modifier.fillMaxWidth().height(200.dp)) {
                    Text("No history available yet.")
                }
            }
            
            Spacer(modifier = Modifier.height(24.dp))
            Text(stock.description, style = MaterialTheme.typography.bodyLarge)
            
            Spacer(modifier = Modifier.weight(1f))
            
            Button(
                onClick = { onBuy(1) },
                modifier = Modifier.fillMaxWidth().height(56.dp)
            ) {
                Text("Buy 1 Share")
            }
        }
    }
}
