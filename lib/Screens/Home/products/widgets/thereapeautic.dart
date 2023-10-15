import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../constants.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DatabaseDataCard extends StatelessWidget {
  Future<List<Map<String, dynamic>>?> fetchDataFromDatabase() async {
    try {
      var url = "${api}almed_company.php";
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load data from the database');
      }
    } catch (e) {
      print('Error: $e');
      return null; // Return null in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: fetchDataFromDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator
        } else if (snapshot.hasError || snapshot.data == null) {
          return Text('Error: Failed to load data from the database');
        } else if (snapshot.hasData) {
          final List<Map<String, dynamic>> databaseData = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Display four items in a row
            ),
            itemCount: databaseData.length,
            itemBuilder: (BuildContext context, int index) {
              return DatabaseDataItem(
                data: databaseData[index]['Company'], // Display the 'name' field
              );

            },
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }
}


class DatabaseDataItem extends StatefulWidget {
  final String data;

  DatabaseDataItem({required this.data});

  @override
  _DatabaseDataItemState createState() => _DatabaseDataItemState();
}

class _DatabaseDataItemState extends State<DatabaseDataItem> {
  bool isHovered = false;


  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 1),
          boxShadow: isHovered
              ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ]
              : [], // Apply shadow on hover
        ),
        child: Stack(
            fit: StackFit.passthrough,
            children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),

          ],
        ),

        isHovered
            ? Container(
          color: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                color: kSecondaryColor,
                height: 40,
                onPressed: () {},
                child: const Text(
                  "View",
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
            ],
          ),
        ) : Container(),
    ])));
  }
}
