
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/faq.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';

import 'Authentication/login_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
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
                      title: 'About Us',
                      press: () {
                        Navigator.pushNamed(context, "/aboutAlmed.in");
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuItems(
                      isActive: true,                      title: 'FAQ',
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
                Navigation(),
                const Divider(
                  thickness: 1,
                  height: 0.01, // Set the height of the divider line
                  color: kPrimaryColor, // Set the color of the divider line
                ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //now we create menu and header


                    Faq(),
                    //now we create banner
                    //for this import packages
                    BottomNav()
                    //now we will make our site responsive
                  ],
                ),
              ),
            )]),
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

          ]));

  }
}
