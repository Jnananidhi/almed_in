
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/faq.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/utils/utils.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {


  @override
  Widget build(BuildContext context) {
    final currentRoute = getCurrentRouteName(context);
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
    press: () {},
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
        body:const Column(
            children: <Widget>[

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //now we create menu and header
                  Navigation(),

                  Faq(),
                  //now we create banner
                  //for this import packages
                  BottomNav()
                  //now we will make our site responsive
                ],
              ),
            ),
          )]));

  }
}
