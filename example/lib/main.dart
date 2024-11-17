import 'package:flutter/material.dart';
import 'package:mobigoiot_api/mobigoiot_api.dart';
import 'package:mobigoiot_api/printer_text_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mobigoiotApiPlugin = MobigoiotApi();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // print text
                  ElevatedButton(
                    onPressed: () async {
                      final res = await _mobigoiotApiPlugin.printText('Normal Text');
                      if(context.mounted){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(res == true ? "Printed" : "Failed")
                        ));
                      }
                    }, 
                    child: Text('Print Text')
                  ),
              
                  // print full
                  ElevatedButton(
                    onPressed: () async {
                      final res = await _mobigoiotApiPlugin.printTextFull(text: 'Size 1', style: PrinterTextStyle(textSize: PTextSize.size1));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Size 2', style: PrinterTextStyle(textSize: PTextSize.size2));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Size 3', style: PrinterTextStyle(textSize: PTextSize.size3));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Size 4', style: PrinterTextStyle(textSize: PTextSize.size4));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Size 5', style: PrinterTextStyle(textSize: PTextSize.size5));
                      await _mobigoiotApiPlugin.printEndLine();
                      await _mobigoiotApiPlugin.printEndLine();
              
                      await _mobigoiotApiPlugin.printTextFull(text: 'Direction forwad', style: PrinterTextStyle(textDirection: PTextDirection.forwad));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Direction reversed', style: PrinterTextStyle(textDirection: PTextDirection.reversed));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Direction other', style: PrinterTextStyle(textDirection: PTextDirection.other));
                      await _mobigoiotApiPlugin.printEndLine();
                      await _mobigoiotApiPlugin.printEndLine();
              
                      await _mobigoiotApiPlugin.printTextFull(text: 'Font 1', style: PrinterTextStyle(textFont: PTextFont.font1));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Font 2', style: PrinterTextStyle(textFont: PTextFont.font2));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Font 3', style: PrinterTextStyle(textFont: PTextFont.font3));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Font 4', style: PrinterTextStyle(textFont: PTextFont.font4));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Font 5', style: PrinterTextStyle(textFont: PTextFont.font5));
                      await _mobigoiotApiPlugin.printEndLine();
                      await _mobigoiotApiPlugin.printEndLine();
              
                      await _mobigoiotApiPlugin.printTextFull(text: 'alignment left', style: PrinterTextStyle(alignment: PTextAlignment.left));
                      await _mobigoiotApiPlugin.printTextFull(text: 'alignment center', style: PrinterTextStyle(alignment: PTextAlignment.center));
                      await _mobigoiotApiPlugin.printTextFull(text: 'alignment right', style: PrinterTextStyle(alignment: PTextAlignment.right));
                      await _mobigoiotApiPlugin.printEndLine();
                      await _mobigoiotApiPlugin.printEndLine();
              
                      await _mobigoiotApiPlugin.printTextFull(text: 'Bold', style: PrinterTextStyle(isBold: true));
                      await _mobigoiotApiPlugin.printTextFull(text: 'Underline', style: PrinterTextStyle(isUnderlined: true));
                      await _mobigoiotApiPlugin.printEndLine();
                      await _mobigoiotApiPlugin.printEndLine();
                      await _mobigoiotApiPlugin.printEndLine();
                      await _mobigoiotApiPlugin.printEndLine();
              
                      if(context.mounted){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(res == true ? "Printed" : "Failed")
                        ));
                      }
                    }, 
                    child: Text('Print Full')
                  ),
              
                  // print line
                  ElevatedButton(
                    onPressed: () async {
                      final res = await _mobigoiotApiPlugin.printEndLine();
                      if(context.mounted){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(res == true ? "Printed" : "Failed")
                        ));
                      }
                    }, 
                    child: Text('Print Line')
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
