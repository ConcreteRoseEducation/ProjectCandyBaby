package com.example.projectcandybaby.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun LearnScreen(onBack: () -> Unit) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Sugar Tips") },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Text("←")
                    }
                }
            )
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            item {
                TipCard("What is a Stock?", "A stock represents a small piece of ownership in a company. When the company does well, your piece becomes more valuable!")
            }
            item {
                TipCard("Buy Low, Sell High", "The goal is to buy shares when they are cheap and sell them when they are expensive to make a profit in Sugar Coins.")
            }
            item {
                TipCard("Diversification", "Don't put all your sugar in one bowl! Buying stocks in different sectors (like Fizzy Drinks AND GumTech) helps protect you if one sector crashes.")
            }
        }
    }
}

@Composable
fun TipCard(title: String, content: String) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(title, style = MaterialTheme.typography.titleMedium, fontWeight = FontWeight.Bold)
            Spacer(modifier = Modifier.height(8.dp))
            Text(content, style = MaterialTheme.typography.bodyMedium)
        }
    }
}
