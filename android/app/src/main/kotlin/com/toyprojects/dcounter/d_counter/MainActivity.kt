package com.toyprojects.dcounter.d_counter

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return io.flutter.embedding.engine.FlutterEngineCache
            .getInstance()
            .get(FLUTTER_ENGINE_ID)
    }
}
