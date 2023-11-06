import 'package:almed_in/Screens/Home/products/product.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/about_screen.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/products/widgets/allproducts.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/widgets/banner.dart';
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
                child: Image(image: AssetImage('assets/logo.png'),height: 80),
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
              //if (Responsive.isDesktop(context))
              // const SizedBox(
              //   height: 30,
              // ),
              // if (Responsive.isDesktop(context))
              // Container(
              //   //width: double.infinity,
              //   width: kMaxWidth,
              //   height: 50,
              //   decoration: BoxDecoration(
              //     borderRadius:  BorderRadius.circular(15.0),
              //     gradient: LinearGradient(
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //       colors: [
              //         lightColor, // Start color
              //         kSecondaryColor, // End color (same color for a solid effect)
              //       ],
              //     ),
              //   ),
              //
              //   child: Marquee(
              //     text: "             India's First All Medicine Distributor          Faster Services          Latest easy e-com buying",
              //     style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              if (!Responsive.isDesktop(context))
                const SizedBox(
                  height: 45,
                ),
              // if (!Responsive.isDesktop(context))
              // Container(
              //   //width: double.infinity,
              //   width: kMaxWidth,
              //   height: 40,
              //   decoration: BoxDecoration(
              //     borderRadius:  BorderRadius.circular(15.0),
              //     gradient: LinearGradient(
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //       colors: [
              //         lightColor, // Start color
              //         kSecondaryColor, // End color (same color for a solid effect)
              //       ],
              //     ),
              //   ),
              //
              //   child: Marquee(
              //     text: "             India's First All Medicine Distributor          Faster Services          Latest easy e-com buying",
              //     style: TextStyle(
              //       fontSize: 15,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              // if (Responsive.isDesktop(context))
              // Divider(
              //   thickness: 1,
              //   height: 0.01, // Set the height of the divider line
              //   color: kPrimaryColor, // Set the color of the divider line
              // ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
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
