import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bill_summary_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../Authentication/login_screen.dart';
import '../about_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../products/products_screen.dart';
import 'menu.dart';
import 'order_success.dart';


class CheckoutScreenMobile extends StatefulWidget {
  final String? userInput,Address,RName,Pnumber;

  CheckoutScreenMobile({this.userInput,this.Address,this.RName,this.Pnumber});
  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreenMobile> {
  int? selectedPaymentMethod;
  String selectedMenuItem = 'Category';
  @override
  void initState() {
    print(widget.userInput);
    super.initState();
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
                 // isActive: true,
                  title: 'Home',
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

                  },
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
                        style:  const TextStyle(
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
                      MaterialPageRoute(builder: (context) =>  const LoginPage()),
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
            const Navigation(),
            const Divider(
              thickness: 1,
              height: 0.01, // Set the height of the divider line
              color: kPrimaryColor, // Set the color of the divider line
            ),
            Expanded(child: SingleChildScrollView(
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
                          const ListTile(
                            title: Text('DELIVERY ADDRESS',style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'DMSans Regular',
                            ),),
                          ),
                          ListTile(
                            title: Text(' ${widget.RName ?? ""}'" - "'${widget.Pnumber ?? ""}',style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'DMSans Regular',
                            ),),

                          ),
                          ListTile(
                            title: Text('${widget.Address ?? ""}'" "'${widget.userInput ?? ""}',style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'DMSans Regular',
                            ),),

                          ),
                          const SizedBox(height: 16),

                        ],
                      ),
                    ),),
                    Padding(
                      padding:const EdgeInsets.all(20),
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
                    const SizedBox(height: 10),
                 Stack(
                     children: <Widget>[
                       Card(
                         shape: RoundedRectangleBorder(
                           side: const BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
                           borderRadius: BorderRadius.circular(15.0), // Set the border radius
                         ),
                         color: selectedPaymentMethod == 1 ? const Color(0xFFEDEEF5) : Colors.white,

                         child: Column(
                           children: <Widget>[
                             Container(
                               decoration: BoxDecoration(
                                 borderRadius:  BorderRadius.circular(15.0),

                               ),
                               //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                               child: ListTile(
                                 title: const Text('Credit Card'),
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
                                 padding: const EdgeInsets.only(left:80,right:16.0,top:16.0,bottom:16.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.stretch,
                                   children: <Widget>[
                                     const Text('Card Holder Name'),
                                     const SizedBox(height: 10),
                                     Container(
                                       height: 40,
                                       alignment: Alignment.center,
                                       child: TextFormField(
                                           keyboardType: TextInputType.number,
                                           decoration: InputDecoration(
                                             filled: true, // This property is used to fill the background color
                                             fillColor: Colors.white,
                                             hintText: 'Card holder Name',
                                             hintStyle: const TextStyle(fontSize: 12),
                                             border: OutlineInputBorder(
                                               borderRadius: BorderRadius.circular(10),
                                               borderSide: const BorderSide(
                                                 color: Colors.black,
                                                 width: 1.0,
                                               ),
                                             ),
                                           )
                                       ),
                                     ),
                                     const SizedBox(height: 20),
                                     const Text('Card Number'),
                                     const SizedBox(height: 10),
                                     Container(
                                       height: 40,
                                       alignment: Alignment.center,
                                       child: TextFormField(
                                           keyboardType: TextInputType.number,
                                           decoration: InputDecoration(
                                             filled: true, // This property is used to fill the background color
                                             fillColor: Colors.white,
                                             hintText: 'Enter Card number',
                                             hintStyle: const TextStyle(fontSize: 12),
                                             border: OutlineInputBorder(
                                               borderRadius: BorderRadius.circular(10),
                                               borderSide: const BorderSide(
                                                 color: Colors.black,
                                                 width: 1.0,
                                               ),
                                             ),
                                           )
                                       ),
                                     ),
                                     const SizedBox(height: 20),
                                     Row(
                                       children: <Widget>[
                                         Expanded(
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                               const Text('Expiry Date',),
                                               const SizedBox(height: 10),
                                               Container(
                                                 height: 40,
                                                 alignment: Alignment.center,// Set the height you desire
                                                 child: TextFormField(
                                                   keyboardType: TextInputType.datetime,
                                                   decoration: InputDecoration(
                                                     filled: true, // This property is used to fill the background color
                                                     fillColor: Colors.white,
                                                     hintText: 'MM/YY',
                                                     hintStyle: const TextStyle(fontSize: 12),
                                                     border: OutlineInputBorder(
                                                       borderRadius: BorderRadius.circular(10),
                                                       borderSide: const BorderSide(
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
                                         const SizedBox(width: 10),
                                         Expanded(
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                               const Text('CVV'),
                                               const SizedBox(height: 10),
                                               Container(
                                                 height: 40,
                                                 alignment: Alignment.center,
                                                 child: TextFormField(
                                                     keyboardType: TextInputType.number,
                                                     decoration: InputDecoration(
                                                       filled: true, // This property is used to fill the background color
                                                       fillColor: Colors.white,
                                                       hintText: 'CVV',
                                                       hintStyle: const TextStyle(fontSize: 12),
                                                       border: OutlineInputBorder(
                                                         borderRadius: BorderRadius.circular(10),
                                                         borderSide: const BorderSide(
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
                                     const SizedBox(height: 20),
                                   ],
                                 ),
                               ),

                           ],
                         ),
                       ),
                     ]),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
                      borderRadius: BorderRadius.circular(15.0), // Set the border radius
                    ),
                    color: selectedPaymentMethod == 2 ? const Color(0xFFEDEEF5) : Colors.white,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(15.0),

                          ),
                          //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                          child:
                          ListTile(
                            title: const Text('UPI'),
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
                                              const Text('UPI ID',),
                                              const SizedBox(height: 10),
                                              Container(
                                                height: 40,
                                                alignment: Alignment.center,// Set the height you desire
                                                child: TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    filled: true, // This property is used to fill the background color
                                                    fillColor: Colors.white,
                                                    hintText: 'Enter your UPI ID',
                                                    hintStyle: const TextStyle(fontSize: 12),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(
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
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Text('',),
                                              const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
                      borderRadius: BorderRadius.circular(15.0), // Set the border radius
                    ),
                    color: selectedPaymentMethod == 2 ? const Color(0xFFEDEEF5) : Colors.white,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(15.0),

                          ),
                          //color: selectedPaymentMethod == 1 ? lightColor : Colors.white,
                          child:
                          ListTile(
                            title: const Text('UPI'),
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
                                              const Text('UPI ID',),
                                              const SizedBox(height: 10),
                                              Container(
                                                height: 40,
                                                alignment: Alignment.center,// Set the height you desire
                                                child: TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    filled: true, // This property is used to fill the background color
                                                    fillColor: Colors.white,
                                                    hintText: 'Enter your UPI ID',
                                                    hintStyle: const TextStyle(fontSize: 12),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(
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
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Text('',),
                                              const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
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
                            title: const Text('Net Banking'),
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
                          const ListTile(
                            title: Text('Additional Content Here'),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color:Color(0xFFF1F3F6), width: 2.0), // Set the border color and width
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
                            title: const Text('Cash on Delivery'),
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
                      padding: const EdgeInsets.all(20),
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
                  ),

                ],
              ),
            )),
            BillSummary(),

          ],
        ));

  }//updated
}

