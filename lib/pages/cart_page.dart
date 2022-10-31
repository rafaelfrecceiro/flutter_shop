import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/providers/order_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context, listen: false);
    final OrderProvider orderProvider = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) {
                      cart.removeItem(cart.itemList[index].productId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Item removido do carrinho!'),
                        ),
                      );
                    },
                    direction: DismissDirection.endToStart,
                    key: Key(cart.itemList[index].id),
                    background: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 10.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          cart.itemList[index].title,
                        ),
                        leading: Text(
                          cart.itemList[index].quantity.toString(),
                        ),
                        trailing: Text(
                          (cart.itemList[index].price *
                                  cart.itemList[index].quantity)
                              .toString(),
                        ),
                        subtitle: Text(cart.itemList[index].price.toString()),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total do carrinho: R\$ ${cart.totalCart}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      orderProvider.addOrder(cart.itemList, cart.totalCart);
                      cart.clear();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Carrinho esvaziado!'),
                        ),
                      );
                    },
                    child: const Text('Finalizar Compra'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
