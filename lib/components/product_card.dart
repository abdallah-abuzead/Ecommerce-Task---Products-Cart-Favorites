import 'package:abdallah_abuzead/components/favorite_product_card.dart';
import 'package:abdallah_abuzead/models/product.dart';
import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  ProductCard({required this.product});
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  var swipeDirection = DismissDirection.startToEnd;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: swipeDirection,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd && !widget.product.isFavorite) {
          Provider.of<ProductData>(context, listen: false).toggleProductFavorite(widget.product);
        } else if (direction == DismissDirection.up && !widget.product.isInCart) {
          Provider.of<ProductData>(context, listen: false).toggleProductInCart(widget.product);
        }
        return false;
      },
      child: InkWell(
        child: FavoriteProductCard(product: widget.product, toProducts: true),
        onLongPress: () {
          setState(() {
            swipeDirection =
                swipeDirection == DismissDirection.startToEnd ? DismissDirection.up : DismissDirection.startToEnd;
          });
        },
      ),
    );
  }
}
