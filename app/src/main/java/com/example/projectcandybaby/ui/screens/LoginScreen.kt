package com.example.projectcandybaby.ui.screens

import androidx.compose.animation.animateColor
import androidx.compose.animation.core.*
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.scale
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlin.random.Random

@Composable
fun LoginScreen(
    onSignInClick: () -> Unit,
    onBypassClick: () -> Unit
) {
    val infiniteTransition = rememberInfiniteTransition(label = "backgroundAnimation")

    // Animated color shifting background
    val color1 by infiniteTransition.animateColor(
        initialValue = Color(0xFF2A1B36),
        targetValue = Color(0xFF4A184D),
        animationSpec = infiniteRepeatable(
            animation = tween(4000, easing = LinearEasing),
            repeatMode = RepeatMode.Reverse
        ),
        label = "c1"
    )

    val color2 by infiniteTransition.animateColor(
        initialValue = Color(0xFF1B0B24),
        targetValue = Color(0xFF2E1136),
        animationSpec = infiniteRepeatable(
            animation = tween(5000, easing = LinearEasing),
            repeatMode = RepeatMode.Reverse
        ),
        label = "c2"
    )

    // Title pulse/scale animation
    val scaleAnim by infiniteTransition.animateFloat(
        initialValue = 0.96f,
        targetValue = 1.04f,
        animationSpec = infiniteRepeatable(
            animation = tween(1500, easing = FastOutSlowInEasing),
            repeatMode = RepeatMode.Reverse
        ),
        label = "scale"
    )

    // Floating particle positions animation
    val floatAnim by infiniteTransition.animateFloat(
        initialValue = 0f,
        targetValue = 1f,
        animationSpec = infiniteRepeatable(
            animation = tween(8000, easing = LinearEasing),
            repeatMode = RepeatMode.Restart
        ),
        label = "float"
    )

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(
                brush = Brush.verticalGradient(
                    colors = listOf(color1, color2, Color(0xFF120619))
                )
            )
    ) {
        // Floating sugar / candy particles in background
        Canvas(modifier = Modifier.fillMaxSize()) {
            val canvasWidth = size.width
            val canvasHeight = size.height

            val random = Random(42)
            repeat(30) { index ->
                val x = random.nextFloat() * canvasWidth
                val speed = 0.3f + (index % 5) * 0.15f
                val baseY = random.nextFloat() * canvasHeight
                val currentY = (baseY - (floatAnim * canvasHeight * speed)) % canvasHeight
                val finalY = if (currentY < 0) currentY + canvasHeight else currentY

                val radius = 3f + (index % 4) * 2f
                val alpha = 0.2f + (index % 3) * 0.25f

                drawCircle(
                    color = Color(0xFFFF7EB6).copy(alpha = alpha),
                    radius = radius,
                    center = Offset(x, finalY)
                )
            }
        }

        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(24.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Spacer(modifier = Modifier.weight(1f))

            // Animated App Logo / Emoji Badge
            Text(
                text = "🍬 🍭 🍩",
                fontSize = 42.sp,
                modifier = Modifier.scale(scaleAnim)
            )

            Spacer(modifier = Modifier.height(12.dp))

            // Fun animated Sugar Market title
            Text(
                text = "SUGAR MARKET",
                fontSize = 38.sp,
                fontWeight = FontWeight.ExtraBold,
                fontFamily = FontFamily.SansSerif,
                textAlign = TextAlign.Center,
                modifier = Modifier.scale(scaleAnim),
                style = LocalTextStyle.current.copy(
                    brush = Brush.linearGradient(
                        colors = listOf(
                            Color(0xFFFF7EB6),
                            Color(0xFFFFB7B2),
                            Color(0xFF7DFFB3)
                        )
                    )
                )
            )

            Spacer(modifier = Modifier.height(8.dp))

            Text(
                text = "The Real-Time Classroom Candy Economy",
                color = Color(0xFFD7C4D8),
                fontSize = 15.sp,
                fontWeight = FontWeight.Medium,
                textAlign = TextAlign.Center
            )

            Spacer(modifier = Modifier.weight(1f))

            // Main Glassmorphism Entry Card
            Card(
                shape = RoundedCornerShape(24.dp),
                colors = CardDefaults.cardColors(
                    containerColor = Color(0x22FFFFFF)
                ),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier
                        .padding(20.dp)
                        .fillMaxWidth(),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text(
                        text = "Sign in to Trade",
                        style = MaterialTheme.typography.titleLarge,
                        fontWeight = FontWeight.Bold,
                        color = Color.White
                    )

                    Spacer(modifier = Modifier.height(6.dp))

                    Text(
                        text = "Google Account required to place buys & sells and save your portfolio.",
                        style = MaterialTheme.typography.bodySmall,
                        color = Color(0xFFD7C4D8),
                        textAlign = TextAlign.Center
                    )

                    Spacer(modifier = Modifier.height(24.dp))

                    // PRIMARY ENTRY WAY: Google OAuth Sign-In Button
                    Button(
                        onClick = onSignInClick,
                        colors = ButtonDefaults.buttonColors(
                            containerColor = Color.White,
                            contentColor = Color(0xFF1B0B24)
                        ),
                        shape = RoundedCornerShape(16.dp),
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(56.dp)
                    ) {
                        Row(
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.Center
                        ) {
                            Text(
                                text = "G ",
                                fontWeight = FontWeight.Black,
                                fontSize = 20.sp,
                                color = Color(0xFF4285F4)
                            )
                            Spacer(modifier = Modifier.width(6.dp))
                            Text(
                                text = "Sign in with Google",
                                fontWeight = FontWeight.Bold,
                                fontSize = 16.sp
                            )
                        }
                    }

                    Spacer(modifier = Modifier.height(16.dp))

                    // SECONDARY DISCRETE OPTION: Guest Read-Only Mode
                    TextButton(
                        onClick = onBypassClick
                    ) {
                        Text(
                            text = "Browse Market as Guest (Read Only) →",
                            color = Color(0xFFFF7EB6),
                            fontWeight = FontWeight.Medium,
                            fontSize = 14.sp
                        )
                    }
                }
            }

            Spacer(modifier = Modifier.height(32.dp))
        }
    }
}
