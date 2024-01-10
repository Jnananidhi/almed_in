import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [kPrimaryColor, kSecondaryColor], // Adjust colors as needed
                ).createShader(bounds);
              },
              child: Icon(
                Icons.error_outline,
                size: 100.0,
                color: Colors.white,
              ),
            ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [kPrimaryColor, kSecondaryColor], // Adjust colors as needed
                ).createShader(bounds);
              },
              child: Text("404",style: TextStyle(fontFamily: 'DMSans Bold',
                  fontSize: 100,color: Colors.white,
              ),
              ),
            ),

            Text(
              'Oops! Page not found.',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'DMSans Bold',
                color: Colors.black
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'The page you are looking for might be under construction or does not exist.',
              textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontFamily: 'DMSans Bold'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Container(
                  width: 100,
                  height: 50,
                  child: const Center(child: Text("Go Back"))),
              style: ElevatedButton.styleFrom(
                foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
