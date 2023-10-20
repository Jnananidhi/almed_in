import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/faq.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';


class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
                      isActive: false,
                      title: 'Home',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuItems(
                      title: 'About Us',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AboutScreen()),
                        );
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
                      isActive: true,
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
        body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //now we create menu and header
                      const Navigation(),
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
                                style: TextStyle(fontSize: 16, height: 2,),
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
    );

  }
  }

