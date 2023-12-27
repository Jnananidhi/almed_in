import 'package:almed_in/Screens/Home/address_screen.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/widgets/bill_summary_widget.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/mobile_topbar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartScreenMobile extends StatefulWidget {

  @override
  State<CartScreenMobile> createState() => _CartScreenMobileState();
  static _CartScreenMobileState? of(BuildContext context) {
    return context.findAncestorStateOfType<_CartScreenMobileState>();
  }
}

class _CartScreenMobileState extends State<CartScreenMobile> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
   // List cart = [];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Align children to the left
        children: [
          MobileNavigation(),
          Divider(
            thickness: 1,
            height: 0.01, // Set the height of the divider line
            color: kPrimaryColor, // Set the color of the divider line
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Your Cart",
              style: TextStyle(
                fontSize: 20, // Adjust the font size as needed
                fontFamily: 'DMSans Bold',
              ),
            ),
          ),
          Text(
            " ${cart.cartItems.length} items added to cart",
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'DMSans Bold',
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: cart.cartItems.isEmpty
                ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/empty_cart.jpg',
                    width: 500,
                    height: 300,
                  ),
                  const Text(
                    "Looks like you have not added any items to the cart\nGo ahead and add the items to the cart",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'DMSans Regular',
                    ),
                  ),
                ],
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cart.cartItems[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.imageUrl,
                              width: 80,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name),
                              Text('\$${product.mrp}'),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kgreyColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        // context
                                        //     .read<CartProvider>()
                                        //     .decrementQuantity(product);
                                      },
                                    ),
                                    Text('${product.quantity}'),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        // context
                                        //     .read<CartProvider>()
                                        //     .incrementQuantity(product);
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<CartProvider>()
                                            .removeFromCart(product);
                                      },
                                      icon: const Icon(Icons.delete_outline_rounded,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              // Reduce the spacing

                            ],
                          ),

                      )
                      );},
                  ),
                ),
                BillSummary(), // Display the bill summary widget
                Center(
                  child: CustomButton(
                    label: 'Select Delivery Address',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddressScreen()),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
//end