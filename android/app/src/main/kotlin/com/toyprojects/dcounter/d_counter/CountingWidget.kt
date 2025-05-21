package com.toyprojects.dcounter.d_counter

import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.action.actionStartActivity
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Box
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.padding
import androidx.glance.state.GlanceStateDefinition

class CountingWidget : GlanceAppWidget() {

    private val fontFamilyList = listOf(
        R.font.doldam,
        R.font.dongle,
        R.font.esamanru,
        R.font.jikji,
        R.font.kimjungchul,
        R.font.okticon,
    )

    override val stateDefinition: GlanceStateDefinition<*>?
        get() = HomeWidgetGlanceStateDefinition()

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        var fontSize = 50.dp

        val sizes = GlanceAppWidgetManager(context).getAppWidgetSizes(id)
        if (sizes.size == 1 && sizes[0].height > 0.dp) {
            fontSize = (sizes[0].height.value - 40).dp
        }

        provideContent {
            GlanceContent(context, currentState(), fontSize)
        }
    }

    @Composable
    private fun GlanceContent(context: Context, currentState: HomeWidgetGlanceState, fontSize: Dp) {
        val prefs = currentState.preferences
        val daysCount = prefs.getString("daysCount", "날짜를 설정해주세요")!!
        val fontFamily = prefs.getInt("fontFamily", 0)

        Box(
            modifier = GlanceModifier.fillMaxSize().padding(10.dp),
            contentAlignment = androidx.glance.layout.Alignment.Center
        ) {
            Box(
                modifier = GlanceModifier
                    .fillMaxSize()
                    .background(Color.White)
                    .cornerRadius(16.dp)
                    .clickable(actionStartActivity<MainActivity>())
                    .padding(10.dp),
                contentAlignment = androidx.glance.layout.Alignment.Center
            ) {
                GlanceText(
                    text = daysCount,
                    font = fontFamilyList[fontFamily],
                    fontSize = fontSize,
                )
            }
        }
    }
}

