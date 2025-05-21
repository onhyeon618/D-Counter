package com.toyprojects.dcounter.d_counter

// below code is based on:
// https://github.com/armcha/EventsWidget/blob/035a17238911459e3f1a435d9da59ab2311036f4/app/src/main/java/com/example/widgetexample/widget/GlanceText.kt

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Paint
import android.text.TextPaint
import android.util.TypedValue
import androidx.annotation.FontRes
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.sp
import androidx.core.content.res.ResourcesCompat
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.LocalContext
import androidx.core.graphics.createBitmap

@Composable
fun GlanceText(
    text: String,
    @FontRes font: Int,
    fontSize: Dp,
    modifier: GlanceModifier = GlanceModifier,
    color: Color = Color.Black,
    letterSpacing: TextUnit = 0.1.sp
) {
    Image(
        modifier = modifier,
        provider = ImageProvider(
            LocalContext.current.textAsBitmap(
                text = text,
                fontSize = fontSize,
                color = color,
                font = font,
                letterSpacing = letterSpacing.value
            )
        ),
        contentDescription = null,
    )
}

private fun Context.textAsBitmap(
    text: String,
    fontSize: Dp,
    color: Color = Color.Black,
    letterSpacing: Float = 0.1f,
    font: Int
): Bitmap {
    val paint = TextPaint(Paint.ANTI_ALIAS_FLAG)
    paint.textSize = dpToPx(fontSize.value, this)
    paint.color = color.toArgb()
    paint.textAlign = Paint.Align.LEFT
    paint.letterSpacing = letterSpacing
    paint.typeface = ResourcesCompat.getFont(this, font)
    paint.isFakeBoldText = true

    val baseline = -paint.ascent()
    val width = (paint.measureText(text) + 5f).toInt()
    val height = (baseline + paint.descent() + 15f).toInt()
    val image = createBitmap(width, height)
    val canvas = Canvas(image)
    canvas.drawText(text, 0f, baseline + 10f, paint)
    return image
}

private fun dpToPx(dp: Float, context: Context): Float {
    return TypedValue.applyDimension(
        TypedValue.COMPLEX_UNIT_DIP,
        dp,
        context.resources.displayMetrics
    )
}