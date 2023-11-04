import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/products/product.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';

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
                      UserProfilePage(),
                      const BottomNav()
                      //now we will make our site responsive
                    ],
                  ),
                ),
              )]));
  }
}


class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: 0,top:30,right: 30,bottom:10),
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
                Card(
                  // Set card margin
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Set the curved border radius
                  ),
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child:  Column(
                        children: <Widget>[
                          TextButton(
                            onPressed:  () {

                            },
                            child: Text(
                              'My Orders',textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: "DMSans Regular",
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            indent : 0,
                            endIndent : 10,
                          ),
                          TextButton(
                            onPressed:  () {

                            },
                            child: Text(
                              'Logout',textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: "DMSans Regular",
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),                    ],
                    ),
                  ),
                ),
                    ],
            ),
        ),
        Card(
           // Set card margin
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Set the curved border radius
          ),
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: kMaxWidth/1.5,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Personal Information",textAlign: TextAlign.left,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
                SizedBox(height: 10,),
                Card(
                  elevation: 20,
                  color: lightColor,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Phone :  +91 8088888688",textAlign: TextAlign.start,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
                      Divider(
                        thickness: 1,
                        indent : 0,
                        endIndent : 10,
                      ),
                      Text("Email :   yourmail@gmail.com",textAlign: TextAlign.start,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
                      Divider(
                        thickness: 1,
                        indent : 0,
                        endIndent : 10,
                      ),
                      Text("Shipping Address :   your full address",textAlign: TextAlign.start,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),

                    ],
                  ),
                  ),
                ),
                Text("Payments Information",textAlign: TextAlign.left,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
                SizedBox(height: 10,),
                Card(
                  elevation: 20,
                  color: lightColor,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Saved Cards",textAlign: TextAlign.start,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
                        Text("+91 8088888688",textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontFamily: 'DMSans Regular')),
                        Divider(
                          thickness: 1,
                          indent : 0,
                          endIndent : 10,
                        ),
                        Text("Saved UPI",textAlign: TextAlign.start,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
                        Text("yourmail@gmail.com",textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontFamily: 'DMSans Regular')),
                        Divider(
                          thickness: 1,
                          indent : 0,
                          endIndent : 10,
                        ),
                        Text("Shipping Address",textAlign: TextAlign.start,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
                        Text("your full address",textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontFamily: 'DMSans Regular')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
