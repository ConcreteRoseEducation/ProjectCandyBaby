package com.example.projectcandybaby.data.db

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.example.projectcandybaby.data.model.Transaction
import kotlinx.coroutines.flow.Flow

@Dao
interface TransactionDao {
    @Query("SELECT * FROM transactions ORDER BY timestamp DESC")
    fun getAllTransactions(): Flow<List<Transaction>>

    @Insert
    suspend fun insertTransaction(transaction: Transaction)
}
