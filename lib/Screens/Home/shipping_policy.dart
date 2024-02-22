import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar1.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ShippingPolicyRefund extends StatefulWidget {
  const ShippingPolicyRefund({super.key});

  @override
  State<ShippingPolicyRefund> createState() => _ShippingPolicyRefundState();
}

class _ShippingPolicyRefundState extends State<ShippingPolicyRefund> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kWhiteColor,
      //scrollable widget
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Image(image: AssetImage('assets/logo_rmbck.png'),height: 80),
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

                    title: 'Home',
                    press: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    isActive: true,
                    title: 'About Us',
                    press: () {
                      Navigator.pushNamed(context, "/aboutAlmed.in");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'FAQ',
                    press: () {
                      Navigator.pushNamed(context, "/faq");

                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'Search Medicines',
                    press: () {
                      Navigator.pushNamed(context, "/alphabeticSearch");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'Seller?',
                    press: () {
                      Navigator.pushNamed(context, "/login");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'Contact Us',
                    press: () {Navigator.pushNamed(context, "contactUs");},
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
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: const Column(

                          children: <Widget>[
                            SizedBox(height: 20),
                            Text(
                              'Shipping Policy',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Thank you for visiting and shopping at our almed.in. Following are the terms and conditions that constitute our Shipping Policy.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Domestic Shipping Policy",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Shipment processing time. All orders are processed preferably within 2-3 hours. Orders are not shipped or delivered on holidays. If we are experiencing a high volume of orders, shipments may be delayed by a few hours. Please allow additional days in transit for delivery. If there will be a significant delay in shipment of your order, we will contact you via email or telephone.Update this section if your processing time exceeds 2-3 business days.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Shipping rates & delivery estimates ",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Our shipping charges in Bengaluru city limits (India) will be free.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Shipment confirmation & Order tracking",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "You will receive a Shipment Confirmation email once your order has processed and you will be updating once it is out for delivery. You will be receiving mail containing your tracking order number(s), along with delivery person name and phone number and also time.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Damages",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Almed.in is not liable for any products damaged or lost during shipping. We request you to check the damages if any during the delivery. If you received your order damaged, please contact the shipment carrier to file a claim. We currently do not ship outside India.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Returns Policy",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Our Return & Refund Policy provides detailed information about options and procedures for returning your order\n",
                                     style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),

                          ],
                        ),
                      ),
                      const BottomNav()
                    ],
                    //now we create banner
                    //for this import packages

                    //now we will make our site responsive

                  ),
                ),
              ),

            ],
          ),
            Positioned(
              top: MediaQuery.of(context).size.width < 600
                  ? 90// Adjust the value for mobile view
                  :20,
              left: MediaQuery.of(context).size.width < 600
                  ? 0 // Adjust the value for mobile view
                  : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
              right: MediaQuery.of(context).size.width < 600
                  ? 0 // Adjust the value for mobile view
                  : MediaQuery.of(context).size.width * 0.25,
              child: Search_bar1(),
            ),

          ]),
    );
  }
}
