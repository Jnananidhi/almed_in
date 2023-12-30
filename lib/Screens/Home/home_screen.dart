import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/widgets/banner.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/about_screen.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/products/widgets/allproducts.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import '../../responsive.dart';
import 'Authentication/login_screen.dart';
import 'contact_screen.dart';
import 'products/product_section.dart';
import 'widgets/bottomnav.dart';
import 'widgets/menu.dart';
import 'package:marquee/marquee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMenuItem = 'Category';
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    // Simulate a loading delay (e.g., loading data from an API)
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
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
        :  Scaffold(
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
        children: [
           Column(
            children: <Widget>[
              Navigation(),

               Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
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

          // Marquee(
          //   text: 'Your marquee text goes here',
          //   style: TextStyle(
          //     fontSize: 20,
          //     color: Colors.black,
          //   ),
          // ),

            ]),
          );


  }
}
