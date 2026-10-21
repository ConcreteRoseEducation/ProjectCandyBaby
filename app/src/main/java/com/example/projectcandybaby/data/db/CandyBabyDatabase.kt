package com.example.projectcandybaby.data.db

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.projectcandybaby.data.model.PortfolioPoint

@Database(entities = [PortfolioPoint::class], version = 3, exportSchema = false)
abstract class CandyBabyDatabase : RoomDatabase() {
    abstract fun portfolioDao(): PortfolioDao
}
