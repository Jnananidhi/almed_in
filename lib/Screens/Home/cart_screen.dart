import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: ListView.builder(
        itemCount: cart.cartItems.length,
        itemBuilder: (context, index) {
          final product = cart.cartItems[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.mrp}'),
            trailing: ElevatedButton(
              onPressed: () {
                // Remove the product from the cart
                context.read<CartProvider>().removeFromCart(product);
              },
              child: Text('Remove'),
            ),
          );
        },
      ),
    );
  }
}
