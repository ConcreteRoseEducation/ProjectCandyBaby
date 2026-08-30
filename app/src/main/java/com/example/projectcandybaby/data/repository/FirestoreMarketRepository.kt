package com.example.projectcandybaby.data.repository

import com.example.projectcandybaby.data.model.Sector
import com.example.projectcandybaby.data.model.StockTicker
import com.google.firebase.firestore.FirebaseFirestore
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow

class FirestoreMarketRepository {
    private val db = FirebaseFirestore.getInstance()

    fun getGlobalStocks(): Flow<List<StockTicker>> = callbackFlow {
        val subscription = db.collection("stocks")
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    close(error)
                    return@addSnapshotListener
                }
                
                val stocks = snapshot?.documents?.mapNotNull { doc ->
                    val symbol = doc.getString("symbol") ?: return@mapNotNull null
                    val name = doc.getString("name") ?: ""
                    val sectorStr = doc.getString("sector") ?: "FIZZY_DRINKS"
                    val sector = Sector.valueOf(sectorStr)
                    val basePrice = doc.getDouble("basePrice") ?: 0.0
                    val currentPrice = doc.getDouble("currentPrice") ?: 0.0
                    val description = doc.getString("description") ?: ""
                    val history = doc.get("priceHistory") as? List<Double> ?: emptyList()
                    
                    StockTicker(symbol, name, sector, basePrice, currentPrice, description, history)
                } ?: emptyList()
                
                trySend(stocks)
            }
        awaitClose { subscription.remove() }
    }
}
