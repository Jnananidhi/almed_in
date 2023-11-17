import 'dart:convert';

import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bottomnav.dart';
import 'menu.dart';

// class LetterRow extends StatefulWidget {
//   @override
//   State<LetterRow> createState() => _LetterRowState();
// }
//
// class _LetterRowState extends State<LetterRow> {
//   List contact = [];
//   List strength = [];
//   List therapeautic = [];
//   List form = [];
//   List product = [];
//   List company = [];
//   List allItems = [];
//
//
//
//   Future getAllcategory() async {
//     var url = "${api}product.php";
//     var response = await http.post(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         contact = jsonData;
//       });
//     }
//     else {
//       print('Failed to load data. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//     print(contact);
//     print('hello');
//     return contact;
//   }
//   Future getstrength() async {
//     var url = "${api}STRENGTH.php";
//     var response = await http.post(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         strength = jsonData;
//       });
//     }
//     else {
//       print('Failed to load data. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//
//     return strength;
//   }
//   Future gettherapeautic() async {
//     var url = "${api}therapeautic.php";
//     var response = await http.post(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         therapeautic = jsonData;
//       });
//     }
//     else {
//       print('Failed to load data. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//
//     return therapeautic;
//   }
//   Future getform() async {
//     var url = "${api}FORM.php";
//     var response = await http.post(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         form = jsonData;
//       });
//     }
//     else {
//       print('Failed to load data. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//
//     return form;
//   }
//
//   Future getproduct_name() async {
//     var url = "${api}product_name.php";
//     var response = await http.post(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         product = jsonData;
//       });
//     }
//     else {
//       print('Failed to load data. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//
//     return product;
//   }
//
//   Future getcompany() async {
//     var url = "${api}product_name.php";
//     var response = await http.post(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         company = jsonData;
//       });
//     }
//     else {
//       print('Failed to load data. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//
//     return company;
//   }
//
//   @override
//   void initState() {
//     getAllcategory();
//     getstrength();
//     gettherapeautic();
//     getform();
//     getproduct_name();
//     getcompany();
//     super.initState();
//     allItems.addAll(contact);
//     allItems.addAll(strength);
//     allItems.addAll(therapeautic);
//     allItems.addAll(form);
//     allItems.addAll(product);
//     allItems.addAll(company);
//
//     print(allItems);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Alphabets'),
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//             width: kMaxWidth,
//             child: Row(
//               children: [
//                 for (var letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(''))
//                   LetterWidget(letter: letter),
//                 LetterWidget(letter: 'All'), // Add 'All' at the end
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LetterWidget extends StatelessWidget {
//   final String letter;
//
//   const LetterWidget({required this.letter});
//
//   void handleTap(BuildContext context, String letter) {
//     // Handle letter click, you can put your logic here
//     print('Clicked on letter: $letter');
//     // You can perform actions based on the selected letter
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GestureDetector(
//         onTap: () => handleTap(context, letter), // Handling the tap
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: EdgeInsets.all(8),
//           child: Text(
//             letter,
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class LetterRow extends StatefulWidget {
//   @override
//   State<LetterRow> createState() => _LetterRowState();
// }
//
// class _LetterRowState extends State<LetterRow> {
//   final List<String> items = [
//     'Apple', 'Banana', 'Cherry', 'Grapes', 'Kiwi', 'Lemon',
//     'Mango', 'Orange', 'Papaya', 'Strawberry', 'Watermelon'
//   ];
//
//   late List<bool> isLetterEnabled;
//   List<String> itemsToShow = [];
//
//   @override
//   void initState() {
//     super.initState();
//     isLetterEnabled = List.generate(26, (index) {
//       String letter = String.fromCharCode('A'.codeUnitAt(0) + index);
//       return items.any((item) => item.startsWith(letter));
//     });
//     itemsToShow = items;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Alphabetic Items Display'),
//         ),
//         body: Column(
//           children: [
//             // Button for All
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   itemsToShow = items;
//                 });
//               },
//               child: Text('All'),
//             ),
//             // List of letters as buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(26, (index) {
//                 return ElevatedButton(
//                   onPressed: isLetterEnabled[index]
//                       ? () {
//                     String letter = String.fromCharCode('A'.codeUnitAt(0) + index);
//                     // Filter items based on the selected letter
//                     itemsToShow = items.where((item) => item.startsWith(letter)).toList();
//                     setState(() {
//                       // Update itemsToShow to display the filtered items
//                       itemsToShow = itemsToShow;
//                     });
//                   }
//                       : null,
//                   child: Text(String.fromCharCode('A'.codeUnitAt(0) + index)),
//                 );
//               }),
//             ),
//             SizedBox(height: 20),
//             // Display items below letter buttons
//             Expanded(
//               child: _buildSectionedItems(itemsToShow),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Function to build sectioned items by alphabet
//   Widget _buildSectionedItems(List<String> items) {
//     Map<String, List<String>> groupedItems = {};
//
//     // Group items by starting letter
//     for (var item in items) {
//       String key = item.substring(0, 1).toUpperCase();
//       groupedItems[key] = groupedItems[key] ?? [];
//       groupedItems[key]!.add(item);
//     }
//
//     return ListView.builder(
//       itemCount: groupedItems.length,
//       itemBuilder: (context, index) {
//         String key = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[index];
//         List<String>? sectionItems = groupedItems[key];
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (sectionItems != null && sectionItems.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   key,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             if (sectionItems != null && sectionItems.isNotEmpty)
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: sectionItems.length,
//                 itemBuilder: (context, idx) {
//                   return ListTile(
//                     title: Text(sectionItems[idx]),
//                   );
//                 },
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
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
    print('item::');
    print(items);
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

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
                    width: 50,
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
      ),
    );
  }

  // Function to build sectioned items by alphabet
  Widget _buildSectionedItems() {
    return ListView.builder(
      itemCount: 26,
      itemBuilder: (context, index) {
        String key = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[index];
        List<String>? sectionItems = groupedItems[key];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedLetter.isNotEmpty && key == selectedLetter)
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
    );
  }
}
