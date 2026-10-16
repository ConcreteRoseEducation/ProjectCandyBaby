package com.example.projectcandybaby.data.model

data class MarketEvent(
    val id: Long = 0,
    val title: String,
    val narrative: String,
    val type: String = "event",
    val scope: String = "market",
    val magnitude: Double = 0.0,
    val durationTicks: Int = 0,
    val remainingTicks: Int = 0,
)
