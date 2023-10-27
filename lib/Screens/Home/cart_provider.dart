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

  void incrementQuantity(Productt product) {
    final index = _cartItems.indexOf(product);
    if (index != -1) {
      int quantity = int.tryParse(_cartItems[index].quantity) ?? 1;
      quantity++; // Increment the quantity as an integer
      _cartItems[index].quantity = quantity.toString(); // Convert back to String
      notifyListeners();
    }
  }

  void decrementQuantity(Productt product) {
    final index = _cartItems.indexOf(product);
    if (index != -1) {
      int quantity = int.tryParse(_cartItems[index].quantity) ?? 0;
      if (quantity > 1) {
        quantity--; // Decrement the quantity as an integer
        _cartItems[index].quantity = quantity.toString(); // Convert back to String
        notifyListeners();
      } else {
        removeFromCart(product);
      }
    }
  }

  int get cartItemCount => _cartItems.length;

}
