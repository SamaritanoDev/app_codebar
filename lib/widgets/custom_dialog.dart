import 'package:flutter/material.dart';

class DialogHelper {
  static void showEmptyCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Carrito Vacío', style: Theme.of(context).textTheme.titleSmall),
          content:
              Text('Tu carrito de compras está vacío. Agrega productos', style: Theme.of(context).textTheme.bodyLarge),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
