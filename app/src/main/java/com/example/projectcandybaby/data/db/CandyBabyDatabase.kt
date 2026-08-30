package com.example.projectcandybaby.data.db

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.projectcandybaby.data.model.Holding
import com.example.projectcandybaby.data.model.PortfolioPoint
import com.example.projectcandybaby.data.model.Transaction

@Database(entities = [Holding::class, Transaction::class, PortfolioPoint::class], version = 2, exportSchema = false)
abstract class CandyBabyDatabase : RoomDatabase() {
    abstract fun holdingDao(): HoldingDao
    abstract fun transactionDao(): TransactionDao
    abstract fun portfolioDao(): PortfolioDao
}
