import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'bottomnav.dart';
import 'menu.dart';
import 'order_success.dart';


class CheckoutScreen extends StatefulWidget {
  @override
  CheckoutScreenState createState() => CheckoutScreenState();
  }

  class CheckoutScreenState extends State<CheckoutScreen> {
    int? selectedPaymentMethod;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
        children: [
        Navigation(),
    Expanded(
    child: SingleChildScrollView(
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
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), // Set the border radius as needed
                        border: Border.all(
                          color: kDarkblueColor, // Set the border color
                          width: 2.0, // Set the border width
                        ),
                      ),
                      child: Card(
                        elevation: 0,
                        child:
                   Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text('Contact'),
                              SizedBox(width: 10), // Add spacing between text and text field
                              Expanded(
                                child: TextField(
                                  // Add your text field properties here
                                  decoration: InputDecoration(
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Text('Ship To'),
                              SizedBox(width: 10), // Add spacing between text and text field
                              Expanded(
                                child: TextField(
                                  // Add your text field properties here
                                  decoration: InputDecoration(
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Text('Method'),
                              SizedBox(width: 10), // Add spacing between text and text field
                              Expanded(
                                child: TextField(
                                  // Add your text field properties here
                                  decoration: InputDecoration(
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )],
                    ),
                  )),
                  SizedBox(height: 16),
                  
                  Text("Payment Method",style:TextStyle(
                    fontWeight:FontWeight.bold,
                    fontSize: _size.width >= 370 ? 18 : 14,
                    fontFamily: 'DMSans Bold',
                    color: Colors.black,
                  ),),
                  SizedBox(height: 16),// Add space between cards
                 Container(
                    decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20), // Set the border radius as needed
                         border: Border.all(
                              color: kDarkblueColor, // Set the border color
                            width: 2.0, // Set the border width
                          ),
                          ),
                  child:
                      Card(
                        elevation: 0,
                        child:Column(
                                children: [
                                  ListTile(
                                  title: Text('Credit/Debit'),
                                ),
                                  ListTile(
                                    title:TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Card Number',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10), // Set the border radius
                                          borderSide: BorderSide(
                                            color: Colors.black, // Set the border color
                                            width: 1.0, // Set the border width
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  ListTile(
                                    title:TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Holder Name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10), // Set the border radius
                                          borderSide: BorderSide(
                                            color: Colors.black, // Set the border color
                                            width: 1.0, // Set the border width
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Expiration',
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
                                        SizedBox(width: 10), // Add spacing between text fields
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'CVV',
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
                                  )
                                  ,]))
                 ),
                  
                  
                  SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: kDarkblueColor,
              width: 2.0,
            ),
          ),
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  title: Text('UPI'),
                  leading: Radio(
                    value: 1, // Unique value for UPI
                    groupValue: selectedPaymentMethod,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
                if (selectedPaymentMethod == 1)
                  ListTile(
                    title: Text('Additional Content Here'),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: kDarkblueColor,
              width: 2.0,
            ),
          ),
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  title: Text('Net Banking'),
                  leading: Radio(
                    value: 2, // Unique value for Net Banking
                    groupValue: selectedPaymentMethod,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
                if (selectedPaymentMethod == 2)
                  ListTile(
                    title: Text('Additional Content Here'),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: kDarkblueColor,
              width: 2.0,
            ),
          ),
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  title: Text('Cash on Delivery'),
                  leading: Radio(
                    value: 3, // Unique value for Cash on Delivery
                    groupValue: selectedPaymentMethod,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: Container(
                          width: MediaQuery.of(context).size.width < 600
                              ? kMaxWidth / 15.5 // Adjust the value for mobile view
                              : kMaxWidth / 10.5,
                          height: 40,
                          child: const Center(child: Text("Place Order")),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: kWhiteColor,
                          backgroundColor: Color(0xFF00AFBB),
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
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end
                  ,
                children:[ Container(
                  alignment: Alignment.topRight,
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Price Details'),
                        ),
                        ListTile(
                          title: Text('Subtotal: \$100.00'),
                        ),
                        ListTile(
                          title: Text('Total: \$120.00'),
                        ),
                        ListTile(
                          title: Text('Price: \$100.00'),
                        ),
                      ],
                    ),
                  ),
                ),
            ]  ),
            ),


          ],
        ),
      ]),
    )]))])),
          BottomNav(), ])))]));
  }
}
