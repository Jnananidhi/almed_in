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
                                  'Email: contact@example.com',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  textAlign: TextAlign.right,
                                  'Phone: +1 (123) 456-7890',
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

