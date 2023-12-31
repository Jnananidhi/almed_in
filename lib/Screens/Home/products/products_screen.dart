import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/custom_listview.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../responsive.dart';
import '../Authentication/login_screen.dart';
import '../about_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../widgets/menu.dart';

class ProductScreen extends StatefulWidget {
  final String? selectedMenuItem,selectedProductName;

  ProductScreen({this.selectedMenuItem,this.selectedProductName});


  @override
  ProductScreenState createState() => ProductScreenState();
}//product screen
class ProductScreenState extends State<ProductScreen> {
  String selectedMenuItem = 'Category';
  String? get selectedProductName => widget.selectedProductName;
  List<Productt> products = [];
  bool isLoading = true;

  Future<void> loadUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String storedUsername = preferences.getString('username') ?? '';
    print('Stored Username: $storedUsername');
  }

  //get selectedProductName => selectedProductName;
  @override
  void initState() {
    super.initState();
    fetchProducts();
    loadUsername();
    print("nidhiiii$selectedProductName");
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }


  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('${api}getProducts.php'));
    if (response.statusCode == 200) {
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
    } else {
      // Handle the error when the HTTP request fails
      print('Failed to load products');
    }
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor, //<-- SEE HERE
          backgroundColor: lightColor,), // You can customize this loading indicator
      ),
    )
        :Scaffold(
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
        children: [
          Column(
            children: <Widget>[
              Navigation(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
              products.isEmpty
                  ? Center(child: Column(
                    children: [
                      Image.asset("no_data.png",height: 350,width: 350),
                      SizedBox(height: 10,),
                      Text('No products to show you right now...',style: TextStyle(fontFamily: 'DMSans Bold'),),
                      SizedBox(height: 10,),
                      CustomButton(label: "Go Back", onPressed: (){Navigator.pushNamed(context, "/home");})
                    ],
                  ))
                  : Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Container(
                            height: Responsive.isDesktop(context) ? 120 : 200,
                            child: Responsive.isDesktop(context)
                                ? ProductItem(product)
                                : ProductItem_mobile(product),
                          );
                        },
                      ),
                      BottomNav(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: MediaQuery.of(context).size.width < 600 ? 90 : 50,
            left: MediaQuery.of(context).size.width < 600 ? 0 : MediaQuery.of(context).size.width * 0.22,
            right: MediaQuery.of(context).size.width < 600 ? 0 : MediaQuery.of(context).size.width * 0.25,
            child: Search_bar(),
          ),
        ],
      ),
    );
  }
}