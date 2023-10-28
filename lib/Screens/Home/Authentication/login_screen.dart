
import 'package:almed_in/Screens/Home/Authentication/forgot1.dart';
import 'package:almed_in/Screens/Home/Authentication/register_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';

var email_login;
var password_login;
var name_login = '123';

class LoginPage extends StatelessWidget {

  const LoginPage(
      {
        super.key}
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
        body:  Column(
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
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal:100),
                      child: Body(),
                    ),
                    BottomNav(),
                    // Add more widgets here as needed
                  ],
                ),
              ),
            ),

          ],
        )
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? validateEmail(String value) {
    // Email validation regular expression
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

    if (value.isEmpty) {
      return 'Please enter an email address';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment.center,
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
                child: _formLogin(),
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
    );

  }

  Widget _formLogin() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Enter email',
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
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: obscureText,
          controller: passwordController,
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
              validateEmail(emailController.text);
                  Login(emailController.text, passwordController.text, context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => UserProfile()),
              // );
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
    );
  }
}

Future<void> Login(
    String emailtxt, String password, BuildContext context) async {
  var response = await http.post(Uri.parse('${api}Userlogin.php'),
      body: {'email': emailtxt, 'password': password});
  print(response);
  var login_data = await jsonDecode(response.body);
  if (emailtxt != Null && password != Null) {
    final prefs = await SharedPreferences.getInstance();

    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const Home_Page_Screen()),
    //   );

    if (login_data.toString() == "Success") {
      prefs.setString('customer', name_login);
      // customer_name = prefs.getString('customer');
      prefs.setString('Login', emailtxt);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      print('not exist enter');
      _onAlertButtonPressed1(context);
    }
  }
}

_onAlertButtonPressed1(context) {
  AlertDialog alert = AlertDialog(
    title: Text('Account Not Exists'),
    content: Text("Please Sign up first"),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



