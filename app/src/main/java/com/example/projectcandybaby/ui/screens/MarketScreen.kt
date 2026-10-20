package com.example.projectcandybaby.ui.screens

import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.projectcandybaby.data.model.MarketEvent
import com.example.projectcandybaby.data.model.Sector
import com.example.projectcandybaby.data.model.StockTicker
import java.util.Locale

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MarketScreen(
    stocks: List<StockTicker>,
    serverType: String,
    marketEvents: List<MarketEvent>,
    onStockClick: (StockTicker) -> Unit,
    onBack: () -> Unit
) {
    var searchQuery by remember { mutableStateOf("") }
    var selectedSector by remember { mutableStateOf<Sector?>(null) }

    val filteredStocks = remember(stocks, searchQuery, selectedSector) {
        stocks.filter { stock ->
            val query = searchQuery.trim()
            val matchesQuery = query.isBlank() ||
                    stock.symbol.contains(query, ignoreCase = true) ||
                    stock.name.contains(query, ignoreCase = true) ||
                    stock.sector.displayName.contains(query, ignoreCase = true)
            val matchesSector = selectedSector == null || stock.sector == selectedSector
            matchesQuery && matchesSector
        }
    }

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
        Column(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
        ) {
            Column(modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp)) {
                OutlinedTextField(
                    value = searchQuery,
                    onValueChange = { searchQuery = it },
                    placeholder = { Text("Search 300+ stocks (e.g. FIZ, Pretzel, Cola)...") },
                    singleLine = true,
                    modifier = Modifier.fillMaxWidth()
                )

                Spacer(modifier = Modifier.height(8.dp))

                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .horizontalScroll(rememberScrollState()),
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    FilterChip(
                        selected = selectedSector == null,
                        onClick = { selectedSector = null },
                        label = { Text("All (${stocks.size})") }
                    )
                    Sector.entries.forEach { sector ->
                        FilterChip(
                            selected = selectedSector == sector,
                            onClick = { selectedSector = if (selectedSector == sector) null else sector },
                            label = { Text(sector.displayName) }
                        )
                    }
                }
            }

            LazyColumn(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(horizontal = 16.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp),
                contentPadding = PaddingValues(bottom = 16.dp)
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

                if (stocks.isEmpty()) {
                    item {
                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(200.dp),
                            contentAlignment = Alignment.Center
                        ) {
                            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                CircularProgressIndicator()
                                Spacer(modifier = Modifier.height(12.dp))
                                Text(
                                    "Loading Sugar Market stocks...",
                                    style = MaterialTheme.typography.bodyLarge
                                )
                            }
                        }
                    }
                } else if (filteredStocks.isEmpty()) {
                    item {
                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(200.dp),
                            contentAlignment = Alignment.Center
                        ) {
                            Text(
                                "No stocks found matching \"$searchQuery\"",
                                style = MaterialTheme.typography.bodyLarge
                            )
                        }
                    }
                } else {
                    items(filteredStocks) { stock ->
                        val priceChangePct = remember(stock) {
                            if (stock.priceHistory.size >= 2) {
                                val prev = stock.priceHistory[stock.priceHistory.size - 2]
                                if (prev > 0) ((stock.currentPrice - prev) / prev) * 100.0 else 0.0
                            } else if (stock.basePrice > 0) {
                                ((stock.currentPrice - stock.basePrice) / stock.basePrice) * 100.0
                            } else 0.0
                        }

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
                                    Column(modifier = Modifier.weight(1f)) {
                                        Row(verticalAlignment = Alignment.CenterVertically) {
                                            Text(
                                                stock.symbol,
                                                style = MaterialTheme.typography.titleMedium,
                                                fontWeight = FontWeight.Bold
                                            )
                                            Spacer(modifier = Modifier.width(8.dp))
                                            Surface(
                                                shape = MaterialTheme.shapes.extraSmall,
                                                color = MaterialTheme.colorScheme.surfaceVariant
                                            ) {
                                                Text(
                                                    stock.sector.displayName,
                                                    style = MaterialTheme.typography.labelSmall,
                                                    modifier = Modifier.padding(horizontal = 6.dp, vertical = 2.dp)
                                                )
                                            }
                                        }
                                        Text(
                                            stock.name,
                                            style = MaterialTheme.typography.bodySmall,
                                            maxLines = 1
                                        )
                                    }

                                    Column(horizontalAlignment = Alignment.End) {
                                        Text(
                                            "${String.format(Locale.US, "%.2f", stock.currentPrice)} SC",
                                            style = MaterialTheme.typography.titleMedium,
                                            fontWeight = FontWeight.Bold,
                                            color = MaterialTheme.colorScheme.primary
                                        )
                                        val changeText = if (priceChangePct >= 0)
                                            "+${String.format(Locale.US, "%.2f", priceChangePct)}%"
                                        else
                                            "${String.format(Locale.US, "%.2f", priceChangePct)}%"
                                        val changeColor = if (priceChangePct >= 0)
                                            MaterialTheme.colorScheme.primary
                                        else
                                            MaterialTheme.colorScheme.error

                                        Text(
                                            changeText,
                                            style = MaterialTheme.typography.labelMedium,
                                            fontWeight = FontWeight.Bold,
                                            color = changeColor
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
