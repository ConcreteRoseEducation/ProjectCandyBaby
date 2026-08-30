package com.example.projectcandybaby.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "holdings")
data class Holding(
    @PrimaryKey val symbol: String,
    val quantity: Int,
    val averagePurchasePrice: Double
)
