import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';



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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: email,
                          decoration:
                          const InputDecoration(hintText: "User Email")),
                    ),
                    ElevatedButton(
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: otp,
                          decoration:
                          const InputDecoration(hintText: "Enter OTP")),
                    ),
                    ElevatedButton(
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
    );
  }
}