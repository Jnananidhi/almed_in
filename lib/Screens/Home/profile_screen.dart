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
import '../../responsive.dart';
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
                      title: 'Home',
                      press: () {Navigator.pushNamed(context, "/home");},
                    ),
                    const SizedBox(
                      height: 10,
                    ),


                    // DropdownButton<String>(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   value: selectedMenuItem,
                    //   onChanged: (String? newValue) {
                    //     if (newValue != null) {
                    //       setState(() {
                    //         selectedMenuItem = newValue;
                    //         // Add logic to navigate to the related page based on selectedMenuItem
                    //         if (selectedMenuItem == 'Therapeutic') {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                    //
                    //           );
                    //
                    //         } else if (selectedMenuItem == 'Strength') {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                    //           );
                    //         }
                    //         else if (selectedMenuItem == 'Company') {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                    //           );
                    //         }else if (selectedMenuItem == 'Form') {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                    //           );
                    //         }
                    //       });
                    //     }
                    //   },
                    //   items: ['Category','Therapeutic', 'Company', 'Form', 'Strength']
                    //       .map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(
                    //         value,
                    //         style:  TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize:  18 ,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     );
                    //   }).toList(),
                    //   // Set the underline property to Container() to hide the underline.
                    //   underline: Container(),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    MenuItems(
                      title: 'Orders',
                      press: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuItems(
                      title: 'Logout',
                      press: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
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
                        if (!Responsive.isDesktop(context))
                          SizedBox(
                            height: 20,
                          ),
                        //now we create menu and header
                        if (Responsive.isDesktop(context))
                        UserProfilePage(),
                        if (!Responsive.isDesktop(context))
                          user_profle_mobile(),
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
  var w1 = kMaxWidth/1.5;
  List<Map<String, dynamic>> details = [];


  String username = '';


  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
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
    Future.wait([ _loadUsername()]).then((_) {
      // After both therapeautic and form data are fetched, proceed to group items
      getprofiledata();
    });
    super.initState();
    print("username : $username");
  }
  bool isHovered = false;
  bool isHovered1=false;

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
    return  Row(
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

            child: Padding(
            padding: EdgeInsets.all(30.0),
              child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/products/users/profile_image.jpg'), // Replace with the path to the user's profile picture
                    ),
                    Divider(
                      thickness: 1,
                      indent : 0,
                      endIndent : 10,
                    ),


                    Divider(
                      thickness: 1,
                      indent : 0,
                      endIndent : 10,
                    ),
                    Text(
                      details.isNotEmpty ? details[0]['shop_name'] ?? 'No name available' : 'No data available',// Replace with the user's name
                      style: TextStyle(fontSize: 24),
                    ),
                    Divider(
                      thickness: 1,
                      indent : 0,
                      endIndent : 10,
                    ),


                    Divider(
                      thickness: 1,
                      indent : 0,
                      endIndent : 10,
                    ),
                    Text(
                      details.isNotEmpty ? details[0]['email'] ?? 'No name available' : 'No data available', // Replace with the user's email
                      style: TextStyle(fontSize: 18),
                    ),

                    Divider(
                      thickness: 1,
                      indent : 0,
                      endIndent : 10,
                    ),
                    Divider(
                      thickness: 1,
                      indent : 0,
                      endIndent : 10,
                    ),
                    TextButton(
                      onPressed: () {
                        // Add your onPressed functionality here
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start, // Align icon to the start
                        children: [
                          Icon(
                            Icons.shopping_bag_rounded, // Replace with your desired icon
                            color: kSecondaryColor, // Set the color to the secondary color
                          ),
                          SizedBox(width: 8),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                isHovered = true; // Set hover state to true when the mouse enters
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                isHovered = false; // Set hover state to false when the mouse exits
                              });
                            },
                            child: GestureDetector(
                              child: Text(
                                'My Orders',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: isHovered ? kPrimaryColor : Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: (){
                              //  Navigator.pushNamed(context, "/myOrders");
                              },
                            ),
                          ),// Add some space between the icon and text

                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      indent : 0,
                      endIndent : 10,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start, // Align icon to the start
                        children: [
                          Icon(
                            Icons.logout_rounded, // Replace with your desired icon
                            color: kSecondaryColor, // Set the color to the secondary color
                          ),
                          SizedBox(width: 8),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                isHovered1 = true; // Set hover state to true when the mouse enters
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                isHovered1 = false; // Set hover state to false when the mouse exits
                              });
                            },
                            child: Text(
                              'Logout',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: isHovered1 ? kPrimaryColor : Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),// Add some space between the icon and text

                        ],
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
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text("Personal Information",textAlign: TextAlign.center,style: TextStyle(color: kPrimaryColor)),
                      ListTile(
                        leading: Icon(Icons.person,color: kSecondaryColor),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            SizedBox(
                              // Fixed width for the title
                              child: Text(
                                'Account Information ',
                                style: TextStyle(fontFamily: 'DMSans Bold'),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 0.01, // Set the height of the divider line
                        color: kPrimaryColor, // Set the color of the divider line
                      ),

                      ListTile(
                        leading: Icon(Icons.health_and_safety,color: kSecondaryColor),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            SizedBox(
                              width: 120, // Fixed width for the title
                              child: Text(
                                'Owner: ',
                                style: TextStyle(fontFamily: 'DMSans Bold'),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                details.isNotEmpty
                                    ? details[0]['owner'] ?? 'No name available'
                                    : 'No data available',
                                style: TextStyle(fontFamily: 'DMSans Regular'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.confirmation_num_rounded,color: kSecondaryColor),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            SizedBox(
                              width: 120, // Fixed width for the title
                              child: Text(
                                'GST No: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                details.isNotEmpty
                                    ? details[0]['gst_no'] ?? 'No name available'
                                    : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ListTile(
                        leading: Icon(Icons.dataset_linked,color: kSecondaryColor),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            SizedBox(
                              width: 120, // Fixed width for the title
                              child: Text(
                                'KMC/DL No 1: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                details.isNotEmpty
                                    ? details[0]['dl1'] ?? 'No name available'
                                    : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.dataset_linked,color: kSecondaryColor),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            SizedBox(
                              width: 120, // Fixed width for the title
                              child: Text(
                                'KMC/DL No 2: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                details.isNotEmpty
                                    ? details[0]['dl2'] ?? 'No name available'
                                    : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),


                      ListTile(
                        leading: Icon(Icons.location_city,color: kSecondaryColor),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            SizedBox(
                              width: 120, // Fixed width for the title
                              child: Text(
                                'Town/City: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                details.isNotEmpty
                                    ? details[0]['city'] ?? 'No name available'
                                    : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.post_add,color: kSecondaryColor),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            SizedBox(
                              width: 120, // Fixed width for the title
                              child: Text(
                                'Postcode/Zip: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                details.isNotEmpty
                                    ? details[0]['postcode'] ?? 'No name available'
                                    : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.contact_phone,color: kSecondaryColor),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            SizedBox(
                              width: 120, // Fixed width for the title
                              child: Text(
                                'Phone: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                details.isNotEmpty
                                    ? details[0]['phone'] ?? 'No name available'
                                    : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.email,color: kSecondaryColor,),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            SizedBox(
                              width: 120, // Fixed width for the title
                              child: Text(
                                'Email: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                details.isNotEmpty
                                    ? details[0]['email'] ?? 'No name available'
                                    : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ),
                ),

                SizedBox(height: 10,),

                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: kSecondaryColor, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                    // Set the border radius here
                  ),

                  elevation: 20,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        ListTile(
                          leading:  Icon(Icons.pin_drop_rounded,color: kSecondaryColor),

                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      details.isNotEmpty
                                          ? details[0]['adress'] ?? 'No name available'
                                          : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular',color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
// Other ListTile elements...

// Other ListTile elements...

                      ],
                    ),
                  ),
                ),
              ],
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

class user_profle_mobile extends StatefulWidget{
  @override
  State<user_profle_mobile> createState() =>user_profle_mobileState();
}
class user_profle_mobileState extends State<user_profle_mobile> {
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
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/products/users/profile_image.jpg'), // Replace with the path to the user's profile picture
        ),
       SizedBox(
         height: 10,
       ),
        Text(
          details.isNotEmpty ? details[0]['shop_name'] ?? 'No name available' : 'No data available',// Replace with the user's name
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(
          height: 10,
        ),

        Text(
          details.isNotEmpty ? details[0]['email'] ?? 'No name available' : 'No data available', // Replace with the user's email
          style: TextStyle(fontSize: 18),
        ),

        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.health_and_safety,color: kSecondaryColor),
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              SizedBox(
                width: 120, // Fixed width for the title
                child: Text(
                  'Owner: ',
                  style: TextStyle(fontFamily: 'DMSans Bold'),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: Text(
                  details.isNotEmpty
                      ? details[0]['owner'] ?? 'No name available'
                      : 'No data available',
                  style: TextStyle(fontFamily: 'DMSans Regular'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.confirmation_num_rounded,color: kSecondaryColor),
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              SizedBox(
                width: 120, // Fixed width for the title
                child: Text(
                  'GST No: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: Text(
                  details.isNotEmpty
                      ? details[0]['gst_no'] ?? 'No name available'
                      : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        ListTile(
          leading: Icon(Icons.dataset_linked,color: kSecondaryColor),
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              SizedBox(
                width: 120, // Fixed width for the title
                child: Text(
                  'KMC/DL No 1: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: Text(
                  details.isNotEmpty
                      ? details[0]['dl1'] ?? 'No name available'
                      : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.dataset_linked,color: kSecondaryColor),
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              SizedBox(
                width: 120, // Fixed width for the title
                child: Text(
                  'KMC/DL No 2: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: Text(
                  details.isNotEmpty
                      ? details[0]['dl2'] ?? 'No name available'
                      : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),


        ListTile(
          leading: Icon(Icons.location_city,color: kSecondaryColor),
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              SizedBox(
                width: 120, // Fixed width for the title
                child: Text(
                  'Town/City: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: Text(
                  details.isNotEmpty
                      ? details[0]['city'] ?? 'No name available'
                      : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.post_add,color: kSecondaryColor),
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              SizedBox(
                width: 120, // Fixed width for the title
                child: Text(
                  'Postcode/Zip: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: Text(
                  details.isNotEmpty
                      ? details[0]['postcode'] ?? 'No name available'
                      : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.contact_phone,color: kSecondaryColor),
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              SizedBox(
                width: 120, // Fixed width for the title
                child: Text(
                  'Phone: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: Text(
                  details.isNotEmpty
                      ? details[0]['phone'] ?? 'No name available'
                      : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.email,color: kSecondaryColor,),
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              SizedBox(
                width: 120, // Fixed width for the title
                child: Text(
                  'Email: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: Text(
                  details.isNotEmpty
                      ? details[0]['email'] ?? 'No name available'
                      : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: kSecondaryColor, width: 2),
            borderRadius: BorderRadius.circular(20.0),
            // Set the border radius here
          ),

          elevation: 20,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                ListTile(
                  leading:  Icon(Icons.pin_drop_rounded,color: kSecondaryColor),

                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              details.isNotEmpty
                                  ? details[0]['adress'] ?? 'No name available'
                                  : 'No data available',style: TextStyle(fontFamily: 'DMSans Regular',color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
// Other ListTile elements...

// Other ListTile elements...

              ],
            ),
          ),
        ),




            ],
          );

}}