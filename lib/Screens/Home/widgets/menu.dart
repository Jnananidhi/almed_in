import 'dart:convert';

import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'package:almed_in/utils/utils.dart';
import 'package:http/http.dart' as http;

class Navigation extends StatefulWidget  implements PreferredSizeWidget  {
  @override
  Size get preferredSize => Size.fromHeight(100.0);
  const Navigation({
    Key? key,
  }) : super(key: key);



  @override
  State<Navigation> createState() => _NavigationState();
}
class _NavigationState extends State<Navigation> {
  List contact = [];
  final searchcontroller = TextEditingController();
  List<String> searchSuggestions = [];

  void searchContacts(String searchTerm) {
    // Clear the previous search suggestions
    searchSuggestions.clear();

    // If the search term is empty, clear suggestions
    if (searchTerm.isEmpty) {
      setState(() {});
      return;
    }

    // Filter the contacts based on the search term
    for (var item in contact) {
      print("hello");
      String name = item['COMPANY_NAME'].toString();
      if (name.toLowerCase().startsWith(searchTerm.toLowerCase())) {
        searchSuggestions.add(name);
      }
    }

    setState(() {});
  }
  Future getAllcategory() async {
    var url = "http://localhost/almed_company.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        contact = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    print(contact);
    print('hello');
    return contact;
  }

  @override
  void initState() {
    getAllcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhiteColor,
      width: double.infinity,
      child: Column(
        children: [

          Container(
            constraints: const BoxConstraints(
              maxWidth: kMaxWidth,
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      if (!Responsive.isDesktop(context))
                        IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: Icon(Icons.menu)),
                      //title
                      Image.asset('logo.png',
                      height: 80,
                      ),
                      const Spacer(),
                      if (Responsive.isDesktop(context)) const WebMenu(),
                      const Spacer(),

                      IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(
                          Icons.search,
                          color: kDarkgreyColor,
                          size: 25,
                        ),
                      ),



                      IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: kDarkgreyColor,
                          size: 25,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_outline,
                          color: kDarkgreyColor,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),


        ]))]));}

  }




class WebMenu extends StatelessWidget {
  const WebMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = getCurrentRouteName(context);
    return Row(
      children: [
        MenuItems(

          isActive: currentRoute == '/Home',
          title: 'Home',
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        MenuItems(
          isActive: currentRoute == '/AboutUs',
          title: 'About US',
          press: () {

          },
        ),
        MenuItems(
          isActive: currentRoute == '/WhyAlmed',
          title: 'Why Almed',
          press: () {},
        ),
        MenuItems(
          isActive: currentRoute == '/Faq',
          title: 'FAQ',
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FaqScreen()),
            );
          },
        ),
        MenuItems(
          isActive: currentRoute == '/ContactUs',
          title: 'Contact Us',
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ContactUsApp()),
            );
          },
        ),
      ],
    );
  }
}



class MenuItems extends StatefulWidget {
  final String title;
  final VoidCallback press;
  final bool isActive;
  const MenuItems(
      {Key? key,
      required this.title,
      required this.press,
      this.isActive = false})
      : super(key: key);

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: widget.press,
        onHover: (val) {
          setState(() {
            isHover = val;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: widget.isActive == true
                          ? kPrimaryColor
                          : isHover
                              ? kPrimaryColor
                              : Colors.transparent,
                      width: 4))),
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: widget.isActive == true
                  ? FontWeight.bold
                  : isHover
                      ? FontWeight.bold
                      : FontWeight.normal,
              fontSize: _size.width >= 370 ? 18 : 14,
              color: widget.isActive == true
                  ? kPrimaryColor
                  : isHover
                      ? kPrimaryColor
                      : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
