import 'dart:typed_data';

import 'package:mobigoiot_api/printer_text_style.dart';
import 'package:mobigoiot_api/scanner_mode.dart';
import 'package:mobigoiot_api/scanner_result.dart';

import 'mobigoiot_api_platform_interface.dart';

class MobigoiotApi {
  Future<bool?> printText(String text) {
    return MobigoiotApiPlatform.instance.printText(text);
  }

  Future<bool?> printTextFull({required String text, PrinterTextStyle? style}) {
    return MobigoiotApiPlatform.instance
        .printTextFull(text: text, style: style);
  }

  Future<bool?> printBitmap(Uint8List data) {
    return MobigoiotApiPlatform.instance.printBitmap(data);
  }

  Future<bool?> printEndLine() {
    return MobigoiotApiPlatform.instance.printEndLine();
  }

  Future<bool?> startScanner({
    bool turnOnFlash = false,
    bool turnOnBeep = false,
    bool turnOnVibration = false,
    ScannerMode scannerMode = ScannerMode.single,
    int delay = 500,
  }) {
    return MobigoiotApiPlatform.instance.startScanner(
      turnOnFlash: turnOnFlash,
      turnOnBeep: turnOnBeep,
      turnOnVibration: turnOnVibration,
      scannerMode: scannerMode,
      delay: delay,
    );
  }

  Future<bool?> stopScanner() {
    return MobigoiotApiPlatform.instance.stopScanner();
  }

  Stream<ScannerResult?>? getScanResult() {
    return MobigoiotApiPlatform.instance.getScanResult();
  }

  Future<ScannerResult?> scanOnce({
    bool turnOnFlash = false,
    bool turnOnBeep = false,
    bool turnOnVibration = false,
  }) async {
    // start scanner
    final start = await MobigoiotApiPlatform.instance.startScanner(
      turnOnFlash: turnOnFlash,
      turnOnBeep: turnOnBeep,
      turnOnVibration: turnOnVibration,
    );

    if (start != true) {
      return null;
    }

    // get first result
    final result = await MobigoiotApiPlatform.instance.getScanResult()?.first;

    // stop
    await MobigoiotApiPlatform.instance.stopScanner();

    return result;
  }
}
