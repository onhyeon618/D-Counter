package com.toyprojects.dcounter.d_counter

import androidx.datastore.preferences.core.floatPreferencesKey
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey

object Keys {
    // App
    val daysCount = stringPreferencesKey("daysCount")
    val fontFamily = intPreferencesKey("fontFamily")

    // Widget
    val colorMode = intPreferencesKey("colorMode")
    val backgroundAlpha = floatPreferencesKey("backgroundAlpha")
    val textAlpha = floatPreferencesKey("textAlpha")
}