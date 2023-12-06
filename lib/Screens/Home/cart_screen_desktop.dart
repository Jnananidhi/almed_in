import 'package:almed_in/Screens/Home/address_screen.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bill_summary_widget.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/menu_single.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Authentication/login_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'faq_screen.dart';


class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String selectedMenuItem = 'Category';
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: kWhiteColor,
      drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Image(image: AssetImage('assets/logo.png'),height: 80),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                isActive: true,
                title: 'Home',
                press: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'About Us',
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
                },
              ),

              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'FAQ',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FaqScreen()),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),

              DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: selectedMenuItem,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedMenuItem = newValue;
                      // Add logic to navigate to the related page based on selectedMenuItem
                      if (selectedMenuItem == 'Therapeutic') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),

                        );

                      } else if (selectedMenuItem == 'Strength') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                        );
                      }
                      else if (selectedMenuItem == 'Company') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                        );
                      }else if (selectedMenuItem == 'Form') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                        );
                      }
                    });
                  }
                },
                items: ['Category','Therapeutic', 'Company', 'Form', 'Strength']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:  18 ,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                // Set the underline property to Container() to hide the underline.
                underline: Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'Vendor?',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginPage()),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'Contact Us',
                press: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsApp()));},
              ),
            ],
          )),
      body: Stack(
        children:[ Column(
          children: [
            Navigation(),
            Divider(
              thickness: 1,
              height: 0.01, // Set the height of the divider line
              color: kPrimaryColor, // Set the color of the divider line
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Your Cart",
                style: TextStyle(
                  fontSize: 24, // Adjust the font size as needed
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
                  : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: Row(
                children: [
                    Flexible(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: cart.cartItems.length,
                        itemBuilder: (context, index) {
                          final product = cart.cartItems[index];
                          return Container( // Wrap the Card with a Container
                            height: 150, // Set the desired height
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Align( // Use Align to center the contents vertically
                                alignment: Alignment.center,
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
                                  title: Text(product.name),
                                  subtitle: Text('\$${product.mrp}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: kgreyColor,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove,color: kPrimaryColor,),
                                              onPressed: () {
                                                context
                                                    .read<CartProvider>()
                                                    .decrementQuantity(product);
                                              },
                                            ),
                                            Text('${product.quantity}'),
                                            IconButton(
                                              icon: const Icon(Icons.add,color: kPrimaryColor),
                                              onPressed: () {
                                                context
                                                    .read<CartProvider>()
                                                    .incrementQuantity(product);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 30),
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
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BillSummary(), // Display the bill summary widget
                          const SizedBox(height: 10),
                          Center(
                            child: CustomButton(
                              label: 'Select Delivery Address',
                              onPressed: () {
                                Navigator.pushNamed(context, '/address-page');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
                  ),
            ),
          ],
        ),
      ],),
    );


  }
}
//end