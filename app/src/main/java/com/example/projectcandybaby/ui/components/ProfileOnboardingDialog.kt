package com.example.projectcandybaby.ui.components

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProfileOnboardingDialog(
    initialUsername: String = "",
    initialFullName: String = "",
    initialAge: String = "",
    errorMessage: String? = null,
    onSaveProfile: (username: String, fullName: String, age: Int) -> Unit,
    onDismiss: () -> Unit
) {
    var username by remember { mutableStateOf(initialUsername) }
    var fullName by remember { mutableStateOf(initialFullName) }
    var ageStr by remember { mutableStateOf(initialAge) }
    var localError by remember { mutableStateOf<String?>(null) }

    AlertDialog(
        onDismissRequest = onDismiss,
        shape = RoundedCornerShape(24.dp),
        title = {
            Text(
                text = "Setup Your Trader Profile 🍬",
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold
            )
        },
        text = {
            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(10.dp)
            ) {
                Text(
                    text = "Create your username, enter your name and age to complete registration.",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )

                OutlinedTextField(
                    value = username,
                    onValueChange = {
                        username = it.lowercase().filter { c -> c.isLetterOrDigit() || c == '_' }
                    },
                    label = { Text("Username") },
                    placeholder = { Text("e.g. sugar_master99") },
                    singleLine = true,
                    modifier = Modifier.fillMaxWidth()
                )

                OutlinedTextField(
                    value = fullName,
                    onValueChange = { fullName = it },
                    label = { Text("Full Name") },
                    placeholder = { Text("e.g. Alex Smith") },
                    singleLine = true,
                    modifier = Modifier.fillMaxWidth()
                )

                OutlinedTextField(
                    value = ageStr,
                    onValueChange = { ageStr = it.filter { c -> c.isDigit() } },
                    label = { Text("Age") },
                    placeholder = { Text("e.g. 16") },
                    keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
                    singleLine = true,
                    modifier = Modifier.fillMaxWidth()
                )

                Card(
                    colors = CardDefaults.cardColors(
                        containerColor = MaterialTheme.colorScheme.secondaryContainer
                    ),
                    modifier = Modifier.fillMaxWidth()
                ) {
                    Column(modifier = Modifier.padding(10.dp)) {
                        Text(
                            text = "🛡️ Ad Privacy Notice: Age is required for age-appropriate ad targeting and strict COPPA privacy compliance.",
                            style = MaterialTheme.typography.labelSmall
                        )
                    }
                }

                val activeError = errorMessage ?: localError
                if (activeError != null) {
                    Text(
                        text = activeError,
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.error,
                        fontWeight = FontWeight.Bold
                    )
                }
            }
        },
        confirmButton = {
            Button(
                onClick = {
                    val ageInt = ageStr.toIntOrNull()
                    if (username.length < 3) {
                        localError = "Username must be at least 3 characters"
                    } else if (fullName.isBlank()) {
                        localError = "Please enter your full name"
                    } else if (ageInt == null || ageInt < 5 || ageInt > 120) {
                        localError = "Please enter a valid age (5 - 120)"
                    } else {
                        localError = null
                        onSaveProfile(username.trim(), fullName.trim(), ageInt)
                    }
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Save Profile & Start Trading")
            }
        },
        dismissButton = {
            TextButton(
                onClick = onDismiss,
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Skip for Now")
            }
        }
    )
}
