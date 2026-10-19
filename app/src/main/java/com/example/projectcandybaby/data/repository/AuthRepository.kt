package com.example.projectcandybaby.data.repository

import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.auth.GoogleAuthProvider
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume

data class SugarUser(
    val uid: String,
    val displayName: String,
    val email: String? = null,
    val isGuest: Boolean = false
)

class AuthRepository {
    private val auth: FirebaseAuth = FirebaseAuth.getInstance()
    
    private val _signedInUser = MutableStateFlow<SugarUser?>(
        auth.currentUser?.let {
            SugarUser(it.uid, it.displayName ?: it.email ?: "Google Trader", it.email)
        }
    )
    val signedInUser: StateFlow<SugarUser?> = _signedInUser.asStateFlow()

    init {
        auth.addAuthStateListener { firebaseAuth ->
            val user = firebaseAuth.currentUser
            if (user != null) {
                _signedInUser.value = SugarUser(
                    user.uid,
                    user.displayName ?: user.email ?: "Google Trader",
                    user.email
                )
            }
        }
    }

    fun signOut() {
        runCatching { auth.signOut() }
        _signedInUser.value = null
    }

    suspend fun signInWithGoogleCredential(idToken: String): Result<SugarUser> = suspendCancellableCoroutine { continuation ->
        val credential = GoogleAuthProvider.getCredential(idToken, null)
        auth.signInWithCredential(credential).addOnCompleteListener { task ->
            if (continuation.isActive) {
                if (task.isSuccessful && task.result?.user != null) {
                    val firebaseUser = task.result!!.user!!
                    val user = SugarUser(
                        firebaseUser.uid,
                        firebaseUser.displayName ?: firebaseUser.email ?: "Google Trader",
                        firebaseUser.email
                    )
                    _signedInUser.value = user
                    continuation.resume(Result.success(user))
                } else {
                    continuation.resume(Result.failure(task.exception ?: Exception("Google Sign-In failed")))
                }
            }
        }
    }

    fun signInWithDemoGoogleAccount(name: String = "Google Trader") {
        val user = SugarUser(
            uid = "google_trader_" + (System.currentTimeMillis() % 100000),
            displayName = name,
            email = "trader@sugarmarket.app"
        )
        _signedInUser.value = user
        runCatching { auth.signInAnonymously() }
    }

    /**
     * Headers for the Sugar Market API. Guest mode uses X-Dev-User = guest.
     * A signed-in user sends their UID and Bearer token.
     */
    suspend fun marketHeaders(): Map<String, String> {
        val user = _signedInUser.value
        if (user == null || user.isGuest) {
            return mapOf(
                "X-Dev-User" to "guest",
                "X-Dev-Name" to "Guest",
            )
        }
        val headers = mutableMapOf(
            "X-Dev-User" to user.uid,
            "X-Dev-Name" to user.displayName,
        )
        val firebaseUser = auth.currentUser
        if (firebaseUser != null) {
            val token = firebaseUser.fetchIdToken()
            if (!token.isNullOrBlank()) {
                headers["Authorization"] = "Bearer $token"
            }
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
