
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/products/product.dart';
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
    child: ListView(
    children: [
    const DrawerHeader(
    child: Center(
    child: Image(image: AssetImage('assets/logo.png')),
    ),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
