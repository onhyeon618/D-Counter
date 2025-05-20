package com.toyprojects.dcounter.d_counter

import HomeWidgetGlanceWidgetReceiver

class CountingWidgetReceiver : HomeWidgetGlanceWidgetReceiver<CountingWidget>() {
    override val glanceAppWidget = CountingWidget()
}