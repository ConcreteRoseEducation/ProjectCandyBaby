package com.example.projectcandybaby.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "portfolio_history")
data class PortfolioPoint(
    @PrimaryKey val timestamp: Long = System.currentTimeMillis(),
    val totalValue: Double
)
