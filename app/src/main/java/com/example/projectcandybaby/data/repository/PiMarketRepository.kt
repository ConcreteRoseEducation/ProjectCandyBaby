package com.example.projectcandybaby.data.repository

import android.util.Log
import com.example.projectcandybaby.BuildConfig
import com.example.projectcandybaby.data.model.Holding
import com.example.projectcandybaby.data.model.LeaderboardEntry
import com.example.projectcandybaby.data.model.MarketEvent
import com.example.projectcandybaby.data.model.UserProfile
import com.example.projectcandybaby.data.model.Sector
import com.example.projectcandybaby.data.model.StockTicker
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.delay
import kotlin.time.Duration.Companion.milliseconds
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import okhttp3.Response
import okhttp3.WebSocket
import okhttp3.WebSocketListener
import org.json.JSONArray
import org.json.JSONObject
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicReference

class PiMarketRepository(
    private val authRepository: AuthRepository,
) {
    private val client = OkHttpClient.Builder()
        .connectTimeout(10, TimeUnit.SECONDS)
        .readTimeout(0, TimeUnit.SECONDS)
        .pingInterval(20, TimeUnit.SECONDS)
        .build()

    private val httpClient = OkHttpClient.Builder()
        .connectTimeout(10, TimeUnit.SECONDS)
        .readTimeout(15, TimeUnit.SECONDS)
        .build()

    private val _serverType = MutableStateFlow("public")
    val serverType: StateFlow<String> = _serverType.asStateFlow()

    private val _marketEvents = MutableStateFlow<List<MarketEvent>>(emptyList())
    val marketEvents: StateFlow<List<MarketEvent>> = _marketEvents.asStateFlow()

    fun getGlobalStocks(): Flow<List<StockTicker>> = callbackFlow {
        val latest = AtomicReference<List<StockTicker>>(emptyList())
        val socketRef = AtomicReference<WebSocket?>(null)

        fun publish(next: List<StockTicker>) {
            latest.set(next)
            trySend(next)
        }

        val job = launch(Dispatchers.IO) {
            var backoff = 1_000L
            while (true) {
                try {
                    publish(fetchStocksWithHistory())
                    fetchMarketEvents()
                    backoff = 1_000L
                } catch (error: Exception) {
                    Log.e(TAG, "Failed to load stocks from Pi at ${BuildConfig.MARKET_BASE_URL}", error)
                }

                val closed = CompletableDeferred<Unit>()
                val request = Request.Builder().url(websocketUrl()).build()
                val socket = client.newWebSocket(request, object : WebSocketListener() {
                    override fun onOpen(webSocket: WebSocket, response: Response) {
                        Log.i(TAG, "Connected to Pi market stream")
                    }

                    override fun onMessage(webSocket: WebSocket, text: String) {
                        try {
                            val json = JSONObject(text)
                            val type = json.optString("type")
                            if (type == "tick") {
                                val parsed = parseTick(json, latest.get())
                                if (parsed != null) {
                                    publish(parsed)
                                }
                            } else if (type == "event") {
                                launch(Dispatchers.IO) {
                                    fetchMarketEvents()
                                }
                            }
                        } catch (e: Exception) {
                            Log.w(TAG, "Failed to parse WS message", e)
                        }
                    }

                    override fun onClosing(webSocket: WebSocket, code: Int, reason: String) {
                        webSocket.close(code, reason)
                    }

                    override fun onClosed(webSocket: WebSocket, code: Int, reason: String) {
                        closed.complete(Unit)
                    }

                    override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
                        Log.w(TAG, "Market stream dropped", t)
                        closed.complete(Unit)
                    }
                })
                socketRef.set(socket)
                closed.await()
                socketRef.set(null)
                delay(backoff.milliseconds)
                backoff = (backoff * 2).coerceAtMost(15_000L)
            }
        }

        awaitClose {
            job.cancel()
            socketRef.get()?.cancel()
        }
    }

    suspend fun fetchPortfolio(): Pair<Double, List<Holding>> = withContext(Dispatchers.IO) {
        val json = authorizedGet("/portfolio")
        val coins = json.getJSONObject("user").getDouble("sugarCoins")
        val holdings = json.getJSONArray("holdings").mapObjects { item ->
            Holding(
                symbol = item.getString("symbol"),
                quantity = item.getInt("quantity"),
                averagePurchasePrice = item.optDouble(
                    "avg_purchase_price",
                    item.optDouble("averagePurchasePrice"),
                ),
            )
        }
        coins to holdings
    }

    suspend fun fetchProfile(): UserProfile = withContext(Dispatchers.IO) {
        val json = authorizedGet("/profile")
        val obj = json.getJSONObject("profile")
        UserProfile(
            id = obj.optLong("id"),
            displayName = obj.optString("displayName", ""),
            username = obj.optString("username").ifBlank { null },
            fullName = obj.optString("fullName").ifBlank { null },
            age = if (obj.has("age") && !obj.isNull("age")) obj.getInt("age") else null,
            isChildAccount = obj.optBoolean("isChildAccount", false),
            sugarCoins = obj.optDouble("sugarCoins", 1000.0)
        )
    }

    suspend fun updateProfile(username: String?, fullName: String?, age: Int?): UserProfile = withContext(Dispatchers.IO) {
        val body = JSONObject().apply {
            if (!username.isNullOrBlank()) put("username", username.trim())
            if (!fullName.isNullOrBlank()) put("fullName", fullName.trim())
            if (age != null) put("age", age)
        }.toString().toRequestBody(JSON)

        val json = authorizedRequest(
            Request.Builder()
                .url("${BuildConfig.MARKET_BASE_URL}/profile")
                .post(body)
        )
        val obj = json.getJSONObject("profile")
        UserProfile(
            id = obj.optLong("id"),
            displayName = obj.optString("displayName", ""),
            username = obj.optString("username").ifBlank { null },
            fullName = obj.optString("fullName").ifBlank { null },
            age = if (obj.has("age") && !obj.isNull("age")) obj.getInt("age") else null,
            isChildAccount = obj.optBoolean("isChildAccount", false),
            sugarCoins = obj.optDouble("sugarCoins", 1000.0)
        )
    }

    suspend fun fetchLeaderboard(): List<LeaderboardEntry> = withContext(Dispatchers.IO) {
        try {
            val json = publicGet("/leaderboard")
            val array = json.getJSONArray("leaderboard")
            var currentRank = 1
            array.mapObjects { item ->
                LeaderboardEntry(
                    rank = currentRank++,
                    displayName = item.optString("display_name", "Anonymous Trader"),
                    totalValue = item.optDouble("total_value", item.optDouble("sugar_coins", 1000.0)),
                    sugarCoins = item.optDouble("sugar_coins", 1000.0)
                )
            }
        } catch (e: Exception) {
            Log.w(TAG, "Failed to fetch leaderboard", e)
            emptyList()
        }
    }

    suspend fun fetchMarketEvents(): List<MarketEvent> = withContext(Dispatchers.IO) {
        try {
            val json = publicGet("/events")
            val events = json.getJSONArray("events").mapObjects { item ->
                MarketEvent(
                    id = item.optLong("id"),
                    title = item.optString("title"),
                    narrative = item.optString("narrative"),
                    type = item.optString("type", "event"),
                    scope = item.optString("scope", "market"),
                    magnitude = item.optDouble("magnitude", 0.0),
                    durationTicks = item.optInt("duration_ticks", 0),
                    remainingTicks = item.optInt("remaining_ticks", 0),
                )
            }
            _marketEvents.value = events
            events
        } catch (e: Exception) {
            Log.w(TAG, "Failed to fetch market events", e)
            emptyList()
        }
    }

    suspend fun placeTrade(symbol: String, type: String, quantity: Int) = withContext(Dispatchers.IO) {
        val body = JSONObject()
            .put("symbol", symbol)
            .put("type", type)
            .put("quantity", quantity)
            .toString()
            .toRequestBody(JSON)
        authorizedRequest(
            Request.Builder()
                .url("${BuildConfig.MARKET_BASE_URL}/trades")
                .post(body),
        )
        Unit
    }

    private suspend fun fetchStocksWithHistory(): List<StockTicker> = withContext(Dispatchers.IO) {
        val listJson = publicGet("/stocks")
        val sType = listJson.optString("serverType", "public")
        _serverType.value = sType

        listJson.getJSONArray("stocks").mapObjects { parseStock(it) }
    }

    private fun websocketUrl(): String {
        return BuildConfig.MARKET_BASE_URL
            .replace("https://", "wss://")
            .replace("http://", "ws://") + "/ws"
    }

    private fun parseTick(json: JSONObject, current: List<StockTicker>): List<StockTicker>? {
        if (json.optString("type") != "tick") {
            return null
        }
        val updates = json.optJSONArray("stocks") ?: return null
        val bySymbol = current.associateBy { it.symbol }.toMutableMap()
        for (index in 0 until updates.length()) {
            val item = updates.getJSONObject(index)
            val symbol = item.getString("symbol")
            val price = item.getDouble("currentPrice")
            val existing = bySymbol[symbol]
            if (existing != null) {
                bySymbol[symbol] = existing.copy(
                    currentPrice = price,
                    priceHistory = existing.priceHistory + price,
                )
            } else {
                val key = item.optString("sectorKey", "").ifBlank { item.optString("sector", "") }
                val sector = Sector.entries.find { s ->
                    s.name.equals(key, ignoreCase = true) || s.displayName.equals(key, ignoreCase = true)
                } ?: Sector.FIZZY_DRINKS

                bySymbol[symbol] = StockTicker(
                    symbol = symbol,
                    name = item.optString("name", symbol),
                    sector = sector,
                    basePrice = price,
                    currentPrice = price,
                    description = "",
                    priceHistory = listOf(price)
                )
            }
        }
        return bySymbol.values.sortedBy { it.symbol }
    }

    private fun parseStock(item: JSONObject): StockTicker {
        val key = item.optString("sectorKey", "").ifBlank { item.optString("sector", "") }
        val sector = Sector.entries.find { s ->
            s.name.equals(key, ignoreCase = true) || s.displayName.equals(key, ignoreCase = true)
        } ?: Sector.FIZZY_DRINKS

        return StockTicker(
            symbol = item.getString("symbol"),
            name = item.optString("name"),
            sector = sector,
            basePrice = item.optDouble("basePrice"),
            currentPrice = item.optDouble("currentPrice"),
            description = item.optString("description"),
            priceHistory = item.optJSONArray("priceHistory").toDoubleList()
        )
    }

    private fun publicGet(path: String): JSONObject {
        val request = Request.Builder().url("${BuildConfig.MARKET_BASE_URL}$path").get().build()
        httpClient.newCall(request).execute().use { response ->
            val body = response.body?.string().orEmpty()
            if (!response.isSuccessful) {
                throw IllegalStateException("GET $path failed: ${response.code} $body")
            }
            return JSONObject(body)
        }
    }

    private suspend fun authorizedGet(path: String): JSONObject {
        return authorizedRequest(
            Request.Builder()
                .url("${BuildConfig.MARKET_BASE_URL}$path")
                .get(),
        )
    }

    private suspend fun authorizedRequest(builder: Request.Builder): JSONObject {
        authRepository.marketHeaders().forEach { (key, value) ->
            builder.addHeader(key, value)
        }
        httpClient.newCall(builder.build()).execute().use { response ->
            val body = response.body?.string().orEmpty()
            if (!response.isSuccessful) {
                val message = runCatching { JSONObject(body).optString("error") }.getOrNull()
                throw IllegalStateException(message?.ifBlank { null } ?: "Request failed: ${response.code}")
            }
            return if (body.isBlank()) JSONObject() else JSONObject(body)
        }
    }

    private inline fun <T> JSONArray.mapObjects(transform: (JSONObject) -> T): List<T> {
        return (0 until length()).map { transform(getJSONObject(it)) }
    }

    private fun JSONArray?.toDoubleList(): List<Double> {
        if (this == null) return emptyList()
        return (0 until length()).map { optDouble(it) }
    }

    companion object {
        private const val TAG = "PiMarket"
        private val JSON = "application/json; charset=utf-8".toMediaType()
    }
}
