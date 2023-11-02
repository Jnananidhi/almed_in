import 'package:almed_in/Screens/Home/Authentication/login_screen.dart';
import 'package:almed_in/Screens/Home/Authentication/login_status.dart';
import 'package:almed_in/Screens/Home/about_screen.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/cart_screen_desktop.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:almed_in/Screens/Home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../products/product.dart';







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
                      if (Responsive.isDesktop(context))
                        Container(
                          color: kWhiteColor,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                                );
                              },

                                child:
                                Image.asset(
                                  'logo_500w.png',  // Make sure the path is correct
                                  fit: BoxFit.contain,
                                  height: 120,
                                )
                            ),
                        ),
                      if (!Responsive.isDesktop(context))
                        Container(
                          color: kWhiteColor,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                                );
                              },

                              child:
                              Image.asset(
                                'logo_500w.png',  // Make sure the path is correct
                                fit: BoxFit.contain,
                                height: 80,

                              )
                          ),
                        ),

                      const Spacer(),
                      if (Responsive.isDesktop(context))  WebMenu(),
                      const Spacer(),
                      if (Responsive.isDesktop(context))
                        MenuItems(
                        title: 'Vendor?',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  LoginPage()),
                          );
                        },
                      ),

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

                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:
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
                          color: Colors.black,
                          size: 25,
                        ),
                      ),),
                    ],
                  ),
                ),


        ]))]));}

  }




class WebMenu extends StatefulWidget {
  @override
  _WebMenuState createState() => _WebMenuState();
}

class _WebMenuState extends State<WebMenu> {
  String selectedMenuItem = 'Categories';
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
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
        // Add DropdownButton for additional menu items
        DropdownButton<String>(
          padding: const EdgeInsets.symmetric(horizontal: 10,),
          value: selectedMenuItem,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedMenuItem = newValue;
                // Add logic to navigate to the related page based on selectedMenuItem

                  // Navigate to the Therapeutic page
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

            },
              );}
              },
          items: ['Categories','Therapeutic', 'Company', 'Form', 'Strength']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,

                style:  TextStyle(
              fontWeight: isHover ? FontWeight.bold : FontWeight.normal,
                  fontSize: _size.width >= 370 ? 18 : 14,
                fontFamily: 'DMSans Bold',
                color: isHover ? kPrimaryColor : Colors.black,
              ),
              ),
            );
          }).toList(),
          // Set the underline property to Container() to hide the underline.
          underline: Container(),
        ),
      ],

    );
  }


    void navigateToVendorLogin() {
      // Implement the navigation logic to the vendor login screen
      // For example:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Replace VendorLoginScreen with your actual screen
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
          margin: EdgeInsets.only(top:4),
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
