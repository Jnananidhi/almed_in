import 'dart:convert';

import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/address_overlay.dart';
import 'package:almed_in/Screens/Home/widgets/Checkoutscreen.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Authentication/login_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'faq_screen.dart';
class AddressScreen extends StatefulWidget {

  final String? userInput,Address,RName,Pnumber;
  final LatLng? Location;

  AddressScreen({this.userInput,this.Address,this.RName,this.Pnumber, this.Location});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}


class _AddressScreenState extends State<AddressScreen> {
  bool displayContainer = false;
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
  OverlayEntry? overlayEntry;
  void showAddressOverlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
     overlayEntry = OverlayEntry(builder: (context) {
      return AddressOverlay(overlayContext:context,overlayEntry: overlayEntry);
    });
    overlayState?.insert(overlayEntry!);
  }
  int? selectedPaymentMethod;
  String selectedMenuItem = 'Category';
  bool textHovered = false;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: kWhiteColor,
        drawer: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Center(
                    child: Image(image: AssetImage('assets/logo.png'),height: 80),
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
            )),
        body: Stack(
          children:[
            Column(
            children: [
              Navigation(),
              SizedBox(height: 50,),
              // Left Section with Buttons
              Container(
                width: kMaxWidth,
                child: Expanded(

                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          onEnter: (event) {
                            setState(() {
                              // Change the color when hovered
                              textHovered = true;
                            });
                          },
                          onExit: (event) {
                            setState(() {
                              // Reset the color when the hover ends
                              textHovered = false;
                            });
                          },
                          child: GestureDetector(
                            onTap:(){showAddressOverlay(context);},
                            child:Text("+ Add delivery address",
                              style: TextStyle(
                                fontSize: 15,
                                color: !textHovered?kPrimaryColor:kSecondaryColor,
                                fontFamily: 'DMSans Bold',
                              ),)
                          ),
                        ),


                        SizedBox(height: 20),
                        Text(
                          "Recent addresses",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: 'DMSans Regular',
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: kMaxWidth/2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: selectedPaymentMethod == 1 ? Border.all(color: kSecondaryColor, width: 1.0) : null,
                          ),
                          //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                          child: ListTile(
                            title: Text(details.isNotEmpty ? details[0]['adress'] ?? 'No data available' : 'No data available',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'DMSans Regular',
                              ),),
                            leading: Radio(
                              value: 1, // Unique value for UPI
                              groupValue: selectedPaymentMethod,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedPaymentMethod = value;
                                });
                              },
                            )
                          ),),

                        SizedBox(height: 20),
                        if(widget.Address!=null)
                        Container(
                          width: kMaxWidth/2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: selectedPaymentMethod == 2 ? Border.all(color: kSecondaryColor, width: 1.0) : null,
                          ),
                          //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                          child: ListTile(
                              title: Text('${widget.RName ?? ""} ${widget.Pnumber ?? ""} ${ widget.Address ?? ""} ${widget.userInput ?? ""}',style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'DMSans Regular',
                              ),),
                              leading: Radio(
                                value: 2, // Unique value for UPI
                                groupValue: selectedPaymentMethod,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedPaymentMethod = value;
                                  });
                                },
                              )
                          ),),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              if (selectedPaymentMethod == 1) {
                                if(details[0]['adress']!="No Data available"){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                      RName:  details[0]['shop_name'],
                                      Pnumber:details[0]['phone'],
                                      Address:details[0]['adress'] ,
                                      // Use details[0]['address'] for payment method 1
                                    ),
                                  ),
                                );
                              }}else if (selectedPaymentMethod == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                      userInput: widget.userInput,
                                      Address: widget.Address, // Use widget.Address for other payment methods
                                      RName: widget.RName,
                                      Pnumber: widget.Pnumber,
                                      Location: widget.Location,
                                    ),
                                  ),
                                );
                              }
                              else {
                                Fluttertoast.showToast(
                                  msg: 'Please select an address', // Your toast message
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }

                            },
                            style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                            child: Text(
                              "Continue Payment",
                              style: TextStyle(
                                fontSize: 15,
                                color: lightColor,
                                fontFamily: 'DMSans Bold',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Right Section with Search and Map
            ],
          ),
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
            ),

          ],),
      );
    }
  }
