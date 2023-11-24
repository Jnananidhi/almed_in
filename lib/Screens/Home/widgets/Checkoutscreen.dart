import 'package:almed_in/Screens/Home/widgets/bill_summary_widget.dart';
import 'package:flutter/material.dart';

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

  CheckoutScreen({this.userInput,this.Address,this.RName,this.Pnumber});
  @override
  CheckoutScreenState createState() => CheckoutScreenState();
  }

  class CheckoutScreenState extends State<CheckoutScreen> {
    int? selectedPaymentMethod;
    String selectedMenuItem = 'Category';
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
                   elevation: 10,
                    shape: RoundedRectangleBorder(// Set the border color and width
                      borderRadius: BorderRadius.circular(15.0), // Set the border radius
                    ),
                   
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Deliver To:'" "' ${widget.RName ?? ""}'" - "'${widget.Pnumber ?? ""}'),

                        ),
                        ListTile(
                          title: Text('Address :'" "'${widget.Address ?? ""}'" "'${widget.userInput ?? ""}'),

                        ),
                      ],
                    ),
                  ),),
                  SizedBox(height: 16),

                  Text("Payment Method",style:TextStyle(
                    fontWeight:FontWeight.bold,
                    fontSize: _size.width >= 370 ? 18 : 14,
                    fontFamily: 'DMSans Bold',
                    color: Colors.black,
                  ),textAlign: TextAlign.left),
                  SizedBox(height: 16),// Add space between cards

      Stack(
          children: <Widget>[
      Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
            borderRadius: BorderRadius.circular(15.0), // Set the border radius
          ),
          color: selectedPaymentMethod == 1 ? Color(0xFFEDEEF5) : Colors.white,

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
                      value: 1, // Unique value for UPI
                      groupValue: selectedPaymentMethod,
                      onChanged: (int? value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                    ),trailing: Image.asset('assets/card_icon.png',height:20),
                  ),),
                  if (selectedPaymentMethod == 1)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
           color: selectedPaymentMethod == 2 ? Color(0xFFEDEEF5) : Colors.white,
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
                    value: 2, // Unique value for UPI
                    groupValue: selectedPaymentMethod,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),trailing: Image.asset('assets/upi_icon.png',height:20),
                ),
              ),
                if (selectedPaymentMethod == 2)
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

        ),
                  //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                  child:
                ListTile(
                  title: Text('Net Banking'),
                  leading: Radio(
                    value: 3, // Unique value for Net Banking
                    groupValue: selectedPaymentMethod,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),trailing: Image.asset('assets/Netbanking_icon.png',height:20),
                ),),
                if (selectedPaymentMethod == 3)
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
                    value: 4, // Unique value for Cash on Delivery
                    groupValue: selectedPaymentMethod,
                    onChanged: (int? value) {
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
                  )
                  ,// Add space between cards


              ]),
            ),

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

