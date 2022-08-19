import 'package:abdallah_abuzead/components/padge.dart';
import 'package:abdallah_abuzead/components/products_list.dart';
import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:abdallah_abuzead/screens/add_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_products.dart';
import 'favorite_products.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);
  static const String id = 'products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:   ${Provider.of<ProductData>(context).totalPrice}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    badge(
                      context,
                      content: '${Provider.of<ProductData>(context).favoritesCount}',
                      icon: Icon(Icons.favorite, color: Colors.red, size: 30),
                      onPressed: () {
                        Navigator.pushNamed(context, FavoriteProducts.id);
                      },
                    ),
                    SizedBox(width: 10),
                    badge(
                      context,
                      content: '${Provider.of<ProductData>(context).cartCount}',
                      icon: Icon(Icons.shopping_cart, color: Colors.indigo, size: 30),
                      onPressed: () {
                        Navigator.pushNamed(context, CartProducts.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
            thickness: 3,
          ),
          Expanded(child: ProductsList())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, AddProduct.id);
        },
      ),
    );
  }
}
