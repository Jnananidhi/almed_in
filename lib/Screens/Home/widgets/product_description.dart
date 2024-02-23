import 'dart:js';

import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/products/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar1.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';

class ProductDescriptionScreen extends StatefulWidget {



  @override
  State<ProductDescriptionScreen> createState() => _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  List<Map<String, String>> details = [
    {'title': 'Content', 'detail': 'Bupronophine 10MCG patches 2'},
    {'title': 'Company', 'detail': 'Neon Labs'},
    {'title': 'Pack size', 'detail': '2 S , 18%'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
    body: Column(
    children: <Widget>[
    Expanded(
    child: Container(
      child: Column(
      children: [
      SizedBox(
      height: 10,
      ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
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
                          child:  Text(
                            'BUPREGISIC 10MCG PATCH',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Text(
                                        'Product Content',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        'Product Company',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        ),
                                      ),
                                    ],
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
                                Text(
                                  'Price: ₹10.99', // Example price
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                // Text(
                                //   'Quantity: 1', // Example quantity
                                //   style: TextStyle(
                                //     fontSize: 16.0,
                                //   ),
                                // ),
                                SizedBox(height: 10.0),
                                CustomButton(
                                  text: "Add to Cart",
                                  onPressed: () {
                                    //Navigator.pushNamed(context, "/contactUs");
                                    Navigator.pushNamed(context as BuildContext, "/product_description");
                                  },
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
            ),

          ),
      ],
      ),
    ),
    ),

      ],
    ),
    );
  }

  // Widget _buildProductDetails() {
  //   List<Map<String, String>> details = [
  //     {'title': 'Content', 'detail': 'Bupronophine 10MCG patches 2'},
  //     {'title': 'Company', 'detail': 'Neon Labs'},
  //     {'title': 'Pack size', 'detail': '2 S , 18%'},
  //   ];
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: details.map((detail) {
  //           return ListTile(
  //             contentPadding: EdgeInsets.all(0), // Adjusted padding
  //             title: Row(
  //               children: [
  //                 Container(
  //                   alignment: Alignment.center,
  //                   width: 16.0, // Adjusted width
  //                   height: 24.0,
  //                   child: Icon(
  //                     Icons.circle,
  //                     size: 8.0,
  //                   ),
  //                 ),
  //                 SizedBox(width: 4.0), // Adjusted width, reduce the space
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "Content : ${detail['detail']}",
  //                       style: TextStyle(
  //                         fontSize: 14.0,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     Text(
  //                       "Content : ${detail['detail']}",
  //                       style: TextStyle(
  //                         fontSize: 14.0,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             dense: true, // Reduce the gap between the items
  //           );
  //         }).toList(),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildProductCard() {
  //   return Padding(
  //     padding: EdgeInsets.all(5.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Price: ₹10.99', // Example price
  //           style: TextStyle(
  //             fontSize: 14.0,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(height: 5.0),
  //         // Text(
  //         //   'Quantity: 1', // Example quantity
  //         //   style: TextStyle(
  //         //     fontSize: 16.0,
  //         //   ),
  //         // ),
  //         SizedBox(height: 10.0),
  //         CustomButton(
  //           text: "Add to Cart",
  //           onPressed: () {
  //             //Navigator.pushNamed(context, "/contactUs");
  //             Navigator.pushNamed(context as BuildContext, "/product_description");
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}