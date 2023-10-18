import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/widgets/custom_listview.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/menu.dart';

class ProductScreen extends StatefulWidget {


  @override
  ProductScreenState createState() => ProductScreenState();
}
class ProductScreenState extends State<ProductScreen> {
  List<Productt> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }


  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('${api}getProducts.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Productt> productsData = jsonData.map((item) => Productt.fromJson(item)).toList();
      print(productsData);
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
            child:StaggeredGridView.countBuilder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              crossAxisCount: 4,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductItem(product);
              },
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}

