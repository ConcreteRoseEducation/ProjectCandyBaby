package com.example.projectcandybaby

import android.app.Application
import androidx.room.Room
import com.example.projectcandybaby.data.db.CandyBabyDatabase
import com.example.projectcandybaby.data.repository.AuthRepository
import com.example.projectcandybaby.data.repository.FirestoreMarketRepository
import com.example.projectcandybaby.data.repository.UserPreferencesRepository
import com.example.projectcandybaby.logic.MarketEngine

class CandyBabyApplication : Application() {
    val database by lazy {
        Room.databaseBuilder(this, CandyBabyDatabase::class.java, "candybaby_db")
            .fallbackToDestructiveMigration(dropAllTables = true)
            .build()
    }
    val userPrefs by lazy { UserPreferencesRepository(this) }
    val authRepository by lazy { AuthRepository() }
    val firestoreMarketRepository by lazy { FirestoreMarketRepository() }
    val marketEngine by lazy { MarketEngine() }
}
