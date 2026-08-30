package com.example.projectcandybaby.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.projectcandybaby.data.model.StockTicker

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MarketScreen(
    stocks: List<StockTicker>,
    onStockClick: (StockTicker) -> Unit,
    onBack: () -> Unit
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Candy Market") },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Text("←")
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
            items(stocks) { stock ->
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    onClick = { onStockClick(stock) }
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween
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
