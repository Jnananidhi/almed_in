import 'dart:convert';

import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class ContactUsApp extends StatelessWidget {
  const ContactUsApp({super.key});


  @override
  Widget build(BuildContext context) {
      return Scaffold(
         backgroundColor: kWhiteColor,
         //scrollable widget
         drawer: Drawer(
           child: ListView(
             children: [
               const DrawerHeader(
                 child: Center(
                   child: Image(image: AssetImage('logo.png')),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 15),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(
                       height: 10,
                     ),
                     MenuItems(
                       isActive: false,
                       title: 'Home',
                       press: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => const HomeScreen()),
                         );
                       },
                     ),
                     const SizedBox(
                       height: 10,
                     ),
                     MenuItems(
                       title: 'About Us',
                       press: () {},
                     ),
                     const SizedBox(
                       height: 10,
                     ),
                     MenuItems(
                       title: 'Why Almed',
                       press: () {},
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
                     MenuItems(
                       isActive: true,
                       title: 'Contact Us',
                       press: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => const HomeScreen()),
                         );
                       },
                     ),
                   ],
                 ),
               )
             ],
           ),
         ),
         body: Column(
             children: <Widget>[
               Expanded(
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       //now we create menu and header
                       Navigation(),
                       ContactUsScreen(),
                       BottomNav()
                       //now we will make our site responsive
                     ],
                   ),
                 ),
               )]));
  }
}

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: const BoxDecoration(color: kgreyColor ,borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Column(
        children: [
      Container(
      constraints: const BoxConstraints(
      maxWidth: kMaxWidth,
      ),
      child: Column(
          children: [
      Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text('Please fill out the form to raise a query.'),
          SizedBox(height: 20),
          ContactForm(),
        ],
      ),
    )],
      ))]));
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  Future<void> senddata() async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.15.100:8080/formData.php"),
        body: {
          "Name": nameController.text,
          "Email": emailController.text,
          "Message": messageController.text,
        },
      );

      if (response.statusCode == 200) {

        // Request was successful, handle the response here if needed.
        // For example, you can parse the response JSON.
        final responseData = json.decode(response.body);
        print(responseData);
        // Do something with responseData.
      } else {
        // Handle the case when the request was not successful.
        // You can throw an exception or display an error message.
        throw Exception('Failed to submit data');
      }
    } catch (e) {
      // Handle any exceptions that might occur during the request.
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: messageController,
            decoration: InputDecoration(labelText: 'Message'),
            maxLines: 5,
          ),
          SizedBox(height: 20),
              MaterialButton(
                color: kSecondaryColor,
                onPressed: () {
                  // Handle form submission here
                  senddata();
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: kWhiteColor),
                ),
              )
        ],
      ),
    );
  }
}



