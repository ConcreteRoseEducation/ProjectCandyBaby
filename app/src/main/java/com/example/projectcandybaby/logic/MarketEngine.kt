package com.example.projectcandybaby.logic

import com.example.projectcandybaby.data.model.Sector
import com.example.projectcandybaby.data.model.StockTicker
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlin.random.Random

class MarketEngine {
    private val _stocks = MutableStateFlow<List<StockTicker>>(initialStocks())
    val stocks: StateFlow<List<StockTicker>> = _stocks.asStateFlow()

    fun tick() {
        val currentStocks = _stocks.value
        val updatedStocks = currentStocks.map { stock ->
            val volatility = 0.05 // 5% max swing
            val changePercent = (Random.nextDouble() * 2 - 1) * volatility
            val newPrice = stock.currentPrice * (1 + changePercent)
            stock.copy(currentPrice = newPrice.coerceAtLeast(0.01))
        }
        _stocks.value = updatedStocks
    }

    private fun initialStocks(): List<StockTicker> = listOf(
        StockTicker("FIZ", "Fizzy Drinks Corp", Sector.FIZZY_DRINKS, 10.0, 10.0, "Leader in carbonated sugar water."),
        StockTicker("KRSP", "Krispy Kingdom", Sector.KRISPY_KINGDOM, 25.0, 25.0, "The finest potato-based snacks."),
        StockTicker("COCO", "Cocoa Corp", Sector.COCOA_CORP, 50.0, 50.0, "Premium dark and milk chocolate."),
        StockTicker("GUM", "GumTech", Sector.GUM_TECH, 100.0, 100.0, "Chewing the future of connectivity."),
        StockTicker("SHK", "Sugar Shack Chain", Sector.SUGAR_SHACK, 40.0, 40.0, "Your local source for donuts and shakes."),
        StockTicker("CNDY", "Candy Mart", Sector.CANDY_MART, 15.0, 15.0, "Retail giant for all things sweet.")
    )
}
