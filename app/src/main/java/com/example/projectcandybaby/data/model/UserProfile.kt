package com.example.projectcandybaby.data.model

data class UserProfile(
    val id: Long = 0,
    val displayName: String = "",
    val username: String? = null,
    val fullName: String? = null,
    val age: Int? = null,
    val isChildAccount: Boolean = false,
    val sugarCoins: Double = 1000.0
)
