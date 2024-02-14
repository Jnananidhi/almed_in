import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/file_upload.dart';
import 'package:almed_in/constants.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../home_screen.dart';


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
  PlatformFile? _fileButton1;
  PlatformFile? _fileButton2;
  PlatformFile? _fileButton3;

  Future<void> _pickFileButton1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _fileButton1 = result.files.first;
      });
    }
  }

  Future<void> _pickFileButton2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _fileButton2 = result.files.first;
      });
    }
  }

  Future<void> _pickFileButton3() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _fileButton3 = result.files.first;
      });
    }
  }
  // void _handleSubmit() async {
  //   if (_fileButton1 != null || _fileButton2 != null || _fileButton3 != null) {
  //     await _uploadFiles();
  //   } else {
  //     // Handle case where no files are selected
  //     print('Please select at least one file.');
  //   }
  // }
  // Future<void> _uploadFiles() async {
  //   await _uploadFile(_fileButton1, 'file1');
  //   await _uploadFile(_fileButton2, 'file2');
  //   await _uploadFile(_fileButton3, 'file3');
  // }

  // Future<void> _uploadFile(PlatformFile? file, String fileKey) async {
  //   if (file != null) {
  //     var url1 = "${api}file_upload.php";
  //     var url = Uri.parse(url1);
  //
  //     var request = http.MultipartRequest('POST', url);
  //     request.files.add(http.MultipartFile.fromBytes(
  //       fileKey,
  //       file.bytes!,
  //       filename: file.name,
  //     ));
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       // File uploaded successfully
  //       print('File uploaded: ${file.name}');
  //     } else {
  //       // Handle error
  //       print('Failed to upload ${file.name}');
  //     }
  //   }
  // }
  Future<void> _uploadFiles() async {
    var url1 = "${api}file_upload.php";
    var url = Uri.parse(url1);

    var request = http.MultipartRequest('POST', url);

    // Add file from first button
    if (_fileButton1 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'file1',
        _fileButton1!.bytes!,
        filename: _fileButton1!.name,
      ));
    }

    // Add file from second button
    if (_fileButton2 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'file2',
        _fileButton2!.bytes!,
        filename: _fileButton2!.name,
      ));
    }
    if (_fileButton3 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'file3',
        _fileButton3!.bytes!,
        filename: _fileButton3!.name,
      ));
    }

    // Add other form data if needed
    request.fields['shop'] = shopController.text;
    request.fields['owner'] = ownerController.text;
    request.fields['GST'] = GSTController.text;
    request.fields['DL'] = DLController.text;
    request.fields['DL2'] = DL2Controller.text;
    request.fields['address'] = adressController.text;
    request.fields['city'] = cityController.text;
    request.fields['phone'] = phoneController.text;
    request.fields['email'] = emailController.text;
    request.fields['postcode'] = postcodeController.text;
    request.fields['password'] = passwordController.text;

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful upload
        print('Files uploaded successfully');
      } else {
        // Handle error
        print('Failed to upload files');
      }
    } catch (error) {
      // Handle exceptions or errors that occur during the HTTP request
      print('Error during file upload: $error');
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
              // elevation: 10,
              child: Container(
                decoration: const BoxDecoration(color: kWhiteColor),
                child:  Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Register Here",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'DMSans Bold',
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Please fill all the details correctly",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'DMSans Bold',
                            fontSize: 18,
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top:20.0,left: 8.0,right: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Shop name as in DL/ Hospital / Clinic name',
                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20,right: 15.0),                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Owner/ In charge/ Doctor Name',
                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20.0,left: 8.0,right: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'GST No',
                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20,right: 15.0),                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'KMC / DL No 1',

                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20,right: 15.0),                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'KMC / DL No 2',

                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20.0,left: 8.0,right: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Address as in DL',

                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20,right: 15.0),                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Town/City',

                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20,right: 15.0),                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Postcode/ZIP',

                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20.0,left: 8.0,right: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Phone',

                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20,right: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Email',

                                    filled: true,
                                    fillColor: kgreyColor,
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top:20,right: 15.0),                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: TextFormField(
                                  obscureText: obscureText,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
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
                                    labelStyle: TextStyle(fontSize: 16),
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
                                margin: const EdgeInsets.only(top: 20.0, left: 8.0, right: 15.0,bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child:
                                Column(
                                  children: [
                                    // Text("Upload GST File"),
                                    // Container(
                                    //   margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(15),
                                    //     color: kgreyColor,
                                    //   ),
                                    //   child: UploadFilePage(),
                                    // ),
                                    SizedBox(
                                      height: 40,
                                      child: CustomButton(
                                        onPressed: _pickFileButton1,
                                        label: 'Select File for DL 1',
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    _fileButton1 != null
                                        ? Text('Selected File 1: ${_fileButton1!.name}', style: TextStyle(color: Colors.green),)
                                        : Text('No file selected for DL 1',style: TextStyle(color: Colors.red)),
                                    SizedBox(height: 20),
                                    // ElevatedButton(
                                    //   onPressed: _pickFileButton1,
                                    //   child: Text('Pick File'),
                                    // ),
                                    // SizedBox(height: 20),
                                    // ElevatedButton(
                                    //   onPressed: _uploadFile,
                                    //   child: Text('Upload File'),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 20.0, left: 8.0, right: 15.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: Column(
                                  children: [
                                    // Text("Upload KMC/DL Document 1"),
                                    // Container(
                                    //   margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(15),
                                    //     color: kgreyColor,
                                    //   ),
                                    //   child: UploadFilePage(),
                                    // ),
                                    // ElevatedButton(
                                    //   onPressed: _pickFileButton2,
                                    //   child: Text('Pick File'),
                                    // ),
                                    SizedBox(
                                      height: 40,
                                      child: CustomButton(
                                        onPressed: _pickFileButton2,
                                        label: 'Select File for DL 2',
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    _fileButton2 != null
                                        ? Text('Selected File 2: ${_fileButton2!.name}',style: TextStyle(color: Colors.green))
                                        : Text('No file selected for DL 2',style: TextStyle(color: Colors.red)),
                                    SizedBox(height: 20),
                                  ],
                                ),),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 20.0, left: 8.0, right: 15.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: Column(
                                  children: [
                                    // Text("Upload KMC/DL Document 1"),
                                    // Container(
                                    //   margin: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(15),
                                    //     color: kgreyColor,
                                    //   ),
                                    //   child: UploadFilePage(),
                                    // ),
                                    // ElevatedButton(
                                    //   onPressed: _pickFileButton3,
                                    //   child: Text('Pick File'),
                                    // ),
                                    SizedBox(
                                      height: 40,
                                      child: CustomButton(
                                        onPressed: _pickFileButton3,
                                        label: 'Select File for GST',
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    _fileButton3 != null
                                        ? Text('Selected File 3: ${_fileButton3!.name}',style: TextStyle(color: Colors.green))
                                        : Text('No file selected for GST',style: TextStyle(color: Colors.red)),
                                    SizedBox(height: 20),
                                  ],
                                ),),
                            ),
                          ],
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ElevatedButton(
                              //   onPressed: _handleSubmit,
                              //   child: Text('Pick File'),
                              // ),
                              Container(
                                margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kgreyColor,
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 150,
                                  child: CustomButton(
                                    label: 'Submit',
                                    onPressed: (){
                                      if (_formKey.currentState!.validate()) {
                                        _uploadFiles();
                                        final snackBar = SnackBar(
                                          /// need to set following properties for best effect of awesome_snackbar_content
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: 'Successful!',
                                            message:
                                            'Thank you for joining us! Your registration is complete.',

                                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                            contentType: ContentType.success,
                                          ),
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => HomeScreen()),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],),
                  ),
                ),
              ),
            )));
  }
}
