import 'dart:convert';
import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Center(
                    child: Image(image: AssetImage('assets/logo_rmbck.png'),height: 80),
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

                        title: 'Home',
                        press: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MenuItems(
                        title: 'About Us',
                        press: () {
                          Navigator.pushNamed(context, "/aboutAlmed.in");
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MenuItems(
                        title: 'FAQ',
                        press: () {
                          Navigator.pushNamed(context, "/faq");

                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MenuItems(
                        title: 'Search Medicines',
                        press: () {
                          Navigator.pushNamed(context, "/alphabeticSearch");
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MenuItems(
                        title: 'Seller?',
                        press: () {
                          Navigator.pushNamed(context, "/login");
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MenuItems(
                        isActive: true,
                        title: 'Contact Us',
                        press: () {Navigator.pushNamed(context, "contactUs");},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
         body: Stack(
           children:[ Column(
               children: <Widget>[
                 const Navigation(),

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
                 )]),
             Positioned(
               top: MediaQuery.of(context).size.width < 600
                   ? 90// Adjust the value for mobile view
                   :50,
               left: MediaQuery.of(context).size.width < 600
                   ? 0 // Adjust the value for mobile view
                   : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
               right: MediaQuery.of(context).size.width < 600
                   ? 0 // Adjust the value for mobile view
                   : MediaQuery.of(context).size.width * 0.25,
               child: Search_bar(),
             ),

           ],));
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
            const Text('Please fill out the form to raise a query.',style: TextStyle(color: kSecondaryColor),),
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
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Successful!',
            message:
            'Your feedback has been recorded. We will get back to you as soon as possible',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //       title: const Text('Successful'),
        //       content: const Text('Your feedback has been recorded. We will get back to you as soon as possible'),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //           child: const Text('OK'),
        //         ),
        //       ],
        //     );
        //   },
        // );
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
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'DMSans Regular',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'DMSans Regular',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: messageController,
            decoration: InputDecoration(
              labelText: 'Message',
              labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'DMSans Regular',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: Container(
              width: 100,
                height: 50,
                child: const Center(child: Text("Submit"))),
                style: ElevatedButton.styleFrom(
                  foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if(nameController.text.isEmpty|| emailController.text.isEmpty || messageController.text.isEmpty){
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Empty field!',
                        message:
                        'Please fill all the details correctly...',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.warning,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);// showDialog
                  }else if(!isValidEmail()){
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Incorrect mail!',
                        message:
                        'Entered Email is incorrect..',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.warning,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);                  }
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



