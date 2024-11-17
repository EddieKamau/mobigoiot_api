
import 'dart:typed_data';

import 'package:mobigoiot_api/printer_text_style.dart';

import 'mobigoiot_api_platform_interface.dart';

class MobigoiotApi {

  Future<bool?> printText(String text) {
    return MobigoiotApiPlatform.instance.printText(text);
  }


  Future<bool?> printTextFull({required String text, PrinterTextStyle? style}) {
    return MobigoiotApiPlatform.instance.printTextFull(text: text, style: style);
  }

  Future<bool?> printBitmap(Uint8List data) {
    return MobigoiotApiPlatform.instance.printBitmap(data);
  }

  Future<bool?> printEndLine() {
    return MobigoiotApiPlatform.instance.printEndLine();
  }
}
