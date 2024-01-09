import 'dart:convert';

import 'package:almed_in/Screens/Home/address_screen.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bill_summary_widget.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/menu_single.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/login_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'faq_screen.dart';


class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
  static _CartScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<_CartScreenState>();
  }
}

class _CartScreenState extends State<CartScreen> {
  String selectedMenuItem = 'Category';
  int quantity = 1;
  List cart = [];
  double shippingCost = 0;
  List dataa = [];

  String username = '';
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  Future getcartitems() async {
    var url = "${api}fetch_cart_items.php";
    var response = await http.post(Uri.parse(url), body: {
    "username": username });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        cart = jsonData;
      });

    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return cart;
  }

  void deletecartitem(String username, String productId) async {
    String url = '${api}delete_from_cart.php'; // Replace with your actual backend API endpoint

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
          'product_id': productId,
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'success') {
          // Product successfully added to cart
         // print('Product added to cart!');
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Item removed!',
              message:
              'Item removed from cart successfully..',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
        else if (jsonResponse['status'] == 'error')
        {
          print('error deleting cart');
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Error!',
              message:
              'There is some issue in removing the item from cart. Please try again',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
        else {
          // Failed to add the product to cart
          print('Failed to add product to cart: ${jsonResponse['message']}');

        }
      } else {
        // Handle other response status codes if needed
        print('Failed to add product to cart: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding to cart: $error');
    }
  }

  void updatecart(String username, String productId, String quantity , String total_price) async {
    String url = '${api}update_cart_item.php'; // Replace with your actual backend API endpoint

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
          'product_id': productId,
          'quantity':quantity,
          'total_price':total_price,
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'success') {
          // Product successfully added to cart
         // print('Product added to cart!');
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Updated!',
              message:
              'Cart updated successfully',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
        else if (jsonResponse['status'] == 'error')
        {
          print('error deleting cart');
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Failed',
              message:
              'Failed to update cart..',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
        else {
          // Failed to add the product to cart
          print('Failed to add product to cart: ${jsonResponse['message']}');

        }
      } else {
        // Handle other response status codes if needed
        print('Failed to add product to cart: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding to cart: $error');
    }
  }
  void fetchCartPrice(String username) async {
    String url = '${api}fetch_cart_price.php';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {
          // If 'status' is 'success', assume there is a 'data' field
          var data = jsonData['data'];

          // Handle 'data' as needed
          setState(() {
            dataa = data;
          });
          print(dataa);
        } else {
          // Handle other cases or show an error message
          print('Failed to fetch cart price: ${jsonData['message']}');
        }
      } else {
        // Handle other response status codes if needed
        print('Failed to fetch cart price: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching cart price: $error');
    }
  }


  @override
  void initState() {
    Future.wait([_loadUsername() ]).then((_) {
      // After both therapeautic and form data are fetched, proceed to group items
      getcartitems();
      fetchCartPrice(username);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int parsedValue = 1;

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
              " ${cart.length} items added to cart",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'DMSans Bold',
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: cart.length==0
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
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          TextEditingController quantityController = TextEditingController();
                          num pprice = num.tryParse(cart[index]['pprice']) ?? 0;

                          return Container(
                            height: 100,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Align(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text(cart[index]['product_name']),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Display the dynamically calculated total price
                                      Text('\$${(pprice * (int.tryParse(cart[index]['quantity'] ?? '1') ?? 1))}'),
                                      const SizedBox(width: 20,),
                                      Container(

                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: kgreyColor,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                //Navigator.of(context).pop();
                                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                  builder: (context) => CartScreen(), // Replace with the actual class name of your page
                                                ));
                                                deletecartitem(username,cart[index]['product_id']);
                                                print(username);
                                                print(cart[index]['product_id']);

                                              },
                                              icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                                            ),
                                            const SizedBox(width: 30),
                                            Container(
                                              width: 100,
                                              child:TextField(
                                                controller: quantityController,
                                                decoration: InputDecoration(
                                                  hintText: cart[index]['quantity'],
                                                  border: OutlineInputBorder(),
                                                ),
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  // Ensure the value is between 1 and 100
                                                  int parsedValue = int.tryParse(value) ?? 1;
                                                  parsedValue = parsedValue.clamp(1, 100);

                                                  // Update the quantity in the cart list
                                                  cart[index]['quantity'] = parsedValue.toString();
                                                },
                                                onSubmitted: (value) {
                                                  // Handle the submitted value if needed
                                                },
                                              ),

                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  int parsedValue = int.tryParse(quantityController.text) ?? 1;
                                                  parsedValue = parsedValue.clamp(1, 100);

                                                  cart[index]['quantity'] = parsedValue.toString();
                                                });
                                                //to refresh the page...
                                                //Navigator.of(context).pop();
                                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                  builder: (context) => CartScreen(), // Replace with the actual class name of your page
                                                ));
                                                num calculatedValue = pprice * (int.tryParse(cart[index]['quantity'] ?? '1') ?? 1);
                                                print('calculatedValue$calculatedValue');
                                                updatecart(username,cart[index]['product_id'],cart[index]['quantity'],calculatedValue.toString());

                                              },
                                              icon: const Icon(Icons.done, color: Colors.green),
                                            ),

                                          ],
                                        ),
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
                        Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Adjust the value for the desired border curvature
                        ),
                        child: Container(
                          height: 280,
                          padding: EdgeInsets.only(top: 30,right: 16,left: 16),
                          decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            //   colors: [
                            //     lightColor, // Start color
                            //     kSecondaryColor, // End color (same color for a solid effect)
                            //   ],
                            // ),
                            color: Colors.white,
                            //border: Border.all(color: kPrimaryColor,width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Bill Summary',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'DMSans Bold',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 5),
                              Divider(thickness: 2,),
                              SizedBox(height: 5),
                              BillItem(label: 'Total Bill (MRP) ' ,value:dataa[0]['total']),
                              SizedBox(height: 5),
                              BillItem(label: 'Total Discount ',value:'-0'),
                              SizedBox(height: 5),
                              BillItem(label: 'Shipping Fee ' ,value: '50'),
                              Divider(thickness: 2,),
                              SizedBox(height: 5),
                              BillItem(label: 'To Be Paid ',value:dataa[0]['total']),
                            ],
                          ),
                        ),
                      ), // Display the bill summary widget
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              child:Container(
                                  height: 50,
                                  child: const Center(child: Text("Select Delivery Address"))),
                              onPressed: () {
                                Navigator.pushNamed(context, '/address-page');
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
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
          Positioned(
            top: MediaQuery.of(context).size.width < 600
                ? 90// Adjust the value for mobile view
                :50,
            left: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
            right: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.25,
            child: Search_bar(),
          ),
        ],),
    );
  }
}
