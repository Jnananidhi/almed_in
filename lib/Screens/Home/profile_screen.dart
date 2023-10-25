import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';



class UserProfile extends StatelessWidget {
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
                      isActive: true,
                      title: 'Contact Us',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
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
                  backgroundImage: AssetImage('products/users/profile_image.jpg'), // Replace with the path to the user's profile picture
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
                      Text("Phone",textAlign: TextAlign.start,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
                      Text("+91 8088888688",textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontFamily: 'DMSans Regular')),
                      Divider(
                        thickness: 1,
                        indent : 0,
                        endIndent : 10,
                      ),
                      Text("Email",textAlign: TextAlign.start,style: TextStyle(color: kPrimaryColor,fontFamily: 'DMSans Regular')),
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
