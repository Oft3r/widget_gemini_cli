package com.example.gemini_cli

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class GeminiTerminalWidget : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_layout)
            
            // The PERFECT ASCII Art string
            val asciiText = "██      ██████   ███████  ███    ███  ██  ███    ██  ██\n" +
                            "  ██   ██        ██       ████  ████  ██  ████   ██  ██\n" +
                            "    ██ ██   ███  █████    ██ ████ ██  ██  ██ ██  ██  ██\n" +
                            "  ██   ██    ██  ██       ██  ██  ██  ██  ██  ██ ██  ██\n" +
                            "██      ██████   ███████  ██      ██  ██  ██   ████  ██"

            val colorStart = android.graphics.Color.parseColor("#4796E4") // Blue
            val colorMid = android.graphics.Color.parseColor("#843ACE")   // Purple (Tweaked for vibrancy)
            val colorEnd = android.graphics.Color.parseColor("#C3677F") // Pink

            val lines = asciiText.split("\n")
            val sb = android.text.SpannableStringBuilder()

            for (line in lines) {
                // Determine gradient for this line
                val lineLen = line.length
                for (i in 0 until lineLen) {
                    val charSpan = android.text.SpannableString(line[i].toString())
                    
                    // Calculate ratio 0.0 -> 1.0 across the line
                    val ratio = i.toFloat() / lineLen.toFloat()
                    
                    val charColor = if (ratio < 0.5) {
                        // Interpolate Blue -> Purple
                        val localRatio = ratio / 0.5f
                        interpolateColor(colorStart, colorMid, localRatio)
                    } else {
                        // Interpolate Purple -> Pink
                        val localRatio = (ratio - 0.5f) / 0.5f
                        interpolateColor(colorMid, colorEnd, localRatio)
                    }

                    charSpan.setSpan(
                        android.text.style.ForegroundColorSpan(charColor),
                        0,
                        1,
                        android.text.Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
                    )
                    sb.append(charSpan)
                }
                // Append newline
                if (line != lines.last()) {
                    sb.append("\n")
                }
            }
            
            views.setTextViewText(R.id.ascii_art, sb)

            // Launch Google Gemini App on click
            // Check both potential package names (Bard was the old ID, Gemini might be the new one or regional)
            val packages = listOf(
                "com.google.android.apps.bard",
                "com.google.android.apps.gemini"
            )

            var launchIntent: android.content.Intent? = null

            for (pkg in packages) {
                launchIntent = context.packageManager.getLaunchIntentForPackage(pkg)
                if (launchIntent != null) break
            }
            
            if (launchIntent == null) {
                // Fallback to URL if app not installed (Android usually handles this deep link to open the app if integrated)
                launchIntent = android.content.Intent(
                    android.content.Intent.ACTION_VIEW,
                    android.net.Uri.parse("https://gemini.google.com")
                )
            }

            if (launchIntent != null) {
                val pendingIntent = android.app.PendingIntent.getActivity(
                    context,
                    0,
                    launchIntent,
                    android.app.PendingIntent.FLAG_UPDATE_CURRENT or android.app.PendingIntent.FLAG_IMMUTABLE
                )
                views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun interpolateColor(c1: Int, c2: Int, ratio: Float): Int {
        val a = (android.graphics.Color.alpha(c1) * (1 - ratio) + android.graphics.Color.alpha(c2) * ratio).toInt()
        val r = (android.graphics.Color.red(c1) * (1 - ratio) + android.graphics.Color.red(c2) * ratio).toInt()
        val g = (android.graphics.Color.green(c1) * (1 - ratio) + android.graphics.Color.green(c2) * ratio).toInt()
        val b = (android.graphics.Color.blue(c1) * (1 - ratio) + android.graphics.Color.blue(c2) * ratio).toInt()
        return android.graphics.Color.argb(a, r, g, b)
    }
}
