import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/widgets/banner.dart';
import 'package:almed_in/constants.dart';

import 'products/product_section.dart';
import 'widgets/bottomnav.dart';
import 'widgets/menu.dart';
import '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List filteredContacts = [];
  List dropcontact = [];
  final searchcontroller = TextEditingController();
  void searchContacts(String searchTerm) {
    setState(() {
      filteredContacts = dropcontact.where((contact) {
        return contact['FIRST_NAME']
            .toLowerCase()
            .contains(searchTerm.toLowerCase()) ||
            contact['DESIGNATION']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()) ||
            contact['ORGANIZATION']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()) ||
            contact['DEPARTMENT']
                .toLowerCase()
                .contains(searchTerm.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = getCurrentRouteName(context);
    return Scaffold(
        appBar: Navigation(),
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
        body:Column(children: <Widget>[

          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Search_bar(),
                  HeroBanner(),
                  ProductSection(),
                  BottomNav()
                  //now we will make our site responsive
                ],
              ),
            ),
          )]));
  }
}
