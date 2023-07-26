import 'package:app_codebar/cart_screen.dart';
import 'package:app_codebar/product.dart';
import 'package:app_codebar/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _barcodeScanRes = '';
  final List<Product> _scannedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              if (_scannedProducts.isNotEmpty) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CartScreen(_scannedProducts)),
                );
              } else {
                DialogHelper.showEmptyCartDialog(context);
                // Aquí puedes mostrar una advertencia o una SnackBar para indicar que el carrito está vacío.
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Escánea tus productos',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    itemCount: _scannedProducts.length,
                    itemBuilder: (context, index) {
                      String barcode = _scannedProducts[index].barcode;
                      if (barcode.isEmpty || int.tryParse(barcode) == null || int.parse(barcode) < 0) {
                        return ListTile(
                          title: Text('No ha sido posible detectar el producto',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
                          tileColor: Theme.of(context).colorScheme.error,
                        );
                      } else {
                        return ListTile(
                          subtitle: Text(
                            barcode,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                          ),
                          tileColor: Theme.of(context).colorScheme.primary,
                        );
                      }
                    })),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: () => scanBarcode(),
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ],
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

    if (!mounted) return;

    setState(() {
      _barcodeScanRes = barcodeScanRes;
      Product scannedProduct = Product(barcode: barcodeScanRes);
      _scannedProducts.add(scannedProduct);
    });
  }
}
