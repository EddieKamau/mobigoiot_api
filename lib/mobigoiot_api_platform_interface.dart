import 'dart:typed_data';

import 'package:mobigoiot_api/printer_text_style.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobigoiot_api_method_channel.dart';

abstract class MobigoiotApiPlatform extends PlatformInterface {
  /// Constructs a MobigoiotApiPlatform.
  MobigoiotApiPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobigoiotApiPlatform _instance = MethodChannelMobigoiotApi();

  /// The default instance of [MobigoiotApiPlatform] to use.
  ///
  /// Defaults to [MethodChannelMobigoiotApi].
  static MobigoiotApiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MobigoiotApiPlatform] when
  /// they register themselves.
  static set instance(MobigoiotApiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> printText(String text) {
    throw UnimplementedError('printText() has not been implemented.');
  }


  Future<bool?> printTextFull({required String text, PrinterTextStyle? style}) {
    throw UnimplementedError('printTextFull() has not been implemented.');
  }

  Future<bool?> printBitmap(Uint8List data) {
    throw UnimplementedError('printBitmap() has not been implemented.');
  }

  Future<bool?> printEndLine() {
    throw UnimplementedError('printEndLine() has not been implemented.');
  }

}
