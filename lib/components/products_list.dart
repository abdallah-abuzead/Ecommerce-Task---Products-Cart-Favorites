import 'package:abdallah_abuzead/components/product_card.dart';
import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductData>(
      builder: (context, productData, child) {
        return Scrollbar(
          thickness: 3,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: productData.productsCount,
            itemBuilder: (context, i) {
              final product = productData.products[productData.productsCount - 1 - i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: ProductCard(product: product),
              );
            },
          ),
        );
      },
    );
  }
}
