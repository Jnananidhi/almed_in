import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'products/product_listing.dart';
class CartProvider with ChangeNotifier {
  List<Productt> _cartItems = [];

  List<Productt> get cartItems => _cartItems;

  void addToCart(Productt product) {

    _cartItems.add(product);
    notifyListeners();
  }

  // void addToCart(Productt product) {
  //   final existingProductIndex = _cartItems.indexWhere((p) => p.id == product.id);
  //
  //   if (existingProductIndex != -1) {
  //     Fluttertoast.showToast(
  //       msg: "Item already in the cart",
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.CENTER,
  //       fontSize: 16,
  //       backgroundColor: Colors.black,
  //       textColor: Colors.white,
  //     );
  //   } else {
  //     _cartItems.add(product);
  //   }
  //   notifyListeners();
  // }

  void removeFromCart(Productt product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  // void incrementQuantity(Productt product) {
  //   final index = _cartItems.indexOf(product);
  //   if (index != -1) {
  //     int quantity = int.tryParse(_cartItems[index].quantity) ?? 1;
  //     quantity++; // Increment the quantity as an integer
  //     _cartItems[index].quantity = quantity.toString(); // Convert back to String
  //     notifyListeners();
  //   }
  // }
  void incrementQuantity(Productt product) {
    final index = _cartItems.indexOf(product);
    if (index != -1) {
      int quantity = int.tryParse(_cartItems[index].quantity) ?? 1;
      double mrp = double.parse(_cartItems[index].mrp)/quantity;
      quantity++; // Increment the quantity as an integer
      _cartItems[index].quantity = quantity.toString(); // Convert back to String

      // Recalculate the price based on the new quantity
      double priceperitems = mrp*quantity;
      double newPrice = priceperitems; // Calculate the new price

      // Update the cart item price
      _cartItems[index].mrp = newPrice.toString();

      // Notify listeners after all updates
      notifyListeners();
    }
  }

  //
  // void decrementQuantity(Productt product) {
  //   final index = _cartItems.indexOf(product);
  //   if (index != -1) {
  //     int quantity = int.tryParse(_cartItems[index].quantity) ?? 0;
  //     if (quantity > 1) {
  //       quantity--; // Decrement the quantity as an integer
  //       _cartItems[index].quantity = quantity.toString(); // Convert back to String
  //       notifyListeners();
  //     } else {
  //       removeFromCart(product);
  //     }
  //   }
  // }

  void decrementQuantity(Productt product) {
    final index = _cartItems.indexOf(product);
    if (index != -1) {
      int quantity = int.tryParse(_cartItems[index].quantity) ?? 0;
      if (quantity > 1) {
        double mrp = double.parse(_cartItems[index].mrp)/quantity;
        quantity--; // Decrement the quantity as an integer
        _cartItems[index].quantity = quantity.toString(); // Convert back to String

        // Recalculate the price based on the new quantity
        double newPrice = mrp * quantity;  // Calculate the new price

        // Update the cart item price
        _cartItems[index].mrp = newPrice.toString();

        // Notify listeners after all updates
        notifyListeners();
      } else {
        removeFromCart(product);
      }
    }
  }

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
