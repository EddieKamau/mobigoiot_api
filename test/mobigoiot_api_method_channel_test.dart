import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobigoiot_api/mobigoiot_api_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMobigoiotApi platform = MethodChannelMobigoiotApi();
  const MethodChannel channel = MethodChannel('com.phan_tech/mobigoiot_printing_api');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return true;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('printText', () async {
    expect(await platform.printText("Testing"), true);
  });
}
