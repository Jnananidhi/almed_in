import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../widgets/menu.dart';



class forgot1 extends StatefulWidget {
  const forgot1({Key? key}) : super(key: key);

  @override
  State<forgot1> createState() => _forgot1State();
}

class _forgot1State extends State<forgot1> {
  TextEditingController email = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children:[
            Navigation(),

            Expanded(child: Container(
            width: 500,
              child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
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
                    Image.asset('mail_icon.png'),
                    const Text('''You'll get an email to the registered mail address\nopen the mail and find the verification code''',textAlign: TextAlign.center,),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                                controller: email,
                                decoration:
                                const InputDecoration(hintText: "User Email")),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () async {
                                myauth.setConfig(
                                    appEmail: "mjnananidhi35@gmail.com",
                                    appName: "Email OTP",
                                    userEmail: email.text,
                                    otpLength: 6,
                                    otpType: OTPType.digitsOnly
                                );
                                if (await myauth.sendOTP() == true) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("OTP has been sent"),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Oops, OTP send failed"),
                                  ));
                                }
                              },
                              child: const Text("Send OTP")),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                                controller: otp,
                                decoration:
                                const InputDecoration(hintText: "Enter OTP")),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () async {
                                if (await myauth.verifyOTP(otp: otp.text) == true) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("OTP is verified"),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Invalid OTP"),
                                  ));
                                }
                              },
                              child: const Text("Verify")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}