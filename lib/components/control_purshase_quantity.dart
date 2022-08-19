import 'package:abdallah_abuzead/models/product.dart';
import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlPurchaseQuantity extends StatelessWidget {
  const ControlPurchaseQuantity({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.add_circle_outline_outlined),
          onPressed: () {
            Provider.of<ProductData>(context, listen: false).increasePurchaseQuantity(product);
          },
        ),
        Text('${product.purchaseQuantity}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        IconButton(
          icon: Icon(Icons.remove_circle_outline_outlined),
          onPressed: () {
            Provider.of<ProductData>(context, listen: false).decreasePurchaseQuantity(product);
          },
        ),
      ],
    );
  }
}
