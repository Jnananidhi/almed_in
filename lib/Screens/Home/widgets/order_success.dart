import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Authentication/login_screen.dart';
import '../about_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../products/products_screen.dart';
import 'menu.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  String selectedMenuItem = 'Category';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Image(image: AssetImage('assets/logo.png'),height: 80),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                isActive: true,
                title: 'Home',
                press: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'About Us',
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
                },
              ),

              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'FAQ',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FaqScreen()),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),

              DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: selectedMenuItem,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedMenuItem = newValue;
                      // Add logic to navigate to the related page based on selectedMenuItem
                      if (selectedMenuItem == 'Therapeutic') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),

                        );

                      } else if (selectedMenuItem == 'Strength') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                        );
                      }
                      else if (selectedMenuItem == 'Company') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                        );
                      }else if (selectedMenuItem == 'Form') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                        );
                      }
                    });
                  }
                },
                items: ['Category','Therapeutic', 'Company', 'Form', 'Strength']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:  18 ,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                // Set the underline property to Container() to hide the underline.
                underline: Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'Vendor?',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginPage()),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'Contact Us',
                press: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsApp()));},
              ),
            ],
          )),
      body: WillPopScope(
        onWillPop:() async{
          Navigator.pushNamed(context, '/product-screen');
          return true;
        },
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/success_animation.json",repeat: false,height: 200),
            const Text("Order Successful",textAlign: TextAlign.center,style: TextStyle(color: Colors.teal,fontSize: 18,fontFamily: 'DMSans Bold',fontWeight: FontWeight.bold)),
            const Text("Your Order id 0000000 has been successfully confirmed\nThanks for buying at Almed..",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'DMSans Light',fontWeight: FontWeight.bold)),
          ],
    ),
        ),
      ),
    );
  }
}
