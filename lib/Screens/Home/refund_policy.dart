
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar1.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class RefundPolicyScreen extends StatefulWidget {
  const RefundPolicyScreen({super.key});

  @override
  State<RefundPolicyScreen> createState() => _RefundPolicyScreenState();
}

class _RefundPolicyScreenState extends State<RefundPolicyScreen> {
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
                              'Refund Policy',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Returns",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We understand that there will be genuine reasons when you decide to cancel or return an order.  To process a return/cancel/refund, please raise a ticket on the Android / IOS app / website for any issue within 4 days of delivery. No refunds will be processed beyond 4 days from the date of delivery.\n"
                                    "To be eligible for a return, your item must be unused and in the same condition that you received it. It must also be in the original packaging. We will process the return only if all products returned in an invoice, but not part of it. Several types of goods are exempt from being returned. Any item not in its original condition or damaged or missing parts ,cold chain items, some speciality items and generic items respectfully cannot be returned. We also do not accept products that are intimate or sanitary goods, hazardous materials, or flammable liquids or gases.\n"
                                    "4 days return policy may not apply, if Gov. or Drug controller department recalls any particular product, for reasons like NSQ or any other reason, we will take back such products and refund of such products as per norms.\n"
                                    "To complete your return, we require a receipt or proof of purchase. Please do not send your purchase back to the manufacturer. There are certain situations where only partial refunds are granted: (if applicable)",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Refunds (if applicable)",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Once your return is received and inspected, we will send you an email to notify you that we have received your returned item. We will also notify you of the approval or rejection of your return/refund. If you are approved, then your refund will be processed, and a credited automatically to your credit card or original method of payment, within a 15 amount of days. If the payment is made cash on delivery, in such cases refund will be processed to customer bank account.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Late or missing refunds (if applicable)",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "If you haven’t received a refund yet, first check your bank account again. Then contact your credit card company, it may take some time before your refund is officially posted. Next contact your bank. There is often some processing time before a refund is posted. If you’ve done all of this and you still have not received your refund yet, please contact us at info@almed.in",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Sale items (if applicable)",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Only regular priced items may be refunded, unfortunately sale items cannot be refunded.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Exchanges (if applicable)",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We only replace items if they are defective or damaged.  If you need to exchange it for the same item, send us an email at info@almed.in and send your item to: Almed No-77/K,I Floor,17 Cross,4th  Block,4th  Stage, Basaveshwara nagara,Bengaluru-560079 India.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Shipping",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "To return your product, you should courier your product to: Almed No-77/K,I Floor,17 Cross,4th  Block,4th  Stage, Basaveshwara nagara,Bengaluru-560079 India. You will be responsible for paying for your own shipping costs for returning your item. Shipping costs are non-refundable. If you receive a refund, the cost of return shipping will be deducted from your refund. Depending on where you live, the time it may take for your exchanged product to reach you, may vary. If you are shipping an item over Rs100, you should consider using a tractable shipping service or purchasing shipping insurance. We don’t guarantee that we will receive your returned item. ",
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
