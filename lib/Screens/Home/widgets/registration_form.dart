import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/file_upload.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 70),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        child: Container(
          decoration: const BoxDecoration(color: kWhiteColor),
          child:  Column(
            children: [
              Text(
                "Register Here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DMSans Bold',
                  fontSize: 45,
                ),
              ),
              Text(
                "Please fill all the details correctly",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'DMSans Bold',
                  fontSize: 20,
                ),
              ),

              Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top:10.0,left: 4.0,right: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kgreyColor,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Shop name as in DL/ Hospital / Clinic name',

                            filled: true,
                            fillColor: kgreyColor,
                            labelStyle: TextStyle(fontSize: 12),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkgreyColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkgreyColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top:10,right: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kgreyColor,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Owner/ In charge/ Doctor Name',
                            filled: true,
                            fillColor: kgreyColor,
                            labelStyle: TextStyle(fontSize: 12),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkgreyColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkgreyColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:10.0,left: 4.0,right: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'GST No',
                          filled: true,
                          fillColor: kgreyColor,
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:10,right: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'KMC / DL No 1',
                          
                          filled: true,
                          fillColor: kgreyColor,
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:10,right: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'KMC / DL No 2',
                          
                          filled: true,
                          fillColor: kgreyColor,
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:10.0,left: 4.0,right: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Address as in DL',
                          
                          filled: true,
                          fillColor: kgreyColor,
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:10,right: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Town/City',
                          
                          filled: true,
                          fillColor: kgreyColor,
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:10,right: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Postcode/ZIP',
                          
                          filled: true,
                          fillColor: kgreyColor,
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:8.0,left: 4.0,right: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          
                          filled: true,
                          fillColor: kgreyColor,
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:10,right: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          
                          filled: true,
                          fillColor: kgreyColor,
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:10,right: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: TextField(
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
                          fillColor: kgreyColor,
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kDarkgreyColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0,bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child:
                    Column(
                      children: [
                        Text("Upload GST File"),
                        Container(
                          margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kgreyColor,
                          ),
                          child: UploadFilePage(),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: Column(
                      children: [
                        Text("Upload KMC/DL Document 1"),
                        Container(
                          margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kgreyColor,
                          ),
                          child: UploadFilePage(),
                        ),
                      ],
                    ),),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor,
                      ),
                      child: Column(
                        children: [
                          Text("Upload KMC/DL Document 1"),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: kgreyColor,
                            ),
                            child: UploadFilePage(),
                          ),
                        ],
                      ),),
                  ),
                ],
              ),
            Center(
              child: Row(
                  children: [
               Container(
              margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0,bottom: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kgreyColor,
              ),
              child: CustomButton(label: 'Submit', onPressed: () {  }))
             ],
          ),
            ),
        ],),
      ),
    ));
  }
}
