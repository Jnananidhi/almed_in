import 'dart:convert';

import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Authentication/login_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';



class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

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
                  child: Image(image: AssetImage('assets/logo.png'),height: 80),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DrawerHeader(
                      child: Center(
                        child: Image(image: AssetImage('assets/logo.png')),
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
                const Navigation(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //now we create menu and header

                        UserProfilePage(),
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
            ),],
        ));
  }
}


class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String username = "";
  List<Map<String, dynamic>> details = [];
  Future getusername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('username')!;
    });
  }

  Future getprofiledata() async {
    var url = "${api}profile.php";
    var response = await http.post(Uri.parse(url),body: {
      "username": username,
    }
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        details =List<Map<String, dynamic>>.from(jsonData);
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    print("profile_details");
    print(details);
    return details;
  }

  @override
  void initState() {
    Future.wait([ getusername()]).then((_) {
      // After both therapeautic and form data are fetched, proceed to group items
      getprofiledata();
    });
    super.initState();
  }
  bool isHovered = false;

  Future logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('username');
    Fluttertoast.showToast(
      msg: "Logout!!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER_LEFT,
      fontSize: 16,
      backgroundColor: Color.fromARGB(255, 211, 199, 242),
      textColor: Colors.black,
    );
    Navigator.pushNamed(context, "/login");
  }

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
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Container(
           padding: EdgeInsets.all(20.0),
           child: Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20.0), // Set the border radius here
             ),
            elevation: 20,
            color: lightColor,
            child: Padding(
            padding: EdgeInsets.all(30.0),
              child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/products/users/profile_image.jpg'), // Replace with the path to the user's profile picture
                    ),
                    SizedBox(height: 10),
                    Text(
                      details.isNotEmpty ? details[0]['shop_name'] ?? 'No name available' : 'No data available',// Replace with the user's name
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      details.isNotEmpty ? details[0]['email'] ?? 'No name available' : 'No data available', // Replace with the user's email
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed:  () {

                      },
                      child: Text(
                        'My Orders',textAlign: TextAlign.right,
                        style: TextStyle(
                          color: isHovered ?kPrimaryColor:Colors.black,fontSize: 18
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      indent : 0,
                      endIndent : 10,
                    ),
                    TextButton(
                      onPressed: () async {
                        logout(context);

                      },
                      child: Text(
                        'Logout',textAlign: TextAlign.right,
                        style: TextStyle(
                          color: isHovered ?kPrimaryColor:Colors.black,fontSize: 18
                        ),
                      ),
                    ),
                        ],
                ),
            ),
        ),
         ),

         Container(
            padding: EdgeInsets.all(20.0),
            width: kMaxWidth/1.5,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Text("Personal Information",textAlign: TextAlign.left,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
               // SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Set the border radius here
                  ),

                  elevation: 20,
                  color: lightColor,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text("Personal Information",textAlign: TextAlign.center,style: TextStyle(color: kPrimaryColor)),
                      ListTile(
                        leading: Icon(Icons.person_2_rounded),
                        title: Text('Personal Information'),
                      ),
                      Divider(
                        thickness: 1,
                        height: 0.01, // Set the height of the divider line
                        color: kPrimaryColor, // Set the color of the divider line
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Contact'),
                        subtitle: Text(details.isNotEmpty ? details[0]['phone'] ?? 'No name available' : 'No data available'),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('Email'),
                        subtitle: Text(details.isNotEmpty ? details[0]['email'] ?? 'No name available' : 'No data available'),
                      ),
                      // Shipping Address
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Shipping Address'),
                        subtitle: Text(details.isNotEmpty ? details[0]['adress'] ?? 'No name available' : 'No data available'),
                      ),

                    ],
                  ),
                  ),
                ),

                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Set the border radius here
                  ),
                  elevation: 20,
                  color: lightColor,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Text("Payments Information",textAlign: TextAlign.left,style: TextStyle(color: kPrimaryColor)),
                        ListTile(
                          leading: Icon(Icons.payments_rounded),
                          title: Text('Payments Information')
                        ),
                        Divider(
                          thickness: 1,
                          height: 0.01, // Set the height of the divider line
                          color: kPrimaryColor, // Set the color of the divider line
                        ),
                        ListTile(
                          leading: Icon(Icons.payment),
                          title: Text('Saved UPI'),
                          subtitle: Text('john.doe@upi'),
                        ),
                        ListTile(
                          leading: Icon(Icons.payment),
                          title: Text('Saved Cards'),
                          subtitle: Text('**** **** **** 1234'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ));
  }
}

class OrderHistoryItem extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String total;

  OrderHistoryItem({
    required this.orderNumber,
    required this.date,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(orderNumber),
      subtitle: Text('Date: $date, Total: $total'),
      trailing: Icon(Icons.arrow_forward),
      // Implement functionality to view details of each order
      onTap: () {
        // Add logic to view order details
      },
    );
  }
}

