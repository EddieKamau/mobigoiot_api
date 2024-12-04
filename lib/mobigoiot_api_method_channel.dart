import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobigoiot_api/printer_text_style.dart';
import 'package:mobigoiot_api/scanner_mode.dart';
import 'package:mobigoiot_api/scanner_result.dart';

import 'mobigoiot_api_platform_interface.dart';

class MethodChannelMobigoiotApi extends MobigoiotApiPlatform {
  @visibleForTesting
  final printingMethodChannel =
      const MethodChannel('com.phan_tech/mobigoiot_printing_api');
  final scanningMethodChannel =
      const MethodChannel('com.phan_tech/mobigoiot_scanner_api');
  final scannerEventChannel =
      const EventChannel('com.phan_tech/mobigoiot_scanner_events_api');

  @override
  Future<bool?> printText(String text) async {
    try {
      return await printingMethodChannel
          .invokeMethod<bool>('printText', {"text": text});
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> printTextFull(
      {required String text, PrinterTextStyle? style}) async {
    try {
      if (style == null) {
        return printText(text);
      }
      return await printingMethodChannel.invokeMethod<bool>('printTextFull', {
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
      return await printingMethodChannel
          .invokeMethod<bool>('printBitmap', {"data": data});
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> printEndLine() async {
    try {
      return await printingMethodChannel.invokeMethod<bool>('printEndLine');
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> startScanner({
    bool turnOnFlash = false,
    bool turnOnBeep = false,
    bool turnOnVibration = false,
    ScannerMode scannerMode = ScannerMode.single,
    int delay = 500,
  }) async {
    try {
      return await scanningMethodChannel.invokeMethod<bool>('startScanner', {
        "turnOnFlash": turnOnFlash,
        "turnOnBeep": turnOnBeep,
        "turnOnVibration": turnOnVibration,
        "scannerMode": scannerMode.value,
        "delay": delay,
      });
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> stopScanner() async {
    try {
      return await scanningMethodChannel.invokeMethod<bool>('stopScanner');
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<ScannerResult?>? getScanResult() {
    try {
      return scannerEventChannel
          .receiveBroadcastStream()
          .map((event) => ScannerResult.fromMap(event));
    } catch (_) {
      return null;
    }
  }
}
