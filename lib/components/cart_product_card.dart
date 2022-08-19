import 'dart:io';
import 'package:abdallah_abuzead/models/product.dart';
import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:flutter/material.dart';
import 'control_purshase_quantity.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({Key? key, required this.product, required this.productData}) : super(key: key);

  final Product product;
  final ProductData productData;

  @override
  Widget build(BuildContext context) {
    bool hasSale = product.price != product.salePrice;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          productData.toggleProductInCart(product);
        },
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    SizedBox(height: 5),
                    Text(
                      'Total Price:   ${product.purchaseQuantity * (hasSale ? product.salePrice : product.price)}',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    product.stockQuantity > 0 ? ControlPurchaseQuantity(product: product) : Container(),
                  ],
                ),
                Container(
                  width: 120,
                  height: 90,
                  child: product.imagePath == 'images/products/laptop1.png' ||
                          product.imagePath == 'images/products/laptop2.jpg'
                      ? Image.asset(product.imagePath)
                      : Image.file(File(product.imagePath)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
