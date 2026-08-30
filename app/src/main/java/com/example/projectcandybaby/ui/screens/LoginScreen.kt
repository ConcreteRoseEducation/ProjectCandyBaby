package com.example.projectcandybaby.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp

@Composable
fun LoginScreen(
    onSignInClick: () -> Unit,
    onBypassClick: () -> Unit
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Welcome to CandyBaby Pro",
            style = MaterialTheme.typography.headlineMedium,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center
        )
        Spacer(modifier = Modifier.height(16.dp))
        Text(
            text = "Join the global sugar market! Sign in to sync your portfolio across devices.",
            textAlign = TextAlign.Center,
            style = MaterialTheme.typography.bodyLarge
        )
        Spacer(modifier = Modifier.height(48.dp))
        Button(
            onClick = onSignInClick,
            modifier = Modifier.fillMaxWidth().height(56.dp)
        ) {
            Text("Sign in with Google 🍭")
        }
        Spacer(modifier = Modifier.height(16.dp))
        TextButton(onClick = onBypassClick) {
            Text("Bypass Login (Guest Mode)")
        }
    }
}
