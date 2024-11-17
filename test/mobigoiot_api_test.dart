import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobigoiot_api/mobigoiot_api.dart';
import 'package:mobigoiot_api/mobigoiot_api_platform_interface.dart';
import 'package:mobigoiot_api/mobigoiot_api_method_channel.dart';
import 'package:mobigoiot_api/printer_text_style.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMobigoiotApiPlatform
    with MockPlatformInterfaceMixin
    implements MobigoiotApiPlatform {

  @override
  Future<bool?> printText(String text) => Future.value(true);

  @override
  Future<bool?> printBitmap(Uint8List data)  => Future.value(true);

  @override
  Future<bool?> printEndLine()  => Future.value(true);

  @override
  Future<bool?> printTextFull({required String text, PrinterTextStyle? style})  => Future.value(true);
}

void main() {
  final MobigoiotApiPlatform initialPlatform = MobigoiotApiPlatform.instance;

  test('$MethodChannelMobigoiotApi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMobigoiotApi>());
  });

  test('printText', () async {
    MobigoiotApi mobigoiotApiPlugin = MobigoiotApi();
    MockMobigoiotApiPlatform fakePlatform = MockMobigoiotApiPlatform();
    MobigoiotApiPlatform.instance = fakePlatform;

    expect(await mobigoiotApiPlugin.printText('Testing'), true);
  });
}
