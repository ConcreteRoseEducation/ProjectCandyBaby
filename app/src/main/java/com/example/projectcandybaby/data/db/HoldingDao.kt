package com.example.projectcandybaby.data.db

import androidx.room.*
import com.example.projectcandybaby.data.model.Holding
import kotlinx.coroutines.flow.Flow

@Dao
interface HoldingDao {
    @Query("SELECT * FROM holdings")
    fun getAllHoldings(): Flow<List<Holding>>

    @Query("SELECT * FROM holdings WHERE symbol = :symbol")
    suspend fun getHoldingBySymbol(symbol: String): Holding?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertHolding(holding: Holding)

    @Update
    suspend fun updateHolding(holding: Holding)

    @Delete
    suspend fun deleteHolding(holding: Holding)
}
