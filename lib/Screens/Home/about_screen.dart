import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/faq.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';

import 'Authentication/login_screen.dart';
import 'contact_screen.dart';


class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String selectedMenuItem = 'Category';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        //scrollable widget
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Image(image: AssetImage('assets/logo_rmbck.png'),height: 80),
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

                    title: 'Home',
                    press: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    isActive: true,
                    title: 'About Us',
                    press: () {
                      Navigator.pushNamed(context, "/aboutAlmed.in");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'FAQ',
                    press: () {
                      Navigator.pushNamed(context, "/faq");

                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'Search Medicines',
                    press: () {
                      Navigator.pushNamed(context, "/alphabeticSearch");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'Seller?',
                    press: () {
                      Navigator.pushNamed(context, "/login");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'Contact Us',
                    press: () {Navigator.pushNamed(context, "contactUs");},
                  ),
                ],
              ),
            )
          ],
        ),
      ),

        body: Stack(
          children:[ Column(
              children: <Widget>[
                const Navigation(),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //now we create menu and header
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: const Column(

                              children: <Widget>[
                                SizedBox(height: 20),
                                Text(
                                  'About Us',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  aboutus,textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 16, height: 2, fontFamily: 'DMSans Regular'),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Contact Us:',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  textAlign: TextAlign.right,
                                  'Email: contact@almed.in',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  textAlign: TextAlign.right,
                                  'Phone: 8088222201',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        const BottomNav()
                      ],
                        //now we create banner
                        //for this import packages

                        //now we will make our site responsive

                    ),
                  ),
                ),

              ],
          ),
            Positioned(
              top: MediaQuery.of(context).size.width < 600
                  ? 90// Adjust the value for mobile view
                  :50,
              left: MediaQuery.of(context).size.width < 600
                  ? 0 // Adjust the value for mobile view
                  : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
              right: MediaQuery.of(context).size.width < 600
                  ? 0 // Adjust the value for mobile view
                  : MediaQuery.of(context).size.width * 0.25,
              child: Search_bar(),
            ),

          ]),
    );

  }
}

