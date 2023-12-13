import 'dart:convert';

import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'products/product_listing.dart';
class CartProvider with ChangeNotifier {
  List<Productt> _cartItems = [];
  List<Productt> get cartItems => _cartItems;


  // void addToCart(Productt product) {
  //
  //   _cartItems.add(product);
  //   notifyListeners();
  // }
  static const String addUrl = '${api}add_to_cart.php';
  static const String removeUrl = '${api}remove_from_cart.php';
  Future<void> addToCart(Productt product) async {
    _cartItems.add(product);
    notifyListeners();
    // Convert cart data to JSON
    List<Map<String, dynamic>> cartData = _cartItems.map((item) => productToMap(item)).toList();
    try {
      // Send cart data to the API for database storage
      final response = await http.post(
        Uri.parse(addUrl),
        body: jsonEncode({'cartItems': cartData}),
      );

      if (response.statusCode != 200) {
        // Handle the case where the server didn't return a 200 OK response
        removeFromCart(product); // Roll back the local state change
        Fluttertoast.showToast(msg: 'Failed to add item to cart');
      }
    } catch (error) {
      // Handle network or other errors
      removeFromCart(product); // Roll back the local state change
      Fluttertoast.showToast(msg: 'Error adding item to cart');
    }
  }

  // Convert Productt to a map
  Map<String, dynamic> productToMap(Productt product) {
    return {
      'id': product.id,
      'name': product.name,
      'quantity': product.quantity,
      // Add other properties as needed
    };
  }

  // void removeFromCart(Productt product) {
  //   _cartItems.remove(product);
  //   notifyListeners();
  // }
  Future<void> removeFromCart(Productt product) async {
    _cartItems.remove(product);
    notifyListeners();

    // Convert cart data to JSON

  }



  // void incrementQuantity(Productt product) {
  //   final index = _cartItems.indexOf(product);
  //   if (index != -1) {
  //     int quantity = (_cartItems[index].quantity) ?? 1;
  //     double mrp = double.parse(_cartItems[index].mrp)/quantity;
  //     quantity++; // Increment the quantity as an integer
  //     _cartItems[index].quantity = quantity; // Convert back to String
  //
  //     // Recalculate the price based on the new quantity
  //     double priceperitems = mrp*quantity;
  //     double newPrice = priceperitems; // Calculate the new price
  //
  //     // Update the cart item price
  //     _cartItems[index].mrp = newPrice.toString();
  //
  //     // Notify listeners after all updates
  //     notifyListeners();
  //   }
  // }



  // void decrementQuantity(Productt product) {
  //   final index = _cartItems.indexOf(product);
  //   if (index != -1) {
  //     int quantity = _cartItems[index].quantity ?? 0;
  //     if (quantity > 1) {
  //       double mrp = double.parse(_cartItems[index].mrp)/quantity;
  //       quantity--; // Decrement the quantity as an integer
  //       _cartItems[index].quantity = quantity; // Convert back to String
  //
  //       // Recalculate the price based on the new quantity
  //       double newPrice = mrp * quantity;  // Calculate the new price
  //
  //       // Update the cart item price
  //       _cartItems[index].mrp = newPrice.toString();
  //
  //       // Notify listeners after all updates
  //       notifyListeners();
  //     } else {
  //       removeFromCart(product);
  //     }
  //   }
  // }

  //for total MRP in bill summary
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
      double discount = double.parse(product.discount);
      totalDiscount = discount;
    }
    return totalDiscount;
  }

  double calculateTotalAmount(double shippingCost) {
    double totalMRP = calculateTotalMRP();
    double totalDiscount = calculateTotalDiscount();
    double totalAmount = totalMRP - totalDiscount + shippingCost;
    return totalAmount;
  }

  int get cartItemCount => _cartItems.length;

  // to check whether product is in the cart or not it works in custom_listview.dart while add to cart button working
  bool isProductInCart(Productt product) {
    return _cartItems.contains(product);
  }




}
