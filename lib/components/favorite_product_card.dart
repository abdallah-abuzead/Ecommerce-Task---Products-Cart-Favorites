import 'dart:io';

import 'package:abdallah_abuzead/models/product.dart';
import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'control_purshase_quantity.dart';

class FavoriteProductCard extends StatelessWidget {
  FavoriteProductCard({required this.product, this.toProducts = false});
  final Product product;
  final bool toProducts;

  @override
  Widget build(BuildContext context) {
    bool hasSale = product.price != product.salePrice;
    return Card(
      elevation: 3,
      child: Column(
        children: [
          Container(
            child:
                product.imagePath == 'images/products/laptop1.png' || product.imagePath == 'images/products/laptop2.jpg'
                    ? Image.asset(product.imagePath)
                    : Image.file(File(product.imagePath)),
            height: 200,
          ),
          ListTile(
            leading: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            trailing: product.stockQuantity > 0 && toProducts ? ControlPurchaseQuantity(product: product) : null,
          ),
          ListTile(
            title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(product.description),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 10),
            child: Row(
              children: [
                Text('Price:   ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                hasSale
                    ? Text(
                        '${product.salePrice}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      )
                    : Text(''),
                SizedBox(width: hasSale ? 15 : 0),
                Text(
                  '${product.price}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: hasSale ? Colors.red : Colors.black,
                      decoration: hasSale ? TextDecoration.lineThrough : null),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
