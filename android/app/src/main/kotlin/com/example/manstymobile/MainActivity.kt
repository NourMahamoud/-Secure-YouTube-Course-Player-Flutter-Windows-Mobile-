package com.example.manstymobile
import android.content.Context
import android.media.AudioManager
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "secure_channel"
    private var audioManager: AudioManager? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // منع لقطات الشاشة وتسجيل الشاشة
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE
        )

        // تجهيز AudioManager
        audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "muteSound" -> {
                        val mute = call.argument<Boolean>("mute") ?: false
                        muteVideoSound(mute)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun muteVideoSound(mute: Boolean) {
        audioManager?.setStreamMute(AudioManager.STREAM_MUSIC, mute)
    }
}
