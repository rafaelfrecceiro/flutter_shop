import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/pages/product_details_page.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  product.toggleFavorite();
                  if (product.isFavorite) {}
                },
                color: Theme.of(context).selectedRowColor,
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
              );
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
            },
            // ignore: deprecated_member_use
            color: Theme.of(context).accentColor,
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            //Navigator.of(context).pushNamed('/product-detail');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ProductDetailsPage(product: product);
                },
              ),
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
