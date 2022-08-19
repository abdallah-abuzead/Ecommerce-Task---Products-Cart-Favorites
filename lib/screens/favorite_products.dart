import 'package:abdallah_abuzead/components/favorite_product_card.dart';
import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

class FavoriteProducts extends StatelessWidget {
  const FavoriteProducts({Key? key}) : super(key: key);
  static const String id = 'favorite_products';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('❤  Favorite Products'),
      ),
      body: Consumer<ProductData>(
        builder: (context, productData, child) {
          return productData.favoritesCount == 0
              ? Center(
                  child: Text('There are no favorite products.', style: TextStyle(fontSize: 16)),
                )
              : Scrollbar(
                  thickness: 3,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    itemCount: productData.productsCount,
                    itemBuilder: (context, i) {
                      final product = productData.products[productData.productsCount - 1 - i];
                      if (product.isFavorite)
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: SwipeTo(
                            child: FavoriteProductCard(product: product),
                            animationDuration: Duration(seconds: 1),
                            offsetDx: 0.6,
                            iconOnRightSwipe: Icons.favorite_border,
                            iconColor: Colors.red,
                            onRightSwipe: () {
                              productData.toggleProductFavorite(product);
                            },
                          ),
                        );
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
