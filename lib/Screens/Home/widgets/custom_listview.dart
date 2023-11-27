//this is product showing page
import 'package:almed_in/Screens/Home/Authentication/login_status.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/widgets/order_success.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
//
//
// class ProductItem extends StatefulWidget {
//   final Productt product;
//
//   ProductItem(this.product, {super.key});
//
//   @override
//   State<ProductItem> createState() => ProductItemState(
//       product: product);
// }
//
// class ProductItemState extends State<ProductItem> {
//   var product;
//     ProductItemState(
//   {required this.product});
//
//   bool isHover = false;
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     final widthPercentage = 0.3; // 30% of the screen width
//     final heightPercentage = 0.5; // 20% of the screen height
//
//     final containerWidth = screenWidth * widthPercentage;
//     final containerHeight = screenHeight * heightPercentage;
//     return Container(
//         margin: EdgeInsets.only(left: 10,right: 10),
//       child: InkWell(
//         onTap: (){},
//         onHover: (value) {
//           setState(() {
//             isHover = value;
//           });
//         },
//         child: AnimatedContainer(
//           duration: kDefaultDuration,
//           width: containerWidth,
//           height: containerHeight,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20.0),
//               border: Border.all(color: kgreyColor, width: 3),
//               boxShadow: [if (isHover) kDefaultShadow]),
//           child: Stack(
//               fit: StackFit.passthrough,
//               children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Image.network(
//                 product.imageUrl,
//                 fit: BoxFit.fitWidth,
//             ),
//               ),
//             const SizedBox(
//               height: 10,
//             ),
//
//             Text(
//               product.name,
//               style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.black,
//                   fontFamily: 'DMSans Regular'
//               ),
//             ),
//
//                 Text('Quantity: ${product.quantity}',style: TextStyle(
//                     color: Colors.grey,
//                     fontFamily: 'DMSans Light'
//                 ),),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   'Price: ${product.mrp}',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                     fontFamily: 'DMSans Regular'
//                   ),
//                 ),
//                 Text(
//                   'Discount: ${product.discount}',
//                   style: TextStyle(
//                     color: Colors.green,
//                       fontFamily: 'DMSans Light'
//                   ),
//                 ),
//               ],
//             ),
//           ),
//                 isHover
//                     ? Container(
//                   color: Colors.black12,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         color: kSecondaryColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50)),
//                         height: 40,
//                         onPressed: () {
//                           context.read<CartProvider>().addToCart(product);
//                             Fluttertoast.showToast(
//                             msg: "Item Added to Cart",
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.CENTER,
//                             fontSize: 16,
//                             backgroundColor: Colors.black,
//                             textColor: Colors.white);
//
//                         },
//                         child: const Text(
//                           "Add to Cart",
//                           style: TextStyle(color: kWhiteColor),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       MaterialButton(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50)),
//                         color: kSecondaryColor,
//                         height: 40,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => CheckoutScreen()),
//                           );
//                         },
//                         child: const Text(
//                           "Buy Now",
//                           style: TextStyle(color: kWhiteColor),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//                     : Container(),
//               ],
//           ),
//         )),
//     );
//   }
//   }

class ProductItem extends StatefulWidget {
  final Productt product;

  ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState(product);
}

class _ProductItemState extends State<ProductItem> {
  _ProductItemState(Productt product);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width, // Set the width to the desired size
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: kgreyColor, width: 3),
          boxShadow: [kDefaultShadow],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width/2,
                margin: EdgeInsets.all(10),
                child: Column(
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
                    Text(
                      'Quantity: ${widget.product.quantity}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'DMSans Light',
                      ),
                    ),

                  ],
                ),
              ),
              Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.isLoggedIn) {
                      // User is logged in, display the Container with prices
                      return Container(
                        width: MediaQuery.of(context).size.width/8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price: ${widget.product.mrp}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'DMSans Regular',
                              ),
                            ),
                            Text(
                              'Discount: ${widget.product.discount}',
                              style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'DMSans Light',
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // User is not logged in, show login button or other content
                      return ElevatedButton(
                        onPressed: () {
                          // Navigate to the login screen
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Login to view prices'),
                      );}}),

              Column(
                children: [
                  MaterialButton(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    height: 40,
                    onPressed: () {

                      final cartProvider = context.read<CartProvider>();
                      final isAlreadyInCart = cartProvider.isProductInCart(widget.product);

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
                        cartProvider.addToCart(widget.product);
                        Fluttertoast.showToast(
                          msg: "Item Added to Cart",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          fontSize: 16,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                      }
                    },
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(color: kWhiteColor),
                    ),
                  ),
                  SizedBox(height: 5,),
                  MaterialButton(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
