
import 'package:almed_in/Screens/Home/widgets/custom_listview.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/menu.dart';

class Productt {
   int id;
  final String name;
  final String content;
  final String therapeautic;
  final String strength;
  final String form;
  final String company;
  final String gst;
  String quantity;
  final String imageUrl;
  String mrp;
  final String discount;

  Productt({
    required this.id,
    required this.name,
    required this.quantity,
    required this.content,
    required this.therapeautic,
    required this.strength,
    required this.form,
    required this.company,
    required this.gst,
    required this.imageUrl,
    required this.mrp,
    required this.discount,
  });

  factory Productt.fromJson(Map<String, dynamic> json) {
    return Productt(
      id: json['id'],
      name: json['name'],
     quantity: json['quantity'],
      content: json['content'],
      therapeautic: json['therapeautic'],
      strength: json['strength'],
      form: json['form'],
      company: json['company'],
      gst: json['gst'],
      imageUrl: json['image_url'],
      mrp: json['mrp'],
      discount: json['discount'],
    );
  }
}

class ProductListScreen extends StatefulWidget {
  final String? selectedProductName;

  ProductListScreen({this.selectedProductName});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Productt> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
    print("manu");
  }


  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('${api}getProducts.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Productt> productsData = jsonData.map((item) => Productt.fromJson(item)).toList();
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
      print('Failed to load products');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column( // Use a Column to stack the Navigation widget and the ListView.builder
          children: [
            Navigation(), // Display the custom Navigation widget again, if needed
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductListItem(product);
                },
              ),
            ),
          ],
        ),
      );
  }
}
