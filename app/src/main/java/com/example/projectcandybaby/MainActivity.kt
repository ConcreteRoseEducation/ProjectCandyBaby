package com.example.projectcandybaby

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.example.projectcandybaby.ui.CandyBabyApp
import com.example.projectcandybaby.ui.MainViewModel
import com.example.projectcandybaby.ui.theme.ProjectCandyBabyTheme

class MainActivity : ComponentActivity() {
    private val viewModel: MainViewModel by viewModels {
        object : ViewModelProvider.Factory {
            override fun <T : ViewModel> create(modelClass: Class<T>): T {
                val app = application as CandyBabyApplication
                return MainViewModel(
                    app.database.holdingDao(),
                    app.database.transactionDao(),
                    app.database.portfolioDao(),
                    app.userPrefs,
                    app.authRepository,
                    app.firestoreMarketRepository,
                    app.marketEngine
                ) as T
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            ProjectCandyBabyTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background,
                ) {
                    CandyBabyApp(viewModel)
                }
            }
        }
    }
}