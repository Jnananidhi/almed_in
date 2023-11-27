

import 'package:almed_in/Screens/Home/Authentication/login_screen.dart';
import 'package:almed_in/Screens/Home/Authentication/login_status.dart';
import 'package:almed_in/Screens/Home/about_screen.dart';
import 'package:almed_in/Screens/Home/address_screen.dart';
import 'package:almed_in/Screens/Home/cart_screen_desktop.dart';
import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/widgets/alphabetic_search.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Home/cart_provider.dart';

void main() async {
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
      ChangeNotifierProvider<CartProvider>(create: (context) => CartProvider()),

    ],
    child: MyApp(),
  ));
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
     // home: const HomeScreen(),
      builder: EasyLoading.init(),
      initialRoute: '/home',  // Initial route when the app is first launched
      routes: {
        '/home': (context) => HomeScreen(),  // Home page
        '/cart': (context) => CartScreen(),  // Shopping cart page
        '/aboutAlmed.in': (context) => AboutScreen(),
        '/faq': (context) => FaqScreen(),
        '/contactUs': (context) => ContactUsApp(), // Checkout page
        '/login': (context) => LoginPage(),
        '/alphabeticSearch': (context) => LetterRow(),
        '/address-page':(context) => AddressScreen(),
      },
    );
  }
}

