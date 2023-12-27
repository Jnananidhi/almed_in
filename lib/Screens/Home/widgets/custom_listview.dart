//this is product showing page
import 'dart:convert';

import 'package:almed_in/Screens/Home/Authentication/login_status.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/widgets/Checkoutscreen_mobile.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/order_success.dart';
import 'package:almed_in/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../constants.dart';
import '../Authentication/login_screen.dart';
import '../about_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../products/products_screen.dart';
import 'Checkoutscreen.dart';
import 'menu.dart';

class ProductListItem extends StatefulWidget {
  final Productt product;

  const ProductListItem(this.product, {super.key});

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  String selectedMenuItem = 'Category';
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
      body: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Adjust the value for the desired border curvature
        ),

        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Image.network(
            widget.product.imageUrl,
            width: 200,
            height: 200,
          ),
          title: Text(
            widget.product.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quantity: ${widget.product.quantity}'),
              Text(
                'MRP: ${widget.product.mrp}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Discount: ${widget.product.discount}',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ProductItem extends StatefulWidget {
  final Productt product;

  ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState(product);
}

class _ProductItemState extends State<ProductItem> {
  String username = "";
    Future getusername() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        username = preferences.getString('username')!;
      });
    }
    @override
    void initState() {
      getusername();
      print("username : $username");
      super.initState();
  }
  _ProductItemState(Productt product);

  void addToCart(String username, String productId, int quantity, String productName, String price) async {
    String url = '${api}add_to_cart.php'; // Replace with your actual backend API endpoint
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
          'product_id': productId,
          'quantity': quantity.toString(),
          'product_name': productName,
          'price':price,
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'success') {
          // Product successfully added to cart
          print('Product added to cart!');
          Fluttertoast.showToast(
              msg: "Item added to cart",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP_RIGHT,
              fontSize: 16,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
        else if (jsonResponse['status'] == 'error')
        {
          Fluttertoast.showToast(
              msg: "Item is already in the cart",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP_RIGHT,
              fontSize: 16,
              backgroundColor: Colors.black,
              textColor: Colors.white);
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


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width, // Set the width to the desired size
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: kgreyColor, width: 3),

        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.product.imageUrl,
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
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'DMSans Bold',
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Quantity: ${widget.product.quantity}',
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
                      'Content:${widget.product.content}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'DMSans Bold',
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Company:${widget.product.company}',
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
                              'Price: ${widget.product.mrp}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'DMSans Bold',
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text(
                              'Discount: ${widget.product.discount}',
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

                        addToCart(username,widget.product.id,1,widget.product.name,widget.product.mrp as String);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ProductScreen(), // Replace with the actual class name of your page
                        ));
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
                                    //Navigator.of(context).pop();
                                    Navigator.pushNamed(context, "/login");
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
                        if(Responsive.isDesktop(context)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreen()),
                          );
                        }else if(Responsive.isMobile(context)){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreenMobile()),
                          );
                        }
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
      ),
    );
  }
}
class ProductItem_mobile extends StatefulWidget {
  final Productt product;

  ProductItem_mobile(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductItem_mobile> createState() => ProductItem_mobileState(product);
}

class ProductItem_mobileState extends State<ProductItem_mobile> {
  String username = "";
  Future getusername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('username')!;
    });
  }
  @override
  void initState() {
    getusername();
    print("username : $username");
    super.initState();
  }
  ProductItem_mobileState(Productt product);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10,bottom: 3),
      child: Container(
        width: MediaQuery.of(context).size.width, // Set the width to the desired size
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: kgreyColor, width: 3),

        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.product.imageUrl,
                    width: 30,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  children:[ Container(
                    width: MediaQuery.of(context).size.width/3,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: 'DMSans Bold',
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Quantity: ${widget.product.quantity}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'DMSans Regular',
                          ),
                        ),

                      ],
                    ),
                  ),
                    Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          if (username != "") {
                            // User is logged in, display the Container with prices
                            return Container(
                              width: MediaQuery.of(context).size.width/3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price: ${widget.product.mrp}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'DMSans Bold',
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    'Discount: ${widget.product.discount}',
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
                            return Container(margin: EdgeInsets.all(10),child: Text('Login to view prices',style: TextStyle(fontFamily: 'DMSans Bold',color: Colors.red),));
                          }
                        }),]
                ),
              ],
            ),
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
                          // final cartProvider = context.read<CartProvider>();
                          // final isAlreadyInCart = cartProvider.isProductInCart(widget.product);
                          // if (isAlreadyInCart) {
                          //   Fluttertoast.showToast(
                          //     msg: "Item is already in the cart!",
                          //     toastLength: Toast.LENGTH_LONG,
                          //     gravity: ToastGravity.CENTER,
                          //     fontSize: 16,
                          //     backgroundColor: Colors.black,
                          //     textColor: Colors.white,
                          //   );
                          // } else {
                        //     cartProvider.addToCart(widget.product);
                        //     Fluttertoast.showToast(
                        //       msg: "Item Added to Cart",
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       gravity: ToastGravity.CENTER,
                        //       fontSize: 16,
                        //       backgroundColor: Colors.black,
                        //       textColor: Colors.white,
                        //     );
                        //   }

                         }
                        else{
                          Fluttertoast.showToast(
                            msg: "Please login to add items to your cart",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                        },
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
                        if(Responsive.isDesktop(context)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreen()),
                          );
                        }else if(Responsive.isMobile(context)){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreenMobile()),
                          );
                        }
                      },
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),]
          ),
        ),
      ),
    );
  }
}