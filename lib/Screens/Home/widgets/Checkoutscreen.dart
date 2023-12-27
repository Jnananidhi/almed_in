import 'dart:convert';

import 'package:almed_in/Screens/Home/widgets/bill_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../Authentication/login_screen.dart';
import '../about_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../products/products_screen.dart';
import 'bottomnav.dart';
import 'menu.dart';
import 'order_success.dart';


class CheckoutScreen extends StatefulWidget {
  final String? userInput,Address,RName,Pnumber;
  final LatLng? Location;
  CheckoutScreen({this.userInput,this.Address,this.RName,this.Pnumber, this.Location});
  @override
  CheckoutScreenState createState() => CheckoutScreenState();
  }

  class CheckoutScreenState extends State<CheckoutScreen> {
    String? selectedPaymentMethod;
    String selectedMenuItem = 'Category';
    String username = "";


    Future getusername() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        username = preferences.getString('username')!;
      });
    }


    @override
    void initState() {
      getusername();
      print("LOCATION IN CHECKOUT");
      print(widget.Location);
      super.initState();
    }

    void placeOrder() async {
      String url = '${api}add_to_orders.php'; // Replace with your actual backend API endpoint
      try {
        var response = await http.post(
          Uri.parse(url),
          body: {
            'username': username,
            'delivery_name': widget.RName,
            'payment_method': selectedPaymentMethod,
            'delivery_address': widget.userInput??widget.Address,
            'original_address':widget.Address,
            'phone':widget.Pnumber,
            'LatLng':widget.Location.toString()
          },
        );

        if (response.statusCode == 200) {
          // Parse the JSON response
          Map<String, dynamic> jsonResponse = json.decode(response.body);

          if (jsonResponse['status'] == 'success') {
            // Product successfully added to cart
            print(jsonResponse);
           // print('Product added to cart!');
            Fluttertoast.showToast(
                msg: "Item added to cart",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP_RIGHT,
                fontSize: 16,
                backgroundColor: Colors.black,
                textColor: Colors.white);
          }
          else if (jsonResponse['status'] == 'error')
          {
            Fluttertoast.showToast(
                msg: "Item is already in the cart",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP_RIGHT,
                fontSize: 16,
                backgroundColor: Colors.black,
                textColor: Colors.white);
          }
          else {
            // Failed to add the product to cart
            print('Failed to add product to cart: ${jsonResponse['message']}');

          }
        } else {
          // Handle other response status codes if needed
          print('Failed to add product to cart: ${response.statusCode}');
        }
      } catch (error) {
        print('Error adding to cart: $error');
      }
    }
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
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
        body: Column(
        children: [
        Navigation(),
          Divider(
            thickness: 1,
            height: 0.01, // Set the height of the divider line
            color: kPrimaryColor, // Set the color of the divider line
          ),
    Expanded(
child:SingleChildScrollView(
    child:Column(
        children: [
    Container(
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
      child: Column(
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
              Container(
                  decoration: BoxDecoration(
                  borderRadius:  BorderRadius.circular(15.0),
                  
                ),
                 //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                 child:
                  Card(
                    elevation:2,
                    shape: RoundedRectangleBorder(// Set the border color and width
                      borderRadius: BorderRadius.circular(15.0), // Set the border radius
                    ),
                   
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('DELIVERY ADDRESS',style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'DMSans Regular',
                          ),),
                        ),
                        ListTile(
                          title: Text(' ${widget.RName ?? ""}'" - "'${widget.Pnumber ?? ""}',style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'DMSans Regular',
                          ),),

                        ),
                        ListTile(
                          title: Text('${widget.Address ?? ""}'" "'${widget.userInput ?? ""}',style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'DMSans Regular',
                          ),),

                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),),
                  SizedBox(height: 16),

                  Padding(
                    padding:EdgeInsets.all(20),
                    child: Align(
                      alignment:Alignment.topLeft,
                      child: Text("Payment Method",style:TextStyle(
                        fontWeight:FontWeight.bold,
                        fontSize: _size.width >= 370 ? 18 : 14,
                        fontFamily: 'DMSans Bold',
                        color: Colors.black,
                      ),textAlign: TextAlign.left),
                    ),
                  ),
                  SizedBox(height: 16),// Add space between cards

      Stack(
          children: <Widget>[
      Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
            borderRadius: BorderRadius.circular(15.0), // Set the border radius
          ),
          color: selectedPaymentMethod == "Card" ? Color(0xFFEDEEF5) : Colors.white,

              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(15.0),

                    ),
                      //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                      child: ListTile(
                    title: Text('Credit Card'),
                    leading: Radio(
                      value: "Card", // Unique value for UPI
                      groupValue: selectedPaymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                    ),trailing: Image.asset('assets/card_icon.png',height:20),
                  ),),
                  if (selectedPaymentMethod == "Card")
                    Padding(
                      padding: const EdgeInsets.only(left:80,right:16.0,top:16.0,bottom:16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text('Card Holder Name'),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true, // This property is used to fill the background color
                                  fillColor: Colors.white,
                                  hintText: 'Card holder Name',
                                  hintStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                )
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Card Number'),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true, // This property is used to fill the background color
                                  fillColor: Colors.white,
                                  hintText: 'Enter Card number',
                                  hintStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                )
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Expiry Date',),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,// Set the height you desire
                                      child: TextFormField(
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                          filled: true, // This property is used to fill the background color
                                          fillColor: Colors.white,
                                          hintText: 'MM/YY',
                                          hintStyle: TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('CVV'),
                                    SizedBox(height: 10),
                                Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                   child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true, // This property is used to fill the background color
                                          fillColor: Colors.white,
                                          hintText: 'CVV',
                                          hintStyle: TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                          ),
                                        )
                                   ), ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),

                ],
              ),
            ),


      ]),
                  SizedBox(height: 16),
         Card(
           shape: RoundedRectangleBorder(
             side: BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
             borderRadius: BorderRadius.circular(15.0), // Set the border radius
           ),
           color: selectedPaymentMethod == "UPI" ? Color(0xFFEDEEF5) : Colors.white,
            child: Column(
              children: [
            Container(
                    decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(15.0),

                 ),
                  //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                  child:
                ListTile(
                  title: Text('UPI'),
                  leading: Radio(
                    value: "UPI", // Unique value for UPI
                    groupValue: selectedPaymentMethod,
                    onChanged: (String? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),trailing: Image.asset('assets/upi_icon.png',height:20),
                ),
              ),
                if (selectedPaymentMethod == "UPI")
                  Padding(
                      padding: const EdgeInsets.only(left:80,right:16.0,top:16.0,bottom:16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('UPI ID',),
                            SizedBox(height: 10),
                            Container(
                              height: 40,
                              alignment: Alignment.center,// Set the height you desire
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true, // This property is used to fill the background color
                                  fillColor: Colors.white,
                                  hintText: 'Enter your UPI ID',
                                  hintStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('',),
                            SizedBox(height: 10),
                            ElevatedButton(
                              child: Container(
                                width: MediaQuery.of(context).size.width < 600
                                    ? kMaxWidth / 15.5 // Adjust the value for mobile view
                                    : kMaxWidth / 10.5,
                                height: 40,
                                child: const Center(child: Text("PAY",style:TextStyle(color: Colors.white))),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: kWhiteColor,
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),]))
              ],
            ),
          ),
        SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
            borderRadius: BorderRadius.circular(15.0), // Set the border radius
          ),
            child: Column(
              children: [
            Container(
            decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(15.0),

        ),
                  //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                  child:
                ListTile(
                  title: Text('Net Banking'),
                  leading: Radio(
                    value: "Net Banking", // Unique value for Net Banking
                    groupValue: selectedPaymentMethod,
                    onChanged: (String? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),trailing: Image.asset('assets/Netbanking_icon.png',height:20),
                ),),
                if (selectedPaymentMethod == "Net Banking")
                  ListTile(
                    title: Text('Additional Content Here'),
                  ),
              ],
            ),
          ),

                SizedBox(height: 16),
                 Card(
                   shape: RoundedRectangleBorder(
                     side: BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
                     borderRadius: BorderRadius.circular(15.0), // Set the border radius
                   ),
                    child: Column(
                      children: [
                    Container(
                    decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(15.0),
                   // gradient: LinearGradient(
                   //   begin: Alignment.topLeft,
                   //   end: Alignment.bottomRight,
                   //   colors: [
                   //     lightColor, // Start color
                   //     kSecondaryColor, // End color (same color for a solid effect)
                   //   ],
                   // ),
                 ),
                  //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                  child:
                ListTile(
                  title: Text('Cash on Delivery'),
                  leading: Radio(
                    value: 'Cash on Delivery', // Unique value for Cash on Delivery
                    groupValue: selectedPaymentMethod,
                    onChanged: (String? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
            ),
              ],
            ),
          ),

                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: Container(
                          width: MediaQuery.of(context).size.width < 600
                              ? kMaxWidth / 15.5 // Adjust the value for mobile view
                              : kMaxWidth / 10.5,
                          height: 40,
                          child: const Center(child: Text("Place Order",style:TextStyle(color: Colors.white))),
                        ),
                        onPressed: () {
                          placeOrder();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: kWhiteColor,
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),// Add space between cards


              ]),
            ),
            SizedBox(width: 10),
            Expanded(
              flex:1,
              child: Column(
                children:[
                  Container(
                  alignment: Alignment.topRight,
                  child: BillSummary(),
                ),
            ]  ),
            ),


          ],
        ),
      ]),
    )]))])),
          BottomNav(), ])))]));
  }//updated
}

