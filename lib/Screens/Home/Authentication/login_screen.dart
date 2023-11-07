
import 'dart:convert';

import 'package:almed_in/Screens/Home/Authentication/forgot1.dart';
import 'package:almed_in/Screens/Home/Authentication/register_screen.dart';
import 'package:almed_in/Screens/Home/profile_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../about_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../products/product.dart';


  class LoginPage extends StatefulWidget  {
  const LoginPage({
  Key? key,
  }) : super(key: key);
  @override
  State<LoginPage> createState() =>LoginPageState();
  }

  class LoginPageState extends State<LoginPage> {
    String selectedMenuItem = 'Category';
    bool obscureText = true;
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void togglePasswordVisibility() {
      setState(() {
        obscureText = !obscureText;
      });
    }
    final _formKey = GlobalKey<FormState>();

    @override
    void dispose() {
      nameController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    Future login() async {
      var url = "${api}login.php";
      var response = await http.post(Uri.parse(url), body: {
        "username": nameController.text,
        "password": passwordController.text,
      });
      var data = json.decode(response.body);
      print(data);
      if (data == "Success") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("username", nameController.text);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfile()),
        );
      } else {
        Fluttertoast.showToast(
            msg: "The Username and Password doesn't matches",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_LEFT,
            fontSize: 16,
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
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
      body: ListView(
        children: [
      Column(
          children: [
      Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
          children: [
      const Navigation(),
            const Divider(
              thickness: 1,
              height: 0.01, // Set the height of the divider line
              color: kPrimaryColor, // Set the color of the divider line
            ),
            Center(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  width: 380,
                  child: Card(
                    elevation: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Set the mainAxisSize to min
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 45,
                            fontFamily: 'DMSans Bold',
                          ),
                        ),
                        Container(
                          width: 320,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter email or Phone number',
                                    filled: true,
                                    fillColor: Colors.blueGrey[50],
                                    labelStyle: const TextStyle(fontSize: 12),
                                    contentPadding: const EdgeInsets.only(left: 30),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: kDarkgreyColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: kDarkgreyColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  controller: nameController,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter username';
                                    } else if (value.length < 2) {
                                      return 'at least enter 4 characters';
                                    } else if (value.length > 13) {
                                      return 'maximum character is 13';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  obscureText: obscureText,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    suffixIcon: InkWell(
                                      onTap: togglePasswordVisibility,
                                      child: Icon(
                                        obscureText
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.blueGrey[50],
                                    labelStyle: const TextStyle(fontSize: 12),
                                    contentPadding: const EdgeInsets.only(left: 30),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: kDarkgreyColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: kDarkgreyColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    } else if (value.length < 2) {
                                      return 'at least enter 6 characters';
                                    } else if (value.length > 13) {
                                      return 'maximum character is 13';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => forgot1()),
                                    );
                                  },
                                  child: Text(
                                    'Forgot Password?',textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ElevatedButton(
                                    child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        child: const Center(child: Text("Sign In"))),
                                    onPressed: (){
                                      if (_formKey.currentState!.validate()) {
                                        login();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(fontSize: 15,
                                color: Colors.black54,
                                fontFamily: 'DMSans Bold',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                                );
                              },
                              child: Text(
                                'Register',textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
        const BottomNav()
          ],),),
      ],
      )]));
  }
}




