import 'package:almed_in/Screens/Home/products/product.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/about_screen.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/products/widgets/allproducts.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/widgets/banner.dart';
import 'package:almed_in/constants.dart';
import 'products/product_section.dart';
import 'widgets/bottomnav.dart';
import 'widgets/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMenuItem = 'Select Type';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      //scrollable widget
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Image(image: AssetImage('logo.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    title: 'Why Almed',
                    press: () {},
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

                  DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    value: selectedMenuItem,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedMenuItem = newValue;
                          // Add logic to navigate to the related page based on selectedMenuItem
                          if (selectedMenuItem == 'Therapeutic') {
                            // Navigate to the Therapeutic page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductScreen()),
                            );
                          } else if (selectedMenuItem == 'Company') {
                            // Navigate to the Company page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductScreen()),
                            );
                          } else if (selectedMenuItem == 'Form') {
                            // Navigate to the Form page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductScreen()),
                            );
                          } else if (selectedMenuItem == 'Strength') {
                            // Navigate to the Strength page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductScreen()),
                            );
                          }
                        });
                      }
                    },
                    items: ['Select Type','Therapeutic', 'Company', 'Form', 'Strength']
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

                  MenuItems(
                    title: 'Contact Us',
                    press: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          const Column(
            children: <Widget>[
              Navigation(),
              // Divider(
              //   height: 5, // Set the height of the divider line
              //   color: Colors.grey, // Set the color of the divider line
              // ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      HeroBanner(),
                      ProductSection(),
                      BottomNav(),
                      // Add other elements here
                    ],
                  ),
                ),
              ),

            ],
          ),
          // Add the Search_bar here to make it overlap other elements
          Positioned(
            top: 105,
            left: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.25, // Adjust the value for desktop view
            right: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.25,
            child: Search_bar(),
          ),

        ],
      ),
    );
  }
}
