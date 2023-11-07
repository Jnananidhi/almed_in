import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/products/product.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //now we create menu and header
                      const Navigation(),
                      Container(
                        //width: double.infinity,
                        width: kMaxWidth,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              lightColor, // Start color
                              kSecondaryColor, // End color (same color for a solid effect)
                            ],
                          ),
                        ),

                        child: Marquee(
                          text: "             India's First All Medicine Distributor          Faster Services          Latest easy e-com buying",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      UserProfilePage(),
                       BottomNav()
                      //now we will make our site responsive
                    ],
                  ),
                ),
              )]));
  }
}


class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String username = "";
  Future getusername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('username')!;
    });
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
  void initState() {
    super.initState();
    getusername();}

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
                      'John Doe', // Replace with the user's name
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'john.doe@example.com', // Replace with the user's email
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
                        subtitle: Text('123-456-7890'),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('Email'),
                        subtitle: Text('john.doe@example.com'),
                      ),
                      // Shipping Address
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Shipping Address'),
                        subtitle: Text('123 Main St, City, Country'),
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

