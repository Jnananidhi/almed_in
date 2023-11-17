import 'dart:convert';

import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bottomnav.dart';
import 'menu.dart';

class LetterRow extends StatefulWidget {
  @override
  State<LetterRow> createState() => _LetterRowState();
}

class _LetterRowState extends State<LetterRow> {
  int activeButtonIndex = -1; // Default value to indicate no active button
  List therapeautic = [];
  List form = [];
  List company = [];
  List<String> items = [];
  Future gettherapeautic() async {
    var url = "${api}therapeautic.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        therapeautic = jsonData;
        items = therapeautic.map<String>((item) => item['therapeautic']).toList();
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return items;
  }
  Future getform() async {
    var url = "${api}FORM.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        form = jsonData;
        items.addAll(form.map<String>((item) => item['FORM']).toList());
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return form;
  }
  Future getcompany() async {
    var url = "${api}product_name.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        company = jsonData;
        items.addAll(company.map<String>((item) => item['Company']).toList());
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return company;
  }



  late List<bool> isLetterEnabled;
  late Map<String, List<String>> groupedItems;
  String selectedLetter = '';

  @override
  void initState() {
    super.initState();
    isLetterEnabled = List.generate(26, (_) => false);
    groupedItems = {};
    Future.wait([gettherapeautic(), getform(),getcompany()]).then((_) {
      // After both therapeautic and form data are fetched, proceed to group items
      _groupItems();
    });

  }

  void _groupItems() {
    groupedItems = {};
    for (var item in items) {
      String key = item.substring(0, 1).toUpperCase();
      groupedItems[key] = groupedItems[key] ?? [];
      groupedItems[key]!.add(item);
    }
    _setLetterAvailability();
  }

  void _setLetterAvailability() {
    isLetterEnabled = List.generate(26, (index) {
      String letter = String.fromCharCode('A'.codeUnitAt(0) + index);
      return groupedItems.containsKey(letter);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return  Scaffold(
        body: Stack(
            children:[ Column(
              children: [
                Navigation(),
                // List of letters as buttons
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Generate 26 buttons
                    ...List.generate(26, (index) {
                      final isEnabled = isLetterEnabled[index];
                      final letter = String.fromCharCode('A'.codeUnitAt(0) + index);
                      return IgnorePointer(
                        ignoring: !isEnabled,
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: ElevatedButton(
                            onPressed: isEnabled
                                ? () {
                              setState(() {
                                selectedLetter = letter;
                                activeButtonIndex = index; // Set active button index
                              });
                            }
                                : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                activeButtonIndex == index ? Colors.green : Colors.white, // Change colors based on the active state
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero, // Set border radius to zero
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(0),
                            ),
                            child: Text(letter, style: TextStyle(fontSize: _size.width >= 370 ? 15 : 10,color: !isEnabled ? Colors.grey : Colors.black,)),
                          ),
                        ),
                      );
                    }),
                    // Adjust spacing between buttons
                    SizedBox(
                      height: 40,
                      width: 70,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedLetter = '';
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(kSecondaryColor), // Change to the desired color
                        ),

                        child: Text('All',style: TextStyle(fontSize: _size.width >= 370 ? 15 : 10)),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 20),
                // Display items below letter buttons
                Expanded(
                  child: _buildSectionedItems(),
                ),
                BottomNav(),
              ],
            ),
              Positioned(
                top: MediaQuery.of(context).size.width < 600
                    ? 90// Adjust the value for mobile view
                    :50,
                left: MediaQuery.of(context).size.width < 600
                    ? 0 // Adjust the value for mobile view
                    : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
                right: MediaQuery.of(context).size.width < 600
                    ? 0 // Adjust the value for mobile view
                    : MediaQuery.of(context).size.width * 0.25,
                child: Search_bar(),
              ),

            ]),
      );
  }

  // Function to build sectioned items by alphabet
  Widget _buildSectionedItems() {
    return Container(
      width: kMaxWidth,
      child: ListView.builder(
        itemCount: 26,
        itemBuilder: (context, index) {
          String key = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[index];
          List<String>? sectionItems = groupedItems[key];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((selectedLetter.isNotEmpty && key == selectedLetter) || selectedLetter.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    key,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if ((selectedLetter.isNotEmpty && key == selectedLetter) || selectedLetter.isEmpty)
                if (sectionItems != null && sectionItems.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sectionItems.length,
                    itemBuilder: (context, idx) {
                      return ListTile(
                        title: Text(sectionItems[idx]),
                      );
                    },
                  ),
            ],
          );
        },
      ),
    );
  }
}
