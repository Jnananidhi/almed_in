import 'package:almed_in/Screens/Home/Authentication/login_screen.dart';
import 'package:almed_in/Screens/Home/Authentication/login_status.dart';
import 'package:almed_in/Screens/Home/about_screen.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/cart_screen.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:almed_in/Screens/Home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;







class Navigation extends StatefulWidget    {
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
   final Usermanagement = UserManagement();

  void searchContacts(String searchTerm) {
    // Clear the previous search suggestions
    searchSuggestions.clear();
    // If the search term is empty, clear suggestions
    if (searchTerm.isEmpty) {
      setState(() {});
      return;
    }
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
                      Container(
                        color: kWhiteColor,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                              );
                            },
                              child: Image.asset('logo.png',
                                height: 80,
                              ),
                          ),
                      ),

                      const Spacer(),
                      if (Responsive.isDesktop(context)) const WebMenu(),
                      const Spacer(),

                    // shoppic_cart icn badge
                      Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return CartScreen();
                              }));
                            },
                            child: badges.Badge(
                              badgeContent: Text(cart.cartItemCount.toString()),
                              child: Icon(Icons.shopping_cart),
                            ),
                          );
                        },
                      ),




                      IconButton(
                        onPressed: () {
                          if({Usermanagement.isLoggedIn} == false)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  LoginPage()),
                            );
                          }
                          else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  LoginPage()),
                            );
                          }
                        },
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
    return Row(
      children: [
        MenuItems(

          title: 'Home',
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        MenuItems(
          title: 'About US',
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            );
          },
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
        MenuItems(
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
