import 'package:almed_in/Screens/Home/Authentication/login_screen.dart';
import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/responsive.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';

import 'menu.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      color: lightColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            constraints: const BoxConstraints(maxWidth: kMaxWidth),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                        "Not finding the medicines?",
                    style: TextStyle(
                      fontFamily: 'DMSans Light' ,
                      fontSize: _size.width >= 370 ? 20 : 10,
                    ),
                    ),
                    CustomButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   ContactUsApp()),
                        );
                      },
                      label: 'Let us Know',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Spacer(),
                        WebMenu(),
                        Spacer(),
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
                      thickness: 1,
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
                      child: Text(
                        "Almed.in All Rights Reserved",
                        style: TextStyle(
                          fontFamily: 'DMSans Light',
                          fontSize: _size.width >= 370 ? 15 : 10,
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
                            'assets/heart_icon.png',height: 25,width: 25),
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
