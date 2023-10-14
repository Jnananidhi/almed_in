import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
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
      color: kgreyColor,
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
                        "Are you a vendor?",
                    style: TextStyle(
                      fontFamily: 'DMSans Bold' ,
                      fontSize: _size.width >= 370 ? 20 : 10,
                    ),
                    ),
                    CustomButton(
                      onPressed: () {},
                      label: 'Login',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Disclaimer",
                      style: TextStyle(
                        fontFamily: 'DMSans Bold' ,
                        fontSize: _size.width >= 370 ? 20 : 10,
                      ),
                    ),

            Text(
              "The contents of this website are for informational purposes only and not intended to be a substitute for professional medical advice, diagnosis, or treatment. Please seek the advice of physician or other qualified health provider with any questions you may have regarding a medical condition. Do not disregard professional medical advice or delay in seeking it because of something you have read on this website.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'DMSans Regular' ,
                fontSize: _size.width >= 370 ? 15 : 10,
              ),
            ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Almed.in All Rights Reserved",
                        style: TextStyle(
                          fontSize: _size.width >= 370 ? 15 : 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text("Designed with ❤️ by Linkable Technologies",
                      style: TextStyle(
                        fontSize: _size.width >= 370 ? 15 : 10,
                      ),
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
