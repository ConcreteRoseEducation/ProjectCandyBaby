package com.example.projectcandybaby.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.projectcandybaby.data.model.MarketEvent
import com.example.projectcandybaby.data.model.StockTicker

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MarketScreen(
    stocks: List<StockTicker>,
    serverType: String,
    marketEvents: List<MarketEvent>,
    onStockClick: (StockTicker) -> Unit,
    onBack: () -> Unit
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Sugar Market") },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Text("←")
                    }
                },
                actions = {
                    Surface(
                        shape = MaterialTheme.shapes.extraSmall,
                        color = if (serverType == "private") MaterialTheme.colorScheme.tertiaryContainer else MaterialTheme.colorScheme.secondaryContainer,
                        modifier = Modifier.padding(end = 12.dp)
                    ) {
                        Text(
                            text = if (serverType == "private") "🔒 Private" else "🌐 Public",
                            style = MaterialTheme.typography.labelMedium,
                            fontWeight = FontWeight.Bold,
                            modifier = Modifier.padding(horizontal = 8.dp, vertical = 4.dp)
                        )
                    }
                }
            )
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            if (marketEvents.isNotEmpty()) {
                item {
                    val latest = marketEvents.first()
                    Card(
                        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.primaryContainer),
                        modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp)
                    ) {
                        Column(modifier = Modifier.padding(12.dp)) {
                            Text(
                                "📢 ${latest.title}",
                                style = MaterialTheme.typography.titleSmall,
                                fontWeight = FontWeight.Bold
                            )
                            Spacer(modifier = Modifier.height(4.dp))
                            Text(latest.narrative, style = MaterialTheme.typography.bodySmall)
                        }
                    }
                }
            }

            items(stocks) { stock ->
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    onClick = { onStockClick(stock) }
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Column {
                                Text(stock.symbol, style = MaterialTheme.typography.titleMedium, fontWeight = FontWeight.Bold)
                                Text(stock.name, style = MaterialTheme.typography.bodySmall)
                            }
                            Text(
                                "${String.format("%.2f", stock.currentPrice)} SC",
                                style = MaterialTheme.typography.titleLarge,
                                color = MaterialTheme.colorScheme.primary
                            )
                        }
                    }
                }
            }
        }
    }
}
