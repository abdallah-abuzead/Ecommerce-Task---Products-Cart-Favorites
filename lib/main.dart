import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:abdallah_abuzead/screens/add_product.dart';
import 'package:abdallah_abuzead/screens/cart_products.dart';
import 'package:abdallah_abuzead/screens/favorite_products.dart';
import 'package:abdallah_abuzead/screens/products.dart';
import 'package:abdallah_abuzead/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductData>(
      create: (context) => ProductData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
            ),
          ),
        ),
        initialRoute: Welcome.id,
        routes: {
          Welcome.id: (context) => Welcome(),
          Products.id: (context) => Products(),
          CartProducts.id: (context) => CartProducts(),
          FavoriteProducts.id: (context) => FavoriteProducts(),
          AddProduct.id: (context) => AddProduct(),
        },
      ),
    );
  }
}
