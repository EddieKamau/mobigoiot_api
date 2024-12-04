import 'package:flutter/material.dart';
import 'package:mobigoiot_api/mobigoiot_api.dart';
import 'package:mobigoiot_api_example/printer_tab.dart';
import 'package:mobigoiot_api_example/scanner_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{
  late final TabController tabController;
  final _mobigoiotApiPlugin = MobigoiotApi();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: [
                Text('Printer'),
                Text('Scanner'),
              ]
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  PrinterTab(_mobigoiotApiPlugin),
                  ScannerTab(_mobigoiotApiPlugin),
                ],
              )
            )
          ],
        )
      ),
    );
  }
}
