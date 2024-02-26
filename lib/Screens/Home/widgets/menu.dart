import 'package:almed_in/Screens/Home/Authentication/login_screen.dart';
import 'package:almed_in/Screens/Home/Authentication/login_status.dart';
import 'package:almed_in/Screens/Home/Category.dart';
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/cart_screen_desktop.dart';
import 'package:almed_in/Screens/Home/cart_screen_mobile.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/alphabetic_search1.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'package:hover_menu/hover_menu_lastitem.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges ;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hover_menu/hover_menu.dart';
import '../about_screen.dart';
import '../company_list_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../products/products_screen.dart';
import '../products/widgets/hover_menu.dart';
import '../products/widgets/hover_menu1.dart';
import '../profile_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:universal_html/html.dart' as html;


import 'alphabetic_search.dart';


class Navigation extends StatefulWidget    {
  const Navigation({
    Key? key,
  }) : super(key: key);
  @override
  State<Navigation> createState() => _NavigationState();

}

class _NavigationState extends State<Navigation> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
  List contact = [];
  final searchcontroller = TextEditingController();
  List<String> searchSuggestions = [];
  List therapeautic = [];
  List strength = [];
  List form = [];
  List company = [];
  String cartCount="";
  Future getAllcategory() async {
    var url = "${api}therapeautic.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        therapeautic = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return therapeautic;
  }
  String username = '';
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }
  Future fetchCartCount() async {
    final url = Uri.parse('${api}count_cart_items.php'); // Replace with your PHP script URL
    final response = await http.post(
      url,
      body: {'username': username},
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

        // If 'status' is 'success', assume there is a 'data' field
        var count = jsonData['cartCount'];

        // Handle 'data' as needed
        setState(() {
          cartCount = count.toString();
        });
       // print("CART____$cartCount");
    }
    return cartCount;
  }
  Future getstrength() async {
    var url = "${api}STRENGTH.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        strength = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return strength;
  }
  Future getform() async {
    var url = "${api}FORM.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        form = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return form;
  }
  Future getcompany() async {
    var url = "${api}almed_company.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        company = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return company;
  }
  @override
  void initState() {
    getAllcategory();
    getstrength();
    getform();
    getcompany();
    Future.wait([_loadUsername() ]).then((_) {
      fetchCartCount();
    });
    super.initState();

  }

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
    bool isTherapeuticMenuVisible = false;
    final screenWidth = MediaQuery.of(context).size.width;
    EdgeInsets padding = EdgeInsets.symmetric(horizontal: 20.0);

    // Check if the screen width is smaller than a certain breakpoint (for mobile view)
    if (screenWidth < 600) {
      padding = EdgeInsets.symmetric(horizontal: 10.0); // Adjust padding for mobile view
    }
    List<Widget> menuItems = therapeautic.map((item) => ListTile(title: Text(item["therapeautic"]))).toList();


    return Container(
      color: kWhiteColor,
      width: double.infinity,
        height: MediaQuery.of(context).size.width < 600 ? 140: null,
      child: Stack(
          children: [
      Column(
      children: <Widget>[Column(
        children: [
          Column(
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
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Container(
                          color: kWhiteColor,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                              },

                                child:
                                Image.asset(
                                  // 'assets/logo_500w.png',  // Make sure the path is correct
                                  // fit: BoxFit.contain,
                                  'assets/almed.in_logo_small.png',

                                )
                            ),
                        ),
                      ),
                    if (!Responsive.isDesktop(context))
                      Container(
                        color: kWhiteColor,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            child:
                            Image.asset(
                              'assets/logo_500w.png',  // Make sure the path is correct
                              fit: BoxFit.contain,
                              height: 80,

                            )
                        ),
                      ),

                    const Spacer(),
                    //if (Responsive.isDesktop(context))  WebMenu(),

                    if (Responsive.isDesktop(context))
                      GestureDetector(
                            onTap: () async {
                              SharedPreferences preferences = await SharedPreferences
                                  .getInstance();
                              String? username = preferences.getString(
                                  'username');
                              if (username != null) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => UserProfile()));
                              } else {
                                Navigator.pushNamed(context, "/login");
                              }
                            },
                        child:  Row(
                          children: [
                            Icon(Icons.store),
                            if (Responsive.isDesktop(context))
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text("Seller?",style: TextStyle(fontFamily: 'DMSans Bold'),),
                            ),
                          ],
                        ),
                      ),

                  // shoppic_cart icn badge
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                              if(Responsive.isMobile(context)) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return CartScreenMobile();
                                    }));
                              }else{
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return CartScreen();
                                    }));}
                            },
                            child: badges.Badge(
                              position: badges.BadgePosition.topEnd(top: 0, end: 3),
                              badgeContent:
                              Text(
                                cartCount,
                                style: TextStyle(color: Colors.white),
                              ),

                              child: IconButton(
                                icon: Icon(Icons.shopping_cart),
                                onPressed: () {
                                  if(Responsive.isMobile(context)) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return CartScreenMobile();
                                        }));
                                  }else{
                                    Navigator.pushNamed(context, "/cart");
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 9,),
                          if (Responsive.isDesktop(context))
                          GestureDetector(onTap:(){
                            if(Responsive.isMobile(context)) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return CartScreenMobile();
                                  }));
                            }else{
                              Navigator.pushNamed(context, "/cart");
                            }
                          },
                              child: Text("Cart",style: TextStyle(fontFamily:'DMSans Bold' ),)),
                        ],
                      ),
                    ),

                  Padding(
                  padding: padding,
                    child:
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            SharedPreferences preferences = await SharedPreferences
                                .getInstance();
                            String? username = preferences.getString(
                                'username');
                            if (username != null) {
                              Navigator.pushNamed(context, "/userProfile");
                            } else {
                              Navigator.pushNamed(context, "/login");
                            }
                          },
                          icon: const Icon(
                            Icons.person_outline,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                        if (Responsive.isDesktop(context))
                            GestureDetector(onTap:()async{
                            SharedPreferences preferences = await SharedPreferences
                                .getInstance();
                            String? username = preferences.getString(
                            'username');
                            if (username != null) {
                              Navigator.pushNamed(context, "/userProfile");}
                                else{
                              Navigator.pushNamed(context, "/login");}
                                },
                          child:Text("Profile",style: TextStyle(fontFamily: 'DMSans Bold'),)),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
              if (Responsive.isDesktop(context))
              Container(
                color: kSecondaryColor,
                  padding: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(child: HoverText("Search Medicines"),
                        onTap:(){
                          Navigator.pushNamed(context, '/alphabeticSearch');
                        }),
                        hovermenu(
                          title: InkWell(
                            child: HoverText("Theurepeautic"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ThereapeauticScreen()),
                              );
                            },
                          ),
                          items: buildcompanyMenuItems().map((item) {
                            return Container(
                              color: Colors.white, // Set the desired background color
                              child: item,
                            );
                          }).toList(),
                          width: 500,
                        ),
                        hovermenu(
                          title: InkWell(
                            child: HoverText("Form"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const FormScreen()),
                              );
                            },
                          ),
                          items: buildFormMenuItems().map((item) {
                            return Container(
                              color: Colors.white, // Set the desired background color
                              child: item,
                            );
                          }).toList(),
                          width: 500,
                        ),
                        hovermenu(
                            title: InkWell(
                              child: HoverText("Strength"),
                                       onTap: () {
                                                  Navigator.push(
                                                      context,
                                          MaterialPageRoute(builder: (context) => const StrengthScreen()),
                                          );
                                             },
                                              ),
                                      items: buildStrengthMenuItems().map((item) {
                                        return Container(
                                          color: Colors.white, // Set the desired background color
                                            child: item,
                                              );
                                          }).toList(),
                                          width: 500,
                                            ),

                        HoverMenu1(
                          title: InkWell(
                            child: HoverText("Company"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CompanyScreen()),
                              );
                            },
                          ),
                          items: buildTherapeuticMenuItems().map((item) {
                            return Container(
                              color: Colors.white, // Set the desired background color
                              child: item,
                            );
                          }).toList(),
                          width: 500,
                        ),
                            ],
                  ),
              )])])
    ]
      ),

          ])
    );


        }
  List<Widget> buildTherapeuticMenuItems() {
    List<Widget> items = [];

    for (int i = 0; i < company.length; i += 3) {
      // Create a row with two items
      List<Widget> rowItems = [];

      for (int j = 0; j < 3; j++) {
        if (i + j < company.length) {
          rowItems.add(
            Expanded(
              child: Container(
                color: Colors.white, // Set the background color to white
                child: Hoverdata(
                  title:capitalize(company[i + j]["Company"]),
                  press: (){
                    print(company[i + j]["Company"]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ( context) => FetchedCategoryProduct(selectedProductName: company[i + j]["Company"],),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      }//menu
      // Add the row to the menu
      items.add(
        Row(
          children: rowItems,
        ),
      );
    }
    return items;
  }
//theaurepetic
  List<Widget> buildcompanyMenuItems() {
    List<Widget> items = [];

    for (int i = 0; i < therapeautic.length; i += 3) {
      // Create a row with two items
      List<Widget> rowItems = [];

      for (int j = 0; j < 3; j++) {
        if (i + j < therapeautic.length) {
          rowItems.add(
            Expanded(
              child: Container(
                color: Colors.white, // Set the background color to white
                child: Hoverdata(
                  title:capitalize(therapeautic[i + j]["therapeautic"]),
                  press: (){
                    print(therapeautic[i + j]["therapeautic"]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FetchedCategoryProduct(selectedProductName: therapeautic[i + j]["therapeautic"],),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      }//menu
      // Add the row to the menu
      items.add(
        Row(
          children: rowItems,
        ),
      );
    }
    return items;
  }


  //form
  List<Widget> buildFormMenuItems() {
    List<Widget> items = [];

    for (int i = 0; i < form.length; i += 3) {
      // Create a row with two items
      List<Widget> rowItems = [];

      for (int j = 0; j < 3; j++) {
        if (i + j < form.length) {
          rowItems.add(
            Expanded(
              child: Container(
                color: Colors.white, // Set the background color to white
                // child: ListTile(
                //   title: Text(form[i + j]["FORM"],style: TextStyle(fontFamily: 'DMSans Regular'),),
                // ),
                child: Hoverdata(
                  title: capitalize(form[i + j]["FORM"]),
                  press: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FetchedCategoryProduct(selectedProductName: form[i + j]["FORM"]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      }
      // Add the row to the menu
      items.add(
        Row(
          children: rowItems,
        ),
      );
    }
    return items;
  }
  //strength list
  List<Widget> buildStrengthMenuItems() {
    List<Widget> items = [];

    for (int i = 0; i < strength.length; i += 3) {
      // Create a row with two items
      List<Widget> rowItems = [];

      for (int j = 0; j < 3; j++) {
        if (i + j < strength.length) {
          rowItems.add(
            Expanded(
              child: Container(
                color: Colors.white, // Set the background color to white
                child: Hoverdata(
                  title: capitalize(strength[i + j]["STRENGTH"]),
                  press: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FetchedCategoryProduct(selectedProductName: strength[i + j]["STRENGTH"]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      }
      // Add the row to the menu
      items.add(
        Row(
          children: rowItems,
        ),
      );
    }
    return items;
  }
  //company
  List<Widget> buildCompanyMenuItems() {
    List<Widget> items = [];

    for (int i = 0; i < company.length; i += 3) {
      // Create a row with two items
      List<Widget> rowItems = [];

      for (int j = 0; j < 3; j++) {
        if (i + j < company.length) {
          rowItems.add(
            Expanded(
              child: Container(
                color: Colors.white, // Set the background color to white
                child: Hoverdata(
                  title:company[i + j]["Company"],
                  press: (){
                    print(company[i + j]["Company"]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FetchedCategoryProduct(selectedProductName: company[i + j]["Company"],),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      }//menu
      // Add the row to the menu
      items.add(
        Row(
          children: rowItems,
        ),
      );
    }
    return items;
  }

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
    return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MenuItems(
            title: 'Home',
            press: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          MenuItems(
            title: 'About US',
            press: () {
              Navigator.pushNamed(context, '/aboutAlmed.in');

            },
          ),

          MenuItems(
            title: 'FAQ',
            press: () {
              Navigator.pushNamed(context, '/faq');

            },
          ),
          MenuItems(
            title: 'Contact Us',
            press: () {
              Navigator.pushNamed(context, '/contactUs');

            },
          ),
        
        ],

      ),
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
              fontFamily: 'DMSans regular',
              fontWeight: widget.isActive == true
                  ? FontWeight.bold
                  : isHover
                      ? FontWeight.bold
                      : FontWeight.normal,
              fontSize: _size.width >= 370 ? 15 : 10,
            ),
          ),
        ),
      ), 
    );
  }
}
class HoverText extends StatefulWidget {
  final String text;

  HoverText(this.text);

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: isHovered ? kPrimaryColor : Colors.white,fontWeight:FontWeight.bold,fontSize: 18
          ),
        ),
      ),
    );
  }
}


class Hoverdata extends StatefulWidget {
  final String title;
  final Function() press;

  Hoverdata({required this.title, required this.press});

  @override
  HoverdataState createState() => HoverdataState();
}

class HoverdataState extends State<Hoverdata> {

  bool isHovered = false;


  @override

  Widget build(BuildContext context) {

    return MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child:  AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: 'DMSans Regular',
            fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
            color: isHovered ? kPrimaryColor : Colors.black,),

          child: InkWell(
            onTap: widget.press,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  // Add any widgets you want to display within the card, e.g., Text
                  Text(widget.title,textAlign: TextAlign.center,)
                ],
              ),
            ),
          ),
        ));
  }
}