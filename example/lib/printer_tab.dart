import 'package:flutter/material.dart';
import 'package:mobigoiot_api/mobigoiot_api.dart';
import 'package:mobigoiot_api/printer_text_style.dart';

class PrinterTab extends StatefulWidget {
  const PrinterTab(this.mobigoiotApi, {super.key});
  final MobigoiotApi mobigoiotApi;

  @override
  State<PrinterTab> createState() => _PrinterTabState();
}

class _PrinterTabState extends State<PrinterTab> {
  @override
  Widget build(BuildContext context) {
    return Builder(
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
                      final res = await widget.mobigoiotApi.printText('Normal Text');
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
                      final res = await widget.mobigoiotApi.printTextFull(text: 'Size 1', style: PrinterTextStyle(textSize: PTextSize.size1));
                      await widget.mobigoiotApi.printTextFull(text: 'Size 2', style: PrinterTextStyle(textSize: PTextSize.size2));
                      await widget.mobigoiotApi.printTextFull(text: 'Size 3', style: PrinterTextStyle(textSize: PTextSize.size3));
                      await widget.mobigoiotApi.printTextFull(text: 'Size 4', style: PrinterTextStyle(textSize: PTextSize.size4));
                      await widget.mobigoiotApi.printTextFull(text: 'Size 5', style: PrinterTextStyle(textSize: PTextSize.size5));
                      await widget.mobigoiotApi.printEndLine();
                      await widget.mobigoiotApi.printEndLine();
              
                      await widget.mobigoiotApi.printTextFull(text: 'Direction forwad', style: PrinterTextStyle(textDirection: PTextDirection.forwad));
                      await widget.mobigoiotApi.printTextFull(text: 'Direction reversed', style: PrinterTextStyle(textDirection: PTextDirection.reversed));
                      await widget.mobigoiotApi.printTextFull(text: 'Direction other', style: PrinterTextStyle(textDirection: PTextDirection.other));
                      await widget.mobigoiotApi.printEndLine();
                      await widget.mobigoiotApi.printEndLine();
              
                      await widget.mobigoiotApi.printTextFull(text: 'Font 1', style: PrinterTextStyle(textFont: PTextFont.font1));
                      await widget.mobigoiotApi.printTextFull(text: 'Font 2', style: PrinterTextStyle(textFont: PTextFont.font2));
                      await widget.mobigoiotApi.printTextFull(text: 'Font 3', style: PrinterTextStyle(textFont: PTextFont.font3));
                      await widget.mobigoiotApi.printTextFull(text: 'Font 4', style: PrinterTextStyle(textFont: PTextFont.font4));
                      await widget.mobigoiotApi.printTextFull(text: 'Font 5', style: PrinterTextStyle(textFont: PTextFont.font5));
                      await widget.mobigoiotApi.printEndLine();
                      await widget.mobigoiotApi.printEndLine();
              
                      await widget.mobigoiotApi.printTextFull(text: 'alignment left', style: PrinterTextStyle(alignment: PTextAlignment.left));
                      await widget.mobigoiotApi.printTextFull(text: 'alignment center', style: PrinterTextStyle(alignment: PTextAlignment.center));
                      await widget.mobigoiotApi.printTextFull(text: 'alignment right', style: PrinterTextStyle(alignment: PTextAlignment.right));
                      await widget.mobigoiotApi.printEndLine();
                      await widget.mobigoiotApi.printEndLine();
              
                      await widget.mobigoiotApi.printTextFull(text: 'Bold', style: PrinterTextStyle(isBold: true));
                      await widget.mobigoiotApi.printTextFull(text: 'Underline', style: PrinterTextStyle(isUnderlined: true));
                      await widget.mobigoiotApi.printEndLine();
                      await widget.mobigoiotApi.printEndLine();
                      await widget.mobigoiotApi.printEndLine();
                      await widget.mobigoiotApi.printEndLine();
              
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
                      final res = await widget.mobigoiotApi.printEndLine();
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
        );
  }
}