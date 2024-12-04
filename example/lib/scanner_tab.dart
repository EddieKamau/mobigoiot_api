import 'package:flutter/material.dart';
import 'package:mobigoiot_api/mobigoiot_api.dart';
import 'package:mobigoiot_api/scanner_mode.dart';

class ScannerTab extends StatefulWidget {
  const ScannerTab(this.mobigoiotApi, {super.key});

  final MobigoiotApi mobigoiotApi;

  @override
  State<ScannerTab> createState() => _ScannerTabState();
}

class _ScannerTabState extends State<ScannerTab> {
  String data = '';

  ScannerMode selectedScanMode = ScannerMode.single;
  bool torchOn = false;
  bool vibrationOn = false;
  bool sountOn = false;

  @override
  void initState() {
    super.initState();
    widget.mobigoiotApi.getScanResult()?.listen((value) {
      if (mounted) {
        setState(() {
          data = value?.value ?? '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // text scanned
        Text(
          "Data: $data",
          style: TextStyle(fontSize: 16),
        ),

        // scan mode
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var scanMode in ScannerMode.values)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(scanMode.name),
                  Radio<ScannerMode>(
                      value: scanMode,
                      groupValue: selectedScanMode,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            selectedScanMode = val;
                          });
                        }
                      }),
                ],
              ),
          ],
        ),

        // torch on
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Torch On'),
            Switch(
                value: torchOn,
                onChanged: (val) {
                  setState(() {
                    torchOn = val;
                  });
                }),
          ],
        ),

        // vibrate
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Vibration On'),
            Switch(
                value: vibrationOn,
                onChanged: (val) {
                  setState(() {
                    vibrationOn = val;
                  });
                }),
          ],
        ),

        // sound
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sount On'),
            Switch(
                value: sountOn,
                onChanged: (val) {
                  setState(() {
                    sountOn = val;
                  });
                }),
          ],
        ),

        // duration

        // start
        ElevatedButton(
            onPressed: () async {
              final res = await widget.mobigoiotApi.startScanner(
                  turnOnFlash: torchOn,
                  turnOnVibration: vibrationOn,
                  turnOnBeep: sountOn,
                  scannerMode: selectedScanMode);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(res == true ? "Started" : "Failed")));
              }
            },
            child: Text('Start Scanner')),
        SizedBox(
          height: 20,
        ),

        // stop
        ElevatedButton(
            onPressed: () async {
              final res = await widget.mobigoiotApi.stopScanner();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(res == true ? "Stopped" : "Failed")));
              }
            },
            child: Text('Stop Scanner')),
      ],
    );
  }
}
