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
    return Scaffold(
        backgroundColor: kWhiteColor,
        //scrollable widget
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Text(
                    "Spick-Android",
                    textScaleFactor: 1.6,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                      title: 'Products',
                      press: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuItems(
                      title: 'Category',
                      press: () {},
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
          Container(
            padding:
            EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 10),
            child: TextField(
              controller: searchcontroller,
              onChanged: searchContacts,
              decoration: InputDecoration(
                  labelText: "Search",
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Color.fromARGB(255, 211, 199, 242))),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  )),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  //now we create menu and header
                  Navigation(),
                  //now we create banner
                  //for this import packages
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
