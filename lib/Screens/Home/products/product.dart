import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/widgets/custom_listview.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Authentication/login_screen.dart';
import '../about_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../widgets/menu.dart';

class ProductScreen extends StatefulWidget {
  final String? selectedMenuItem;

  ProductScreen({this.selectedMenuItem});
  @override
  ProductScreenState createState() => ProductScreenState();
}
class ProductScreenState extends State<ProductScreen> {
  String selectedMenuItem = 'Category';
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
      body: Column(
        children: [
          Navigation(),
          Divider(
            thickness: 1,
            height: 0.01, // Set the height of the divider line
            color: kPrimaryColor, // Set the color of the divider line
          ),
          Padding(
            padding: const EdgeInsets.all(10.20), // Adjust the padding as needed
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
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return OrientationBuilder(
                  builder: (context, orientation) {
                    final crossAxisCount = orientation == Orientation.portrait ? 2 : 4;
                    return StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductItem(product);
                      },
                      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}

