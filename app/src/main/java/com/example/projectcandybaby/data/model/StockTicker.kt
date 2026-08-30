package com.example.projectcandybaby.data.model

data class StockTicker(
    val symbol: String,
    val name: String,
    val sector: Sector,
    val basePrice: Double,
    val currentPrice: Double,
    val description: String,
    val priceHistory: List<Double> = emptyList()
)
