package com.example.projectcandybaby.data.repository

import com.example.projectcandybaby.BuildConfig
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.auth.GoogleAuthProvider
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject
import kotlin.coroutines.resume

data class SugarUser(
    val uid: String,
    val displayName: String,
    val email: String? = null,
    val isGuest: Boolean = false
)

class AuthRepository {
    private val httpClient = OkHttpClient.Builder().build()
    private val auth: FirebaseAuth = FirebaseAuth.getInstance()

    private var supabaseToken: String? = null
    
    private val _signedInUser = MutableStateFlow<SugarUser?>(
        auth.currentUser?.let {
            SugarUser(it.uid, it.displayName ?: it.email ?: "Google User", it.email)
        }
    )
    val signedInUser: StateFlow<SugarUser?> = _signedInUser.asStateFlow()

    init {
        auth.addAuthStateListener { firebaseAuth ->
            val user = firebaseAuth.currentUser
            if (user != null && supabaseToken == null) {
                _signedInUser.value = SugarUser(
                    user.uid,
                    user.displayName ?: user.email ?: "Google User",
                    user.email
                )
            }
        }
    }

    fun signOut() {
        supabaseToken = null
        runCatching { auth.signOut() }
        _signedInUser.value = null
    }

    suspend fun signUpWithSupabase(email: String, password: String, displayName: String): Result<SugarUser> = withContext(Dispatchers.IO) {
        try {
            val json = JSONObject()
                .put("email", email)
                .put("password", password)
                .put("displayName", displayName)

            val request = Request.Builder()
                .url("${BuildConfig.MARKET_BASE_URL}/auth/signup")
                .post(json.toString().toRequestBody("application/json".toMediaType()))
                .build()

            httpClient.newCall(request).execute().use { response ->
                val bodyStr = response.body?.string().orEmpty()
                val resObj = JSONObject(bodyStr)
                if (!response.isSuccessful) {
                    val errMsg = resObj.optString("error", "Signup failed (${response.code})")
                    return@withContext Result.failure(Exception(errMsg))
                }
                val token = resObj.optString("token", "")
                if (token.isNotBlank()) {
                    supabaseToken = token
                }
                val userObj = resObj.optJSONObject("user")
                val sugarUser = SugarUser(
                    uid = userObj?.optString("id") ?: resObj.optJSONObject("supabaseUser")?.optString("id") ?: email,
                    displayName = userObj?.optString("displayName") ?: displayName,
                    email = email
                )
                _signedInUser.value = sugarUser
                Result.success(sugarUser)
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    suspend fun signInWithSupabase(email: String, password: String): Result<SugarUser> = withContext(Dispatchers.IO) {
        try {
            val json = JSONObject()
                .put("email", email)
                .put("password", password)

            val request = Request.Builder()
                .url("${BuildConfig.MARKET_BASE_URL}/auth/login")
                .post(json.toString().toRequestBody("application/json".toMediaType()))
                .build()

            httpClient.newCall(request).execute().use { response ->
                val bodyStr = response.body?.string().orEmpty()
                val resObj = JSONObject(bodyStr)
                if (!response.isSuccessful) {
                    val errMsg = resObj.optString("error", "Login failed (${response.code})")
                    return@withContext Result.failure(Exception(errMsg))
                }
                val token = resObj.optString("token", "")
                if (token.isNotBlank()) {
                    supabaseToken = token
                }
                val userObj = resObj.optJSONObject("user")
                val sugarUser = SugarUser(
                    uid = userObj?.optString("id") ?: resObj.optJSONObject("supabaseUser")?.optString("id") ?: email,
                    displayName = userObj?.optString("displayName") ?: email.substringBefore("@"),
                    email = email
                )
                _signedInUser.value = sugarUser
                Result.success(sugarUser)
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    suspend fun signInWithGoogleOAuth(idToken: String? = null, email: String? = null, displayName: String? = null): Result<SugarUser> = withContext(Dispatchers.IO) {
        try {
            val json = JSONObject()
            if (!idToken.isNullOrBlank()) json.put("idToken", idToken)
            if (!email.isNullOrBlank()) json.put("email", email)
            if (!displayName.isNullOrBlank()) json.put("displayName", displayName)

            val request = Request.Builder()
                .url("${BuildConfig.MARKET_BASE_URL}/auth/google")
                .post(json.toString().toRequestBody("application/json".toMediaType()))
                .build()

            httpClient.newCall(request).execute().use { response ->
                val bodyStr = response.body?.string().orEmpty()
                val resObj = JSONObject(bodyStr)
                if (!response.isSuccessful) {
                    val errMsg = resObj.optString("error", "Google Auth failed (${response.code})")
                    return@withContext Result.failure(Exception(errMsg))
                }
                val token = resObj.optString("token", "")
                if (token.isNotBlank()) {
                    supabaseToken = token
                }
                val userObj = resObj.optJSONObject("user")
                val resolvedName = userObj?.optString("displayName") ?: displayName ?: email?.substringBefore("@") ?: "Google User"
                val sugarUser = SugarUser(
                    uid = userObj?.optString("id") ?: resObj.optJSONObject("supabaseUser")?.optString("id") ?: email ?: "google_user",
                    displayName = resolvedName,
                    email = email
                )
                _signedInUser.value = sugarUser
                Result.success(sugarUser)
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    @Suppress("unused")
    suspend fun signInWithGoogleCredential(idToken: String): Result<SugarUser> = suspendCancellableCoroutine { continuation ->
        val credential = GoogleAuthProvider.getCredential(idToken, null)
        auth.signInWithCredential(credential).addOnCompleteListener { task ->
            if (continuation.isActive) {
                if (task.isSuccessful && task.result?.user != null) {
                    val firebaseUser = task.result!!.user!!
                    val user = SugarUser(
                        firebaseUser.uid,
                        firebaseUser.displayName ?: firebaseUser.email ?: "Google User",
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

    fun signInWithDemoGoogleAccount(name: String = "Google User", email: String = "trader@sugarmarket.app") {
        val cleanEmail = if (email.isBlank()) "trader@sugarmarket.app" else email.trim().lowercase()
        val stableUid = "google_" + cleanEmail.replace("@", "_at_").replace(".", "_")
        val user = SugarUser(
            uid = stableUid,
            displayName = name,
            email = cleanEmail
        )
        _signedInUser.value = user
        runCatching { auth.signInAnonymously() }
    }

    /**
     * Headers for the Sugar Market API.
     * A signed-in user sends their UID and Supabase / Bearer token.
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
        if (!supabaseToken.isNullOrBlank()) {
            headers["Authorization"] = "Bearer $supabaseToken"
            return headers
        }
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
