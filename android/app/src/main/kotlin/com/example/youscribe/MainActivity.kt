package com.example.youscribe

import android.os.Bundle
import android.content.Context;
import com.pspdfkit.flutter.pspdfkit.EventDispatcher
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log;
import io.flutter.embedding.android.FlutterFragmentActivity
import com.ryanheise.audioservice.AudioServicePlugin

class MainActivity: FlutterFragmentActivity() {

    override fun provideFlutterEngine(context:Context):FlutterEngine {
        return AudioServicePlugin.getFlutterEngine(context);
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        YSNativeMethodChannel.configureChannel(flutterEngine)
        
        val instance = EventDispatcher.getInstance();
        //Log.d("### MainActivity", "Getting instance. Is instance null ?" + (instance == null))
        instance?.setDispatcherListener(YSNativeMethodChannel)
    }
}
object YSNativeMethodChannel : EventDispatcher.EventDispatcherListener {
    private val YS_PSPDFKit_CHANNEL = "com.youscribe/pspdfkit"
    private lateinit var methodChannel: MethodChannel

    fun configureChannel(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, YS_PSPDFKit_CHANNEL)
    }

    override fun triggerEvent(method: kotlin.String, arguments: kotlin.Any?) {
        methodChannel.invokeMethod(method, arguments)
    }
}