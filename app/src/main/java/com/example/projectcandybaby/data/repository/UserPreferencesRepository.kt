package com.example.projectcandybaby.data.repository

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.*
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "user_prefs")

class UserPreferencesRepository(private val context: Context) {
    private object PreferencesKeys {
        val DISCLAIMER_ACCEPTED = booleanPreferencesKey("disclaimer_accepted")
        val SUGAR_COINS = doublePreferencesKey("sugar_coins")
    }

    val disclaimerAcceptedFlow: Flow<Boolean> = context.dataStore.data
        .map { preferences ->
            preferences[PreferencesKeys.DISCLAIMER_ACCEPTED] ?: false
        }

    val sugarCoinsFlow: Flow<Double> = context.dataStore.data
        .map { preferences ->
            preferences[PreferencesKeys.SUGAR_COINS] ?: 1000.0 // Start with 1000 SC
        }

    suspend fun setDisclaimerAccepted(accepted: Boolean) {
        context.dataStore.edit { preferences ->
            preferences[PreferencesKeys.DISCLAIMER_ACCEPTED] = accepted
        }
    }

    suspend fun updateSugarCoins(balance: Double) {
        context.dataStore.edit { preferences ->
            preferences[PreferencesKeys.SUGAR_COINS] = balance
        }
    }
}
