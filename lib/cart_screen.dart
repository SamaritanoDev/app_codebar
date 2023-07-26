import 'package:app_codebar/product.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<Product> scannedProducts;

  const CartScreen(this.scannedProducts, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrito de compras',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: ListView.builder(
        itemCount: scannedProducts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.primary,
              subtitle: Text(
                scannedProducts[index].barcode,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
