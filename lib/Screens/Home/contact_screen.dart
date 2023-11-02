import 'dart:convert';
import 'package:almed_in/Screens/Home/products/product.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Authentication/login_screen.dart';
import 'about_screen.dart';


class ContactUsApp extends StatefulWidget {
  const ContactUsApp({super.key});

  @override
  State<ContactUsApp> createState() => _ContactUsAppState();
}

class _ContactUsAppState extends State<ContactUsApp> {
  String selectedMenuItem = 'Category';
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
                       press: () {},
                     ),
                   ],
                 ),
               )
             ],
           ),
         ),
         body: Column(
             children: <Widget>[
               const Navigation(),
               const Divider(
                 thickness: 1,
                 height: 0.01, // Set the height of the divider line
                 color: kPrimaryColor, // Set the color of the divider line
               ),
               Expanded(
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       //now we create menu and header

                       ContactUsScreen(),
                       const BottomNav()
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
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      elevation: 10,
      child: Container(
          decoration: const BoxDecoration(color: kWhiteColor ,borderRadius: BorderRadius.all(Radius.circular(50))),
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
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Please fill out the form to raise a query.'),
            const SizedBox(height: 20),
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


  bool isValidEmail() {
    // Basic email validation using a regular expression
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(emailController.text);
  }


  Future<void> senddata() async {
    try {
      final response = await http.post(
        Uri.parse("${api}formData.php"),
        body: {
          "Name": nameController.text,
          "Email": emailController.text,
          "Message": messageController.text,
        },
      );

      if (response.statusCode == 200) {

        // For example, you can parse the response JSON with below 2 lines
        final responseData = json.decode(response.body);
        print(responseData);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Successful'),
              content: const Text('Your feedback has been recorded. We will get back to you as soon as possible'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
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
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: messageController,
            decoration: const InputDecoration(labelText: 'Message'),
            maxLines: 5,
          ),
          const SizedBox(height: 20),
              CustomButton(
                label: 'Submit',
                onPressed: () {
                  if(nameController.text.isEmpty|| emailController.text.isEmpty || messageController.text.isEmpty){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text('Please fill all the details correctly'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );  // showDialog
                  }else if(!isValidEmail()){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text('Entered mail is incorrect..'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else{
                  // Handle form submission here
                  senddata();}
                },

              )
        ],
      ),
    );
  }
}



