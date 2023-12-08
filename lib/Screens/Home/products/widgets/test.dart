//this is product showing page
import 'dart:convert';

import 'package:almed_in/Screens/Home/Authentication/login_status.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/order_success.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';
import '../../../../responsive.dart';
import '../../Authentication/login_screen.dart';
import '../../about_screen.dart';
import '../../contact_screen.dart';
import '../../faq_screen.dart';
import '../../widgets/Checkoutscreen.dart';
import '../../widgets/menu.dart';
import '../products_screen.dart';
import 'package:http/http.dart' as http;


class ProductttItem extends StatefulWidget {
  final String? selectedMenuItem,selectedProductName;

  ProductttItem({this.selectedMenuItem,this.selectedProductName});

  @override
  State<ProductttItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductttItem> {
  String selectedMenuItem = 'Category';
  List products = [];
  bool isLoading = true;
  String username = "";
  Future getusername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('username')!;
    });
  }

  //get selectedProductName => selectedProductName;
  @override
  void initState() {
    super.initState();
    fetchProducts();
    getusername();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }


  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('${api}products_display.php'));
    if (response.statusCode == 200) {
      List productsData = json.decode(response.body);
      if (widget.selectedProductName != null && widget.selectedProductName!.isNotEmpty) {
        // Filter the products list based on the selected product name
        productsData = productsData.where((product) =>
        product.name.toLowerCase() == widget.selectedProductName?.toLowerCase()
        ).toList();
      }
      setState(() {
        products = productsData;
      });
    } else {
      // Handle the error when the HTTP request fails
      print('Failed to load products');h
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
              child: Text(
                widget.selectedMenuItem ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            // Display the custom Navigation widget if needed
            products.isEmpty
                ? Center(child: Text('No data available')) // Display 'No data available' text
                :Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return  Container(
                    width: MediaQuery.of(context).size.width, // Set the width to the desired size
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: kgreyColor, width: 3),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product['image'],
                              width: 80,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width/4,
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //widget.product.name,
                                  product['product_name'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'DMSans Bold',
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  'Quantity: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'DMSans Regular',
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width/4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Content:${product["content"]}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'DMSans Bold',
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  'Company:${product["company"]}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'DMSans Regular',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Consumer<AuthProvider>(
                              builder: (context, authProvider, child) {
                                if (username != "") {
                                  // User is logged in, display the Container with prices
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width/8,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Price: ',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontFamily: 'DMSans Bold',
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text(
                                          'Discount:',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'DMSans Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  // User is not logged in, show login button or other content
                                  return Container(margin: EdgeInsets.all(10),
                                      child: TextButton( onPressed: () async {
                                        // Navigate to ScreenB
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => LoginPage()),
                                        );

                                        if (result == true) {
                                          // If the result is true, refresh ScreenA
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => ProductScreen()),
                                          );
                                        }
                                      },
                                        child: Text('Login to view prices',style: TextStyle(fontFamily: 'DMSans Bold',color: Colors.red),),));
                                }
                              }),
                          SizedBox(width: 20,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: MaterialButton(
                                    color: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50)),
                                    height: 40,
                                    onPressed: () {
                                      if (username != "") {
                                        final cartProvider = context.read<CartProvider>();
                                        final isAlreadyInCart = cartProvider.isProductInCart(product);

                                        if (isAlreadyInCart) {
                                          Fluttertoast.showToast(
                                            msg: "Item is already in the cart!",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            fontSize: 16,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                          );
                                        } else {
                                          cartProvider.addToCart(product);
                                          Fluttertoast.showToast(
                                            msg: "Item Added to Cart",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            fontSize: 16,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                          );
                                        }
                                      }
                                      else{
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: const Text('Please login to add item in your cart'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }},
                                    child: const Text(
                                      "Add to Cart",
                                      style: TextStyle(color: kWhiteColor),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  color: kPrimaryColor,
                                  height: 40,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckoutScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Buy Now",
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                ),
                              ),
                            ],
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

        ], ),
    );
  }
}

