import 'package:almed_in/Screens/Home/Authentication/login_screen.dart';
import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:almed_in/Screens/Home/products/widgets/custom_button.dart';
import 'package:almed_in/responsive.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';

import '../about_screen.dart';
import '../faq_screen.dart';
import '../home_screen.dart';
import 'menu.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFFABE0E1) // Your color code
             // You can add more colors for the gradient
          ],
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            constraints: const BoxConstraints(maxWidth: double.infinity),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                        "Not finding the medicines?",
                    style: TextStyle(
                      fontFamily: 'DMSans Light' ,
                      fontSize: _size.width >= 370 ? 16 : 10,
                    ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, right: 10), // Add right padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Align children to the end (right side)
                        children: [
                          CustomButton(
                            text: "Let us Know",
                            onPressed: () {
                              Navigator.pushNamed(context, "/contactUs");
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MenuItems(
                          title: 'Home',
                          press: () {
                            Navigator.pushNamed(context, '/home');

                          },
                        ),
                        MenuItems(
                          title: 'About US',
                          press: () {
                            Navigator.pushNamed(context, '/aboutAlmed.in');

                          },
                        ),
                        MenuItems(
                          title: 'FAQ',
                          press: () {
                            Navigator.pushNamed(context, '/faq');
                          },
                        ),
                        MenuItems(
                          title: 'Contact Us',
                          press: () {
                            Navigator.pushNamed(context, '/contactUs');

                          },
                        ),
                      ],
                    ),

            //         Text(
            //           "Disclaimer",
            //           style: TextStyle(
            //             fontFamily: 'DMSans Bold' ,
            //             fontSize: _size.width >= 370 ? 20 : 10,
            //           ),
            //         ),
            //
            // Text(
            //   "The contents of this website are for informational purposes only and not intended to be a substitute for professional medical advice, diagnosis, or treatment. Please seek the advice of physician or other qualified health provider with any questions you may have regarding a medical condition. Do not disregard professional medical advice or delay in seeking it because of something you have read on this website.",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     height:2,
            //     color: Colors.black,
            //     fontFamily: 'DMSans Regular' ,
            //     fontSize: _size.width >= 370 ? 15 : 10,
            //   ),
            // ),



                    const Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  const SizedBox(
                      height: 10,
                    ),
                    // const Divider(
                    //   thickness: 1,
                    //   color: Colors.black,
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                  ],
                ),
                !Responsive.isMobile(context)
                    ?Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.copyright_sharp,
                                size: _size.width >= 370 ? 15 : 10, // Adjust the size as needed
                              ),
                            ),
                            TextSpan(
                              text: " 2024 Almed.in. All Rights Reserved",
                              style: TextStyle(
                                fontFamily: 'DMSans Light',
                                fontSize: _size.width >= 370 ? 15 : 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget> [
                        Text("Designed with ",
                          style: TextStyle(
                            fontFamily: 'DMSans Light',
                            fontSize:15,
                          ),
                        ),
                        Image.asset(
                            'heart_icon.png',height: 10,width: 10),
                        Text(" by Linkable Technologies",
                          style: TextStyle(
                            fontFamily: 'DMSans Light',
                            fontSize:15,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                    :Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Almed.in All Rights Reserved",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget> [
                        Text("Designed with ",
                          style: TextStyle(
                            fontSize:12,
                          ),
                        ),
                        Image.asset(
                            'assets/heart_icon.png',height: 10,width: 10),
                        Text(" by Linkable Technologies",
                          style: TextStyle(
                            fontSize:12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
