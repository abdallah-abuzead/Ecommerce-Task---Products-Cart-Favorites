import 'package:abdallah_abuzead/components/cart_product_card.dart';
import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({Key? key}) : super(key: key);
  static const String id = 'cart_products';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.shopping_cart, color: Colors.purple.shade700),
            SizedBox(width: 10),
            Text('Cart Products'),
          ],
        ),
      ),
      body: Consumer<ProductData>(
        builder: (context, productData, child) {
          return productData.cartCount == 0
              ? Center(
                  child: Text('Your cart is empty.', style: TextStyle(fontSize: 16)),
                )
              : Scrollbar(
                  thickness: 3,
                  child: ListView.builder(
                    padding: EdgeInsets.all(5),
                    itemCount: productData.productsCount,
                    itemBuilder: (context, i) {
                      final product = productData.products[productData.productsCount - 1 - i];
                      if (product.isInCart)
                        return CartProductCard(product: product, productData: productData);
                      else
                        return Container();
                    },
                  ),
                );
        },
      ),
    );
  }
}
