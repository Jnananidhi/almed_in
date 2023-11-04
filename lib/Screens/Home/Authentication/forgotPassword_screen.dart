
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  String message = '';

  void _sendcode() async {
    final String email = emailController.text;

    final response = await http.post(
      Uri.parse('${api}forgotPassword.php'),
      body: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      // Handle the response from the backend (e.g., check for success or failure).
      // You may display a message to the user.
      setState(() {
        message = 'Password reset instructions sent to your email.';
      });
    } else {
      // Handle errors.
      setState(() {
        message = 'An error occurred. Please try again later.';

      });
    }
  }

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
                                'Forget Password',textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Image.asset('assets/mail_icon.png'),
                              const Text('''You'll get an email to the registered mail address\nopen the mail and find the verification code''',textAlign: TextAlign.center,),
                              const SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Enter Verification Code in ",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontFamily: 'DMSans Bold',color: Colors.black),),
                                    const SizedBox(height: 20),
                                    Text("0:00",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontFamily: 'DMSans Bold',color: Colors.black),),
                                  ],
                                ),
                              Center(
                                child: SizedBox(
                                width: 300,
                                height: 200,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter Code',
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
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly, // Allow only digits (numeric input)
                                  ],
                                ),
                              ),
                              ),
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(labelText: 'Email'),
                              ),
                              CustomButton(label: "Submit", onPressed: (){
                              _sendcode();
                              }),
                            ],
                          ),
                        )],
                    ))])),
    );
  }
}
