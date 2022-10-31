import 'package:flutter/material.dart';
import 'package:flutter_shop/data/dummy.dart';
import 'package:flutter_shop/models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  bool _showFavoriteOnly = false;

  bool get showFavoriteOnly {
    return _showFavoriteOnly;
  }

  List<Product> get items {
    if (_showFavoriteOnly) {
      return _items.where((element) => element.isFavorite).toList();
    }
    return [..._items];
  }

  void showFavorites() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeAt(int.parse(id));
    notifyListeners();
  }
}
