package com.example.projectcandybaby.data.model

data class LeaderboardEntry(
    val rank: Int = 0,
    val displayName: String,
    val totalValue: Double,
    val sugarCoins: Double
)
