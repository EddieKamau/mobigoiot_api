import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobigoiot_api/printer_text_style.dart';

import 'mobigoiot_api_platform_interface.dart';

class MethodChannelMobigoiotApi extends MobigoiotApiPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('com.phan_tech/mobigoiot_printing_api');

  @override
  Future<bool?> printText(String text) async {
    try {
      return await methodChannel.invokeMethod<bool>('printText', {"text": text});
    } catch (_) {
      return null;
    }
  }


  @override
  Future<bool?> printTextFull({required String text, PrinterTextStyle? style}) async {
    try {
      if(style == null){
        return printText(text);
      }
      return await methodChannel.invokeMethod<bool>('printTextFull', {
        "text": text,
        "textSize": style.textSize?.value,
        "textDirection": style.textDirection?.value,
        "textFont": style.textFont?.value,
        "alignment": style.alignment?.value,
        "isBold": style.isBold,
        "isUnderlined": style.isUnderlined,
      });
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> printBitmap(Uint8List data) async {
    try {
      return await methodChannel.invokeMethod<bool>('printBitmap', {"data": data});
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> printEndLine() async {
    try {
      return await methodChannel.invokeMethod<bool>('printEndLine');
    } catch (_) {
      return null;
    }
  }
}
