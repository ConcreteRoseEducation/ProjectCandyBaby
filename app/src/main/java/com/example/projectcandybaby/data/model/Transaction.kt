package com.example.projectcandybaby.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "transactions")
data class Transaction(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val symbol: String,
    val type: TransactionType,
    val quantity: Int,
    val pricePerUnit: Double,
    val timestamp: Long = System.currentTimeMillis()
)

enum class TransactionType {
    BUY, SELL
}
