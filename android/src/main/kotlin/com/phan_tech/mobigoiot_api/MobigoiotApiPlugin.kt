package com.phan_tech.mobigoiot_api

import android.app.Activity
import android.os.RemoteException
import android.util.Log
import android.view.KeyEvent
import com.mobiiot.androidqapi.api.MobiIotScannerApi
import com.mobiiot.androidqapi.api.MobiiotAPI
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** MobigoiotApiPlugin */
class MobigoiotApiPlugin: FlutterPlugin, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var printingChannel : MethodChannel
  private lateinit var scannerChannel : MethodChannel
  private lateinit var scannerEventChannel : EventChannel
  private var activity: Activity? = null
  private var eventSink: EventChannel.EventSink? = null

  var selectedTriggerButton = -1

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    printingChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.phan_tech/mobigoiot_printing_api")
    printingChannel.setMethodCallHandler{ call, result ->
      handlePrinterMethods(call, result)
    }

    scannerChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.phan_tech/mobigoiot_scanner_api")
    scannerChannel.setMethodCallHandler{ call, result ->
      handleScannerMethods(call, result)
    }

    scannerEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "com.phan_tech/mobigoiot_scanner_events_api")
    scannerEventChannel.setStreamHandler(object : EventChannel.StreamHandler {

      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        // Send initial event
        MobigoScanner.getScanResult(eventSink)
      }

      override fun onCancel(arguments: Any?) {
        eventSink = null
      }
    })
    MobiiotAPI(flutterPluginBinding.applicationContext)
    MobiIotScannerApi(flutterPluginBinding.applicationContext)

  }



  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    printingChannel.setMethodCallHandler(null)
    scannerChannel.setMethodCallHandler(null)
  }

  private fun handlePrinterMethods(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "printText" -> {
        val text:String? = call.argument("text")
        val res = MobigoPrinter.printText(text ?: "" );
        result.success(res)
      }
      "printTextFull" -> {
        val text:String = call.argument("text") ?: ""
        val textSize:Int = call.argument("textSize") ?: 1
        val textDirection:Int = call.argument("textDirection") ?: 2
        val textFont:Int = call.argument("textFont") ?: 1
        val alignment:Int = call.argument("alignment") ?: 1
        val isBold:Boolean = call.argument("isBold") ?: false
        val isUnderlined:Boolean = call.argument("isUnderlined") ?: false
        val res = MobigoPrinter.printTextFull(
          text, textSize, textDirection, textFont, alignment, isBold, isUnderlined
        );
        result.success(res)
      }
      "printBitmap" -> {
        val data: ByteArray? = call.argument<ByteArray>("data")
        if (data != null) {
          val res = MobigoPrinter.printBitmap(data);
          result.success(res)
        } else {
          result.error("INVALID_ARGUMENT", "Byte array data is missing", null)
        }


      }
      "printEndLine" -> {
        val res = MobigoPrinter.printEndLine();
        result.success(res)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun handleScannerMethods(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {

      "startScanner" -> {
        val turnOnFlash:Boolean = call.argument("turnOnFlash") ?: false
        val turnOnBeep:Boolean = call.argument("turnOnBeep") ?: false
        val turnOnVibration:Boolean = call.argument("turnOnVibration") ?: false
        val scannerMode:String = call.argument("scannerMode") ?: ""
        val delay:Int = call.argument("delay") ?: 500

        selectedTriggerButton = if(scannerMode == "TRIGGER"){
          27
        }else{
          -1
        }

        val res = MobigoScanner.startScanner(turnOnFlash, turnOnBeep, turnOnVibration, scannerMode, delay);
        result.success(res)
      }

      "stopScanner" -> {
        selectedTriggerButton = -1
        val res = MobigoScanner.stopScanner();
        result.success(res)
      }
      else -> {
        result.notImplemented()
      }
    }
  }







  fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
    try {
      if (keyCode == selectedTriggerButton) {
        if(!MobigoScanner.scannerIsOpen()) {
          MobigoScanner.startScanner()
          if (eventSink != null) {
            MobigoScanner.getScanResult(eventSink)
          }
        }
      }
    } catch (e: RemoteException) {
      e.printStackTrace()
    }
    return true
  }

  // catches the onKeyUp button event
  fun onKeyUp(keyCode: Int, event: KeyEvent?): Boolean {
    if (keyCode == selectedTriggerButton) {
      try {
        MobigoScanner.stopScanner()
      } catch (e: RemoteException) {
        e.printStackTrace()
      }
    }
    return true
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity



    activity?.let {
      it.window.callback = object : android.view.Window.Callback by it.window.callback {
        override fun dispatchKeyEvent(event: KeyEvent?): Boolean {
          if (event?.action == KeyEvent.ACTION_DOWN) {
            return onKeyDown(event.keyCode, event)
          }else if (event?.action == KeyEvent.ACTION_UP) {
            return onKeyUp(event.keyCode, event)
          }
          return true
        }
      }
    }


  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }


}
