# Mobigoiot Plugin

The `Mobigoiot` Flutter plugin provides printing functionalities for Mobigoiot-compatible devices, allowing you to print text, styled text, and images (bitmaps) directly from your Flutter application.

## Features

- **Print Text**: Basic text printing
- **Styled Text**: Customize text with styles (size, font, alignment, bold, underline)
- **Bitmap Printing**: Print images in bitmap format
- **Print Line End**: Send an end line command for page control

## Installation

Add `mobigoiot` as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  mobigoiot_api: latest_version
```
## Usage
Import the package in your Dart file:
```dart
import 'package:mobigoiot_api/mobigoiot_api.dart';

```
## Example
```dart
final _mobigoiotApiPlugin = MobigoiotApi();

```

# Printing
```dart
// Print simple text
await _mobigoiotApiPlugin.printText("Hello, World!");

// Print styled text
await _mobigoiotApiPlugin.printTextFull(
  text: "Hello, Styled World!",
  style: PrinterTextStyle(
    textSize: PTextSize.size2,
    textFont: PTextFont.font2,
    alignment: PTextAlignment.center,
    isBold: true,
    isUnderlined: true,
  ),
);

// Print bitmap image
Uint8List imageData = ... // Load or generate your bitmap data
await _mobigoiotApiPlugin.printBitmap(imageData);

// End line after printing
await _mobigoiotApiPlugin.printEndLine();
```

# Qr and Bar Code Scanner
```dart
// startScanner
await _mobigoiotApiPlugin.startScanner();
await _mobigoiotApiPlugin.startScanner(turnOnFlash: true, turnOnBeep: true, turnOnVibration: false, scannerMode: ScannerMode.single, int delay = 500);

// stopScanner
await _mobigoiotApiPlugin.stopScanner();

// getScanResult
_mobigoiotApiPlugin.getScanResult()?.listen((value){
      data = value?.value ?? '';
});

```

## API Reference
## Printing
- **`printText(String text): Future<bool?>`**  
  Prints plain text.

- **`printTextFull({required String text, PrinterTextStyle? style}): Future<bool?>`**  
  Prints text with customizable style. Use the `PrinterTextStyle` class to define text appearance.

- **`printBitmap(Uint8List data): Future<bool?>`**  
  Prints a bitmap image. Pass `Uint8List` image data.

- **`printEndLine(): Future<bool?>`**  
  Sends a line end command, useful for ending the current print session.

  
## Qr & Bar code Scanner
- **`startScanner({bool turnOnFlash = false, bool turnOnBeep = false, bool turnOnVibration = false, ScannerMode scannerMode = ScannerMode.single, int delay = 500})`**  
  Starts the Scanner.
  When `scannerMode = ScannerMode.trigger`, the scanner will be controlled by the camera button 
