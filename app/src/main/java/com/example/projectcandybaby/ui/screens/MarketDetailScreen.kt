package com.example.projectcandybaby.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.projectcandybaby.data.model.StockTicker
import com.example.projectcandybaby.ui.components.StockChart

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MarketDetailScreen(
    stock: StockTicker,
    serverType: String,
    ownedShares: Int,
    onBuy: (Int) -> Unit,
    onSell: (Int) -> Unit,
    onBack: () -> Unit
) {
    var selectedQuantity by remember { mutableStateOf(1) }

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
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column {
                    Text(
                        text = "${String.format("%.2f", stock.currentPrice)} SC",
                        style = MaterialTheme.typography.headlineLarge,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.primary
                    )
                    Text(stock.symbol, style = MaterialTheme.typography.titleMedium)
                }

                Surface(
                    shape = MaterialTheme.shapes.small,
                    color = if (serverType == "private") MaterialTheme.colorScheme.tertiaryContainer else MaterialTheme.colorScheme.secondaryContainer
                ) {
                    Text(
                        text = if (serverType == "private") "🔒 Private (Raw Values)" else "🌐 Public Server",
                        style = MaterialTheme.typography.labelMedium,
                        fontWeight = FontWeight.Bold,
                        modifier = Modifier.padding(horizontal = 10.dp, vertical = 6.dp)
                    )
                }
            }

            Spacer(modifier = Modifier.height(12.dp))

            Card(
                colors = CardDefaults.cardColors(
                    containerColor = MaterialTheme.colorScheme.surfaceVariant
                ),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(12.dp)) {
                    Text(
                        text = if (serverType == "private")
                            "⚡ Real-time Market: In Private Server mode, player buys/sells directly move stock prices using raw values!"
                        else
                            "⚡ Real-time Market: Player buy and sell orders drive price movements in real time.",
                        style = MaterialTheme.typography.bodySmall
                    )
                    if (ownedShares > 0) {
                        Spacer(modifier = Modifier.height(4.dp))
                        Text(
                            text = "You own $ownedShares shares of ${stock.symbol}",
                            style = MaterialTheme.typography.labelMedium,
                            fontWeight = FontWeight.Bold,
                            color = MaterialTheme.colorScheme.primary
                        )
                    }
                }
            }

            Spacer(modifier = Modifier.height(16.dp))

            Text("Price History", style = MaterialTheme.typography.titleLarge, fontWeight = FontWeight.Bold)
            Spacer(modifier = Modifier.height(8.dp))

            if (stock.priceHistory.isNotEmpty()) {
                StockChart(priceHistory = stock.priceHistory)
            } else {
                Box(
                    modifier = Modifier.fillMaxWidth().height(160.dp),
                    contentAlignment = Alignment.Center
                ) {
                    Text("No history available yet.")
                }
            }

            Spacer(modifier = Modifier.height(12.dp))
            Text(stock.description, style = MaterialTheme.typography.bodyMedium)

            Spacer(modifier = Modifier.weight(1f))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceEvenly,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text("Quantity:", style = MaterialTheme.typography.titleMedium)
                listOf(1, 5, 10).forEach { qty ->
                    FilterChip(
                        selected = selectedQuantity == qty,
                        onClick = { selectedQuantity = qty },
                        label = { Text("$qty") }
                    )
                }
            }

            Spacer(modifier = Modifier.height(8.dp))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                Button(
                    onClick = { onBuy(selectedQuantity) },
                    modifier = Modifier.weight(1f).height(50.dp)
                ) {
                    Text("Buy $selectedQuantity")
                }

                Button(
                    onClick = { onSell(selectedQuantity) },
                    enabled = ownedShares >= selectedQuantity,
                    colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.error),
                    modifier = Modifier.weight(1f).height(50.dp)
                ) {
                    Text("Sell $selectedQuantity")
                }
            }
        }
    }
}
