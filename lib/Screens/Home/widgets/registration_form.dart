import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/file_upload.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../Authentication/login_screen.dart';
import '../about_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../products/products_screen.dart';
import 'menu.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool obscureText = true;
  String selectedMenuItem = 'Category';
  TextEditingController shopController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController GSTController = TextEditingController();
  TextEditingController DLController = TextEditingController();
  TextEditingController DL2Controller = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }


  Future login() async {
    var url = Uri.parse("$api/register.php");

    try {
      var response = await http.post(url, body: {
        "shop": shopController.text,
        "owner": ownerController.text,
        "GST": GSTController.text,
        "DL": DLController.text,
        "DL2": DL2Controller.text,
        "address": adressController.text,
        "city": cityController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "postcode": postcodeController.text,
        "password": passwordController.text,
      });

      if (response.statusCode == 200) {
        // Handle successful login - parse response data if needed
        var responseData = response.body;
        Fluttertoast.showToast(
            msg: "Registered Sucessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity:ToastGravity.CENTER,
            fontSize: 16,
            backgroundColor: Colors.black,
            textColor: Colors.white);

      } else {
        // Handle errors or unsuccessful login
        print("Login failed with status code: ${response.statusCode}");
        // Handle other status codes or errors
      }
    } catch (error) {
      // Handle exceptions or errors that occur during the HTTP request
      print("Error during login: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 70),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 10,
              child: Container(
                decoration: const BoxDecoration(color: kWhiteColor),
                child:  Form(
                  key: _formKey,
                  child: Column(
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
                              child: TextFormField(
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
                                controller: shopController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Shop/Hospital/Clinic Name';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: ownerController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Owner/In charge/Doctor Name';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: GSTController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter GST No';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: DLController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter KMC/Dl No 1';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: DL2Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter KMC/DL No 2';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: adressController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Adress';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: cityController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Town/City';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: postcodeController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Post Code';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: phoneController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Mobile Number';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Email';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
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
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: kgreyColor,
                              ),
                              child: CustomButton(
                                label: 'Submit',
                                onPressed: (){
                                  if (_formKey.currentState!.validate()) {
                                    login();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],),
                ),
              ),
            )));
  }
}
