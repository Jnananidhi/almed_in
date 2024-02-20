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
      color: Color.fromRGBO(242,242,242,0.2),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
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
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                     const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MenuItems(
                          title: 'Terms Of Service',
                          press: () {
                            //Navigator.pushNamed(context, '/home');

                          },
                        ),
                        MenuItems(
                          title: 'Privacy Policy',
                          press: () {
                            //Navigator.pushNamed(context, '/aboutAlmed.in');

                          },
                        ),
                        MenuItems(
                          title: 'Refund Policy',
                          press: () {
                           // Navigator.pushNamed(context, '/faq');
                          },
                        ),
                        MenuItems(
                          title: 'Shopping Policy',
                          press: () {
                            //Navigator.pushNamed(context, '/contactUs');

                          },
                        ),
                      ],
                    ),
                    const Spacer(),
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
