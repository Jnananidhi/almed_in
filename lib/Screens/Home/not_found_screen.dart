import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 100.0,
              color: Colors.red,
            ),
            Text("404",style: TextStyle(fontFamily: 'DMSans Bold',fontSize: 100,color: Colors.red)),

            Text(
              'Oops! Page not found.',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'DMSans Bold',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'The page you are looking for might be under construction or does not exist.',
              textAlign: TextAlign.center,
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
