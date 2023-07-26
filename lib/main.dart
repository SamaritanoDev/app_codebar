import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _barcodeScanRes = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Scan Code'),
                onPressed: () => scanBarcode(),
              ),
              const SizedBox(height: 20),
              Text(
                'Value: ${_barcodeScanRes.length >= 2 ? _barcodeScanRes.substring(1) : _barcodeScanRes}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#FF0000",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );
    setState(() {
      _barcodeScanRes = barcodeScanRes;
    });
  }
}
