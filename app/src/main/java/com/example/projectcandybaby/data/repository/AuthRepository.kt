package com.example.projectcandybaby.data.repository

import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume

class AuthRepository {
    private val auth: FirebaseAuth = FirebaseAuth.getInstance()
    
    private val _currentUser = MutableStateFlow<FirebaseUser?>(auth.currentUser)
    val currentUser: StateFlow<FirebaseUser?> = _currentUser.asStateFlow()

    init {
        auth.addAuthStateListener { firebaseAuth ->
            _currentUser.value = firebaseAuth.currentUser
        }
    }

    fun signOut() {
        auth.signOut()
    }

    /**
     * Headers for the Pi API. Guest mode uses X-Dev-User.
     * A signed-in Firebase user sends both a Bearer token (for AUTH_MODE=firebase)
     * and X-Dev-User (for AUTH_MODE=dev on the classroom Pi).
     */
    suspend fun marketHeaders(): Map<String, String> {
        val user = _currentUser.value
        if (user == null) {
            return mapOf(
                "X-Dev-User" to "guest",
                "X-Dev-Name" to "Guest",
            )
        }
        val headers = mutableMapOf(
            "X-Dev-User" to user.uid,
            "X-Dev-Name" to (user.displayName ?: user.email ?: user.uid),
        )
        val token = user.fetchIdToken()
        if (!token.isNullOrBlank()) {
            headers["Authorization"] = "Bearer $token"
        }
        return headers
    }

    private suspend fun FirebaseUser.fetchIdToken(): String? =
        suspendCancellableCoroutine { continuation ->
            getIdToken(false).addOnCompleteListener { task ->
                if (continuation.isActive) {
                    continuation.resume(if (task.isSuccessful) task.result?.token else null)
                }
            }
        }
}
