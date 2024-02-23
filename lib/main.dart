

import 'package:almed_in/Screens/Home/Authentication/forgot1.dart';
import 'package:almed_in/Screens/Home/Authentication/login_screen.dart';
import 'package:almed_in/Screens/Home/Authentication/login_status.dart';
import 'package:almed_in/Screens/Home/Authentication/register_screen.dart';
import 'dart:html' as html;

import 'package:almed_in/Screens/Home/about_screen.dart';
import 'package:almed_in/Screens/Home/address_screen.dart';
import 'package:almed_in/Screens/Home/cart_screen_desktop.dart';
import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/my_orders.dart';
import 'package:almed_in/Screens/Home/not_found_screen.dart';
import 'package:almed_in/Screens/Home/privacy_policy.dart';
import 'package:almed_in/Screens/Home/profile_screen.dart';
import 'package:almed_in/Screens/Home/terms_of_service_screen.dart';
import 'package:almed_in/Screens/Home/widgets/alphabetic_search.dart';
import 'package:almed_in/Screens/Home/widgets/alphabetic_search1.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Home/cart_provider.dart';
import 'Screens/Home/products/products_screen.dart';
import 'Screens/Home/products/widgets/test.dart';
import 'Screens/Home/widgets/custom_listview.dart';
void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "India's first All Medicine Distributor",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'DMSans Bold',
      ),
      initialRoute: '/home',
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const NotFoundPage(), // Your 404 page
        );
      },
      routes: {
        '/home': (context) => HomeScreen(),
        '/cart': (context) => CartScreen(),
        '/aboutAlmed.in': (context) => const AboutScreen(),
        '/faq': (context) => const FaqScreen(),
        '/contactUs': (context) => const ContactUsApp(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationScreen(),
        '/alphabeticSearch': (context) => const AlphabeticPage(),
        //'/test':(context)=> AlphabeticPage(),
        '/forgot_password': (context) => const forgot1(),
        '/userProfile': (context) => UserProfile(),
        '/address-page': (context) => AddressScreen(),
        '/product-screen': (context) => const ProductScreen(),
        '/myOrders':(context) => const MyOrders(),
        '/privacy-policy':(context) => const PrivacyPolicyScreen(),
        '/terms-of-service': (context) => const TermsScreen(),
        '/shipping-policy': (context) => const ShippingPolicyRefund(),
        '/refund-policy': (context) => const RefundPolicyScreen(),
      },
    );
  }
}
