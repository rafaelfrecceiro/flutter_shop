import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item {
    return {..._items};
  }

  List<CartItem> get itemList {
    var list = [];
    _items.forEach((k, v) => list.add(v));
    return [...list];
  }

  double get totalCart {
    double total = 0.0;
    _items.forEach((k, v) => total += (v.price * v.quantity));
    return total;
  }

  int get itemCount {
    return _items.length;
  }

  void removeItem(String id) {
    _items.removeWhere((key, value) => value.productId == id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void addItem(Product prod) {
    if (_items.containsKey(prod.id)) {
      _items.update(
        prod.id,
        (value) {
          return CartItem(
            id: value.id,
            productId: value.productId,
            title: value.title,
            quantity: value.quantity + 1,
            price: value.price,
          );
        },
      );
    } else {
      _items.putIfAbsent(
        prod.id,
        () {
          return CartItem(
            id: Random().nextDouble().toString(),
            productId: prod.id,
            title: prod.title,
            quantity: 1,
            price: prod.price,
          );
        },
      );
    }
    notifyListeners();
  }
}
