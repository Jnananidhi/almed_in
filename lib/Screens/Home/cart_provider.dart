import 'package:flutter/material.dart';

import 'products/product_listing.dart';

class CartProvider with ChangeNotifier {
  List<Productt> _cartItems = [];

  List<Productt> get cartItems => _cartItems;

  void addToCart(Productt product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Productt product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  int get cartItemCount => _cartItems.length;
}
