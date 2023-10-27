import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Your Cart",
              style: TextStyle(
                fontSize: 24, // Adjust the font size as needed
                fontFamily: 'DMSans Bold'
              ),
            ),
          ),
          Text(" ${cart.cartItems.length} items added to cart",textAlign: TextAlign.left,style: TextStyle(fontSize: 15, fontFamily: 'DMSans Bold'),),
          Expanded(
            child: cart.cartItems.isEmpty
                ? Center(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Image.asset(
                'empty_cart.jpg', // Replace with the path to your empty cart image
                width: 500, // Adjust the width as needed
                height: 500, // Adjust the height as needed
              ),
                Text(
                  "Looks like you have not added any items to the cart\nGo ahead and add the items to cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontFamily: 'DMSans Regular'
                  ),
                ),
                ]
              ),
            )
                : ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                final product = cart.cartItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 10,

                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12), // Apply a border radius to the image
                        child: Image.network(
                          product.imageUrl, // Replace with the actual image URL or image source
                          width: 80, // Adjust the width as needed
                          height: 100, // Adjust the height as needed
                          fit: BoxFit.cover, // Adjust the fit mode as needed
                        ),
                      ),
                      title: Text(product.name),
                      subtitle: Text('\$${product.mrp}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kgreyColor, // Choose the border color
                                width: 1, // Choose the border width
                              ),
                              borderRadius: BorderRadius.circular(8), // Adjust the border radius as needed
                            ),
                            child:Row(
                            children:[ IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                // Decrement quantity
                                context.read<CartProvider>().decrementQuantity(product);
                              },
                            ),

                          Text('${product.quantity}'), // Display quantity
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              // Increment quantity
                              context.read<CartProvider>().incrementQuantity(product);
                            },
                          ),],
                          ),),
                          const SizedBox(width: 30),
                          IconButton(
                            onPressed: () {
                              // Remove the product from the cart
                              context.read<CartProvider>().removeFromCart(product);
                            },
                            icon: Icon(Icons.delete_outline_rounded, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
