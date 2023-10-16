import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "India's first All Medicine Distributor" ,
      //removing debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'DMSans Bold'
      ),
      home: const HomeScreen(),
    );
  }
}

