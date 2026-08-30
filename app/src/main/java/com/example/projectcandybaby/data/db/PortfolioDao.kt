package com.example.projectcandybaby.data.db

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.example.projectcandybaby.data.model.PortfolioPoint
import kotlinx.coroutines.flow.Flow

@Dao
interface PortfolioDao {
    @Query("SELECT * FROM portfolio_history ORDER BY timestamp ASC")
    fun getHistory(): Flow<List<PortfolioPoint>>

    @Insert
    suspend fun insertPoint(point: PortfolioPoint)

    @Query("DELETE FROM portfolio_history WHERE timestamp < :threshold")
    suspend fun clearOldHistory(threshold: Long)
}
