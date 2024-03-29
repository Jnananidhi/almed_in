import 'dart:convert';

import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/widgets/custom_listview.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar1.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:http/http.dart'as http;

import '../../../constants.dart';
import '../../../responsive.dart';
class ProductScreen extends StatefulWidget {
  //final List<String>? selectedProductNames;//selectedProductNames is from search bar onclick
  final String? selectedMenuItem,selectedProductName;//selectedProductName from alphabetic search onclick
  const ProductScreen({super.key,this.selectedMenuItem,this.selectedProductName});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}
class _ProductScreenState extends State<ProductScreen> {
  int currentPage = 0;
  int itemsPerPage = 10;
  String selectedMenuItem = 'Category';
  String? get selectedProductName => widget.selectedProductName;
  //List<String>? get selectedProductNames=>selectedProductNames;
  List<Productt> products = [];
  String totalProductCount = "";

  @override
  void initState() {
    super.initState();
   // print("selectedproductnames:$selectedProductNames");
    fetchProductCountAndProducts();
    print("nidhiiii$selectedProductName");
  }

  Future<void> fetchProductCountAndProducts() async {
    await fetchProductCount();
    await fetchAllProducts();
  }

  Future<void> fetchProductCount() async {
    final url = Uri.parse('${api}getProductsCount.php');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var count = jsonData['TotalCount'];

      setState(() {
        totalProductCount = count.toString();
      });
    }
  }

  Future<void> fetchAllProducts() async {
    int startIndex = currentPage * itemsPerPage;

    final response = await http.get(
      Uri.parse('${api}getProducts.php?start=${startIndex.toString()}&limit=${itemsPerPage.toString()}'),
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');

      final List<dynamic> jsonData = json.decode(response.body);
      List<Productt> productsData = jsonData.map((item) => Productt.fromJson(item)).toList();
      print("kp$productsData");
      if (widget.selectedProductName != null && widget.selectedProductName!.isNotEmpty) {
        // Filter the products list based on the selected product name
        productsData = productsData.where((product) =>
        product.name.toLowerCase() == widget.selectedProductName?.toLowerCase()||product.company.toLowerCase() == widget.selectedProductName?.toLowerCase()||
            product.therapeautic.toLowerCase() == widget.selectedProductName?.toLowerCase()||product.form.toLowerCase() == widget.selectedProductName?.toLowerCase()||product.strength.toLowerCase() == widget.selectedProductName?.toLowerCase()
        ).toList();
        print("productsData$productsData");
      }
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
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Perform your custom logic here if needed
          // For example, if you want to navigate to a specific page
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCustomPage()));

          // Navigate back without showing a dialog
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );

          // Return true to allow the default behavior (popping the route)
          return true;
        },
        child: Stack(
          children: [
           Column(
            children: [
              Navigation(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.22),
                child: NumberPaginator(
                  numberPages: (int.parse(totalProductCount) / itemsPerPage).ceil(),
                  onPageChange: (index) {
                    setState(() {
                      currentPage = index;
                      fetchAllProducts(); // Fetch products when changing page
                    });
                  },
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
      ),

    );
  }
}
