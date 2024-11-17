package com.phan_tech.mobigoiot_api

import androidx.annotation.NonNull
import com.mobiiot.androidqapi.api.MobiiotAPI

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MobigoiotApiPlugin */
class MobigoiotApiPlugin: FlutterPlugin {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var printingChannel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    printingChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.phan_tech/mobigoiot_printing_api")
    printingChannel.setMethodCallHandler{ call, result ->
      handlePrinterMethods(call, result)
    }
    MobiiotAPI(flutterPluginBinding.applicationContext)
  }



  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    printingChannel.setMethodCallHandler(null)
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
}
