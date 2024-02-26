//this is product showing page
import 'dart:convert';

import 'package:almed_in/Screens/Home/Authentication/login_screen.dart';
import 'package:almed_in/Screens/Home/Authentication/login_status.dart';
import 'package:almed_in/Screens/Home/about_screen.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/products/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/constants.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;


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
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Added to cart',
              message:
              'Item successfully added to your cart..',

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
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Failed',
              message:
              'Item already in your cart..',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.help,
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


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: kgreyColor, width: 3),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // For larger screens, display in a row with image on the left
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset(
                      'Form.webp', // Replace with your product image URL
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Company : ${widget.product.company}',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'DMSans regular'
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 16.0, // Adjusted width
                            height: 24.0,
                            child: Icon(
                              Icons.circle,
                              size: 8.0,
                            ),
                          ),
                          SizedBox(width: 4.0), // Adjusted width, reduce the space
                          Expanded(
                            child: Text(
                              'Content : ${widget.product.content}',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'DMSans regular',
                                height: 1.5,
                              ),
                              softWrap: true, // Allow line breaks for long text
                              maxLines: 3,
                              // Set the maximum number of lines
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 10.0),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       alignment: Alignment.center,
                      //       width: 16.0, // Adjusted width
                      //       height: 24.0,
                      //       child: Icon(
                      //         Icons.circle,
                      //         size: 8.0,
                      //       ),
                      //     ),
                      //     SizedBox(width: 4.0), // Adjusted width, reduce the space
                      //     Text(
                      //       'Company: ${widget.product.company}',
                      //       style: TextStyle(
                      //         fontSize: 14.0,
                      //         fontFamily: 'DMSans regular',
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 16.0, // Adjusted width
                            height: 24.0,
                            child: Icon(
                              Icons.circle,
                              size: 8.0,
                            ),
                          ),
                          SizedBox(width: 4.0), // Adjusted width, reduce the space
                          Text(
                            'Pack Size',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'DMSans regular',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 10.0),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0),
                        if (username != "")
                          Column(
                            children: [
                              Text(
                                'Price : \₹${widget.product.mrp}', // Example price
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'DMSans regular'
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Discount :  \₹${widget.product.discount}', // Example quantity
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.green,
                                    fontFamily: 'DMSans regular'
                                ),
                              ),
                            ],
                          )

                        else
                          TextButton( onPressed: () async {
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
                            child: Text('Login to view prices',style: TextStyle(fontFamily: 'DMSans Bold',color: Colors.red),),),
                        SizedBox(height: 10.0),
                        CustomButton(
                          text: "Add to Cart",
                          onPressed: () {
                            if (username != "") {

                              addToCart(username,widget.product.id,1,widget.product.name,widget.product.mrp);
                              Navigator.pushNamed(context, "/product-screen");}

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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            // For smaller screens, display in a column with image on top
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'Form.webp', // Replace with your product image URL
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.0), // Reduce the height here
                //_buildProductDetails(),
              ],
            );
          }
        },
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
                      fit: BoxFit.contain,
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
                              'Company:${widget.product.company}',
                              style: TextStyle(
                                color: Colors.black,
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
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Login!',
                                  message:
                                  'Please login to add this item to your cart..',

                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType: ContentType.warning,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
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
                    // Container(
                    //   margin: EdgeInsets.all(10),
                    //   child: MaterialButton(
                    //     shape: RoundedRectangle Border(
                    //         borderRadius: BorderRadius.circular(50)),
                    //     color: kPrimaryColor,
                    //     height: 40,
                    //     onPressed: () {
                    //       if(Responsive.isDesktop(context)) {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => CheckoutScreen()),
                    //         );
                    //       }else if(Responsive.isMobile(context)){
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => CheckoutScreenMobile()),
                    //         );
                    //       }/
                    //     },
                    //     child: const T ext(
                    //       "Buy Now",
                    //       style: TextStyle(color: kWhiteColor),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),]
          ),
        ),
      ),
    );
  }
}