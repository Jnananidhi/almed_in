import 'dart:convert';

import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/custom_listview.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar1.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:http/http.dart'as http;

import '../../../constants.dart';
import '../../../responsive.dart';
class FetchedCategoryProduct extends StatefulWidget {
  //final List<String>? selectedProductNames;//selectedProductNames is from search bar onclick
  final String? selectedProductName;//selectedProductName from alphabetic search onclick
  const FetchedCategoryProduct({super.key,this.selectedProductName});

  @override
  State<FetchedCategoryProduct> createState() => _ProductScreenState();
}
class _ProductScreenState extends State<FetchedCategoryProduct> {
  String? get selectedProductName => widget.selectedProductName;
  //List<String>? get selectedProductNames=>selectedProductNames;
  List<Productt> products = [];

  @override
  void initState() {
    super.initState();
    // print("selectedproductnames:$selectedProductNames");
    fetchProductCountAndProducts();
    print("nidhiiii$selectedProductName");
  }

  Future<void> fetchProductCountAndProducts() async {
    await fetchAllProducts();
  }


  Future<void> fetchAllProducts() async {

    var url = "${api}fetchCategoryItem.php";
    var response = await http.post(Uri.parse(url),body: {
      "searchTerm": selectedProductName,
    }
    );


    if (response.statusCode == 200) {
      print('Response body: ${response.body}');

      final List<dynamic> jsonData = json.decode(response.body);
      List<Productt> productsData = jsonData.map((item) => Productt.fromJson(item)).toList();
      setState(() {
        products = productsData;
      });

      //print('Products loaded successfully for page $currentPage');
    } else {
      // print('Failed to load products for page $currentPage');
      // print('Response status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Navigation(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(minHeight: screenHeight/1.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (var product in products)
                              Container(
                                height: Responsive.isDesktop(context) ? 120 : 200,
                                child: Responsive.isDesktop(context)
                                    ? ProductItem(product)
                                    : ProductItem_mobile(product),
                              ),
                          ],
                        ),
                      ),
                      BottomNav(),
                    ],
                  ),
                ),
              ),
            ],

          ),
          Positioned(
            top: MediaQuery.of(context).size.width < 600
                ? 90 // Adjust the value for mobile view
                : 20,
            left: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
            right: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.25,
            child: Search_bar1(),
          ),
        ],
      ),

    );
  }
}
