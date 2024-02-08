import 'dart:convert';

import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BillSummary extends StatefulWidget {


  @override
  State<BillSummary> createState() => _BillSummaryState();
}

class _BillSummaryState extends State<BillSummary> {
  double shippingCost = 0;
  String username = '';
  List dataa = [];



  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }
  @override
  void initState() {
    Future.wait([_loadUsername() ]).then((_) {
      // After both therapeautic and form data are fetched, proceed to group items
     print("usernamenidhiii:$username");
     fetchCartPrice(username);
    });
    super.initState();
  }

  void fetchCartPrice(String username) async {
    String url = '${api}fetch_cart_price.php';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {
          // If 'status' is 'success', assume there is a 'data' field
          var data = jsonData['data'];

          // Handle 'data' as needed
          setState(() {
            dataa = data;
          });
          print(dataa);
        } else {
          // Handle other cases or show an error message
          print('Failed to fetch cart price: ${jsonData['message']}');
        }
      } else {
        // Handle other response status codes if needed
        print('Failed to fetch cart price: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching cart price: $error');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Adjust the value for the desired border curvature
      ),
      child: Container(
        height: 280,
        padding: EdgeInsets.only(top: 30,right: 16,left: 16),
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     lightColor, // Start color
          //     kSecondaryColor, // End color (same color for a solid effect)
          //   ],
          // ),
          color: Colors.white,
          //border: Border.all(color: kPrimaryColor,width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Bill Summary',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'DMSans Bold',
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 5),
            Divider(thickness: 2,),
            SizedBox(height: 5),
            BillItem(label: 'Total Bill (MRP) ' ,value:'\₹${dataa[0]['total']}'),
            SizedBox(height: 5),
            BillItem(label: 'Total Discount ',value:'-0'),
            SizedBox(height: 5),
            BillItem(label: 'Shipping Fee ' ,value: '\₹50'),
            Divider(thickness: 2,),
            SizedBox(height: 5),
            BillItem(label: 'To Be Paid ',value:'\₹${dataa[0]['total']}'),
          ],
        ),
      ),
    );
  }
}

class BillItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  BillItem({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'DMSans Regular',
                fontWeight: isTotal?FontWeight.bold:FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'DMSans Regular',
                fontWeight: isTotal?FontWeight.bold:FontWeight.normal,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
//bill summary