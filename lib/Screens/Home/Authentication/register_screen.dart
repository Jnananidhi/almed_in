import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/faq.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/registration_form.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';

import '../contact_screen.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


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
                      press: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsApp()));},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: const Column(
          children: <Widget>[
            Navigation(),
            Divider(
              thickness: 1,
              height: 0.01, // Set the height of the divider line
              color: kPrimaryColor, // Set the color of the divider line
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RegistrationForm(),
                    BottomNav(),
                    // Add more widgets here as needed
                  ],
                ),
              ),
            ),

          ],
        )
    );

  }
}
