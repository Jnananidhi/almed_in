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
  double calculateTotalMRP() {
    double totalMRP = 0;
    for (Productt product in _cartItems) {
      totalMRP += double.parse(product.mrp);
    }
    return totalMRP;
  }

  double calculateTotalDiscount() {
    double totalDiscount = 0;
    for (Productt product in _cartItems) {
      double mrp = double.parse(product.mrp);
      double discount = double.parse(product.discount);
      totalDiscount += (mrp - discount);
    }
    return totalDiscount;
  }

  double calculateTotalAmount(double shippingCost) {
    double totalMRP = calculateTotalMRP();
    double totalDiscount = calculateTotalDiscount();
    double totalAmount = totalMRP - totalDiscount - shippingCost;
    return totalAmount;
  }
  int get cartItemCount => _cartItems.length;


}
