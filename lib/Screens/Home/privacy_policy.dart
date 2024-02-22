import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar1.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              'Privacy Policy',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 1 – WHAT DO WE DO WITH YOUR INFORMATION?",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "When you purchase something from our store, as part of the buying and selling process, we collect the personal information you give us such as your name, address and email address. When you browse our store, we also automatically receive your computer’s internet protocol (IP) address in order to provide us with information that helps us learn about your browser and operating system. Email marketing (if applicable): With your permission, we may send you emails about our store, new products and other updates.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 2 – CONSENT",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "How do you get my consent?",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "When you provide us with personal information to complete a transaction, verify your credit card, place an order, arrange for a delivery or return a purchase, we imply that you consent to our collecting it and using it for that specific reason only. If we ask for your personal information for a secondary reason, like marketing, we will either ask you directly for your expressed consent, or provide you with an opportunity to say no.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "How do I withdraw my consent?",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "If after you opt-in, you change your mind, you may withdraw your consent for us to contact you, for the continued collection, use or disclosure of your information, at anytime, by contacting us at info@almed.in or mailing us at Almed.in No 77/K, Ist Floor, 17th Cross, 4th Stage, 4th Block, W.O.C Road, Basaveshwara nagara, Bengaluru – 560079, Karnataka.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 3 – DISCLOSURE",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We may disclose your personal information if we are required by law to do so or if you violate our Terms of Service.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 4 – PAYMENT",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We use Razorpay for processing payments. We/Razorpay do not store your card data on their servers. The data is encrypted through the Payment Card Industry Data Security Standard (PCI-DSS) when processing payment. Your purchase transaction data is only used as long as is necessary to complete your purchase transaction. After that is complete, your purchase transaction information is not saved. Our payment gateway adheres to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, MasterCard, American Express and Discover. PCI-DSS requirements help ensure the secure handling of credit card information by our store and its service providers. For more insight, you may also want to read terms and conditions of razorpay on https://razorpay.com",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 5 – THIRD-PARTY SERVICES",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "In general, the third-party providers used by us will only collect, use and disclose your information to the extent necessary to allow them to perform the services they provide to us.\n"
                                    "However, certain third-party service providers, such as payment gateways and other payment transaction processors, have their own privacy policies in respect to the information we are required to provide to them for your purchase-related transactions.\n"
                                    "For these providers, we recommend that you read their privacy policies so you can understand the manner in which your personal information will be handled by these providers."
                                    "In particular, remember that certain providers may be located in or have facilities that are located a different jurisdiction than either you or us. So if you elect to proceed with a transaction that involves the services of a third-party service provider, then your information may become subject to the laws of the jurisdiction(s) in which that service provider or its facilities are located."
                                    "Once you leave our store’s website or are redirected to a third-party website or application, you are no longer governed by this Privacy Policy or our website’s Terms of Service.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Links",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "When you click on links on our store, they may direct you away from our site. We are not responsible for the privacy practices of other sites and encourage you to read their privacy statements.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 6 - SECURITY",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "To protect your personal information, we take reasonable precautions and follow industry best practices to make sure it is not inappropriately lost, misused, accessed, disclosed, altered or destroyed.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 7 - COOKIES",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We use cookies to maintain session of your user. It is not used to personally identify you on other websites.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 8 - AGE OF CONSENT",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "By using this site, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 9 – CHANGES TO THIS PRIVACY POLICY",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We reserve the right to modify this privacy policy at any time, so please review it frequently. Changes and clarifications will take effect immediately upon their posting on the website. If we make material changes to this policy, we will notify you here that it has been updated, so that you are aware of what information we collect, how we use it, and under what circumstances, if any, we use and/or disclose it.If our store is acquired or merged with another company, your information may be transferred to the new owners so that we may continue to sell products to you.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "QUESTIONS AND CONTACT INFORMATION",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "If you would like to: access, correct, amend or delete any personal information we have about you, register a complaint, or simply want more information contact our Privacy Compliance Officer at info@almed.in or POST : No 77/K, Ist Floor, 17th Cross, 4th Stage, 4th Block, W.O.C Road, Basaveshwara nagara, Bengaluru – 560079, Karnataka.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "[Re: Privacy Compliance Officer]\n[622 Manglam Electronic Market Jaipur Rajasthan India 302001]",
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
