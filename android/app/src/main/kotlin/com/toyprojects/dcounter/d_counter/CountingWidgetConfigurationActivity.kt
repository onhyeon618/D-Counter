package com.toyprojects.dcounter.d_counter

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.RadioButton
import androidx.compose.material3.RadioButtonDefaults
import androidx.compose.material3.Slider
import androidx.compose.material3.SliderDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.BlendMode
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.ColorFilter
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.appwidget.updateAll
import es.antonborri.home_widget.HomeWidgetPlugin
import kotlinx.coroutines.launch

class CountingWidgetConfigurationActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        val resultValue = Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
        setResult(Activity.RESULT_CANCELED, resultValue)

        val widgetData = HomeWidgetPlugin.getData(this.applicationContext)
        val initialColorMode = widgetData.getInt("${Keys.colorMode.name}_$appWidgetId", 0)
        val initialBackgroundAlpha = widgetData.getFloat("${Keys.backgroundAlpha.name}}_$appWidgetId", 1f)
        val initialTextAlpha = widgetData.getFloat("${Keys.textAlpha.name}}_$appWidgetId", 1f)

        setContent {
            val scope = rememberCoroutineScope()

            ConfigurationScreen(
                context = this.applicationContext,
                appWidgetId = appWidgetId,
                initialColorMode = initialColorMode,
                initialBackgroundAlpha = initialBackgroundAlpha,
                initialTextAlpha = initialTextAlpha,
                onSave = { context ->
                    setResult(Activity.RESULT_OK, resultValue)
                    scope.launch {
                        CountingWidget().updateAll(context)
                    }
                    finish()
                },
                onCancel = {
                    finish()
                })
        }
    }
}

@Composable
private fun ConfigurationScreen(
    context: Context,
    appWidgetId: Int,
    initialColorMode: Int,
    initialBackgroundAlpha: Float,
    initialTextAlpha: Float,
    onSave: (Context) -> Unit = {},
    onCancel: () -> Unit = {},
) {
    var selectedColorMode by remember { mutableIntStateOf(initialColorMode) }
    var backgroundAlpha by remember { mutableFloatStateOf(initialBackgroundAlpha) }
    var textAlpha by remember { mutableFloatStateOf(initialTextAlpha) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .background(Color.White)
            .padding(16.dp)
    ) {
        Text(
            text = "디데이 위젯 설정",
            color = Color.Black,
            fontWeight = FontWeight.Bold,
            fontSize = 20.sp
        )
        Spacer(Modifier.height(16.dp))
        Box(
            modifier = Modifier
                .clip(shape = RoundedCornerShape(20.dp))
                .fillMaxWidth()
                .wrapContentHeight(),
            contentAlignment = Alignment.Center
        ) {
            Image(
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(1.2f),
                painter = painterResource(R.drawable.grid_background),
                contentDescription = null,
                contentScale = ContentScale.Crop,
                colorFilter = ColorFilter.tint(
                    color = Color(0xFFFFEFEF),
                    blendMode = BlendMode.Darken,
                )
            )
            Box(
                modifier = Modifier
                    .clip(shape = RoundedCornerShape(20.dp))
                    .wrapContentSize(unbounded = true)
                    .aspectRatio(1.75f)
                    .background(
                        (if (selectedColorMode == 0) Color.White else Color.Black).copy(alpha = backgroundAlpha)
                    )
                    .padding(24.dp),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = "D-Day",
                    color = (if (selectedColorMode == 0) Color.Black else Color.White).copy(alpha = textAlpha),
                    fontWeight = FontWeight.Bold,
                    fontSize = 50.sp,
                    fontFamily = FontFamily(Font(R.font.jikji))
                )
            }
        }
        Spacer(Modifier.height(28.dp))
        Text(
            text = "위젯 색상",
            color = Color.Black,
            fontWeight = FontWeight.Bold,
            fontSize = 14.sp
        )
        Spacer(Modifier.height(12.dp))
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .clickable(onClick = { selectedColorMode = 0 }),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            RadioButton(
                selected = selectedColorMode == 0,
                onClick = { selectedColorMode = 0 },
                colors = RadioButtonDefaults.colors(selectedColor = Color(0xFFF48FB1))
            )
            Spacer(Modifier.width(8.dp))
            Text(
                text = "라이트 모드",
                color = Color.Black,
                fontWeight = FontWeight.Normal,
                fontSize = 16.sp,
            )
        }
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .clickable(onClick = { selectedColorMode = 1 }),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            RadioButton(
                selected = selectedColorMode == 1,
                onClick = { selectedColorMode = 1 },
                colors = RadioButtonDefaults.colors(selectedColor = Color(0xFFF48FB1))
            )
            Spacer(Modifier.width(8.dp))
            Text(
                text = "다크 모드",
                color = Color.Black,
                fontWeight = FontWeight.Normal,
                fontSize = 16.sp,
            )
        }
        Spacer(Modifier.height(28.dp))
        Text(
            text = "배경 투명도",
            color = Color.Black,
            fontWeight = FontWeight.Bold,
            fontSize = 14.sp
        )
        Spacer(Modifier.height(12.dp))
        Slider(
            value = backgroundAlpha,
            onValueChange = { backgroundAlpha = it },
            valueRange = 0f..1f,
            colors = SliderDefaults.colors(
                thumbColor = Color(0xFFF48FB1),
                activeTrackColor = Color(0xFFF48FB1),
                inactiveTrackColor = Color(0xFFFDE8EC),
            )
        )
        Spacer(Modifier.height(28.dp))
        Text(
            text = "글자 투명도",
            color = Color.Black,
            fontWeight = FontWeight.Bold,
            fontSize = 14.sp
        )
        Spacer(Modifier.height(12.dp))
        Slider(
            value = textAlpha,
            onValueChange = { textAlpha = it },
            valueRange = 0f..1f,
            colors = SliderDefaults.colors(
                thumbColor = Color(0xFFF48FB1),
                activeTrackColor = Color(0xFFF48FB1),
                inactiveTrackColor = Color(0xFFFDE8EC),
            )
        )
        Spacer(Modifier.height(32.dp))
        Row(
            modifier = Modifier.fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Box(
                modifier = Modifier
                    .weight(1f)
                    .fillMaxWidth()
                    .clickable { onCancel() },
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = "취소",
                    color = Color.Gray,
                    fontSize = 16.sp,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(vertical = 8.dp)
                )
            }
            Box(
                modifier = Modifier
                    .weight(1f)
                    .fillMaxWidth()
                    .clickable {
                        val prefs = HomeWidgetPlugin.getData(context).edit()

                        prefs.putInt("${Keys.colorMode.name}_$appWidgetId", selectedColorMode)
                        prefs.putFloat("${Keys.backgroundAlpha.name}}_$appWidgetId", backgroundAlpha)
                        prefs.putFloat("${Keys.textAlpha.name}}_$appWidgetId", textAlpha)

                        prefs.apply()
                        onSave(context)
                    },
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = "저장",
                    color = Color.Black,
                    fontWeight = FontWeight.Bold,
                    fontSize = 16.sp,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(vertical = 8.dp)
                )
            }
        }
        Spacer(Modifier.height(20.dp))
    }
}
