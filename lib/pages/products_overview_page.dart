import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/providers/order_provider.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/widgets/badge.dart';
import 'package:provider/provider.dart';
import '../widgets/product_grid.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsProvider products = Provider.of(context);
    final Cart cart = Provider.of(context);
    final OrderProvider order = Provider.of(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView.builder(
          itemCount: order.ordersCount,
          itemBuilder: (context, index) {
            var qtde = order.orders[index].products.fold(0,
                (previousValue, element) => previousValue += element.quantity);
            return ListTile(
              title: Text('Pedido #${order.orders[index].id.toString()}'),
              subtitle: Text('R\$ ${order.orders[index].amount}'),
              trailing: Text(qtde.toString()),
            );
          },
        ),
      ),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.all) {
                products.showAll();
              } else if (selectedValue == FilterOptions.favorite) {
                products.showFavorites();
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: FilterOptions.favorite,
                  child: Text(
                    'Somente favoritos',
                  ),
                ),
                const PopupMenuItem(
                  value: FilterOptions.all,
                  child: Text(
                    'Todos',
                  ),
                ),
              ];
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (context, value, child) {
              return Badge(
                color: Colors.red,
                value: cart.itemCount,
                child: child!,
              );
            },
          )
        ],
        title: const Text(
          'Minha Loja',
        ),
      ),
      body: const ProductGrid(),
    );
  }
}
