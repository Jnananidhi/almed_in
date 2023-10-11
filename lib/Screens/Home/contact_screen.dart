import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/constants.dart';
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
                       isActive: true,
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
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: const BoxDecoration(color: kgreyColor ,borderRadius: BorderRadius.all(Radius.circular(50))),
        width: double.infinity,
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
        ))])),
    );
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
                  String name = nameController.text;
                  String email = emailController.text;
                  String message = messageController.text;

                  // Implement your contact form submission logic here
                  print('Name: $name');
                  print('Email: $email');
                  print('Message: $message');
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



