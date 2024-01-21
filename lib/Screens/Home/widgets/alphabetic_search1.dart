import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:number_paginator/number_paginator.dart';


class AlphabeticPage extends StatefulWidget {
  const AlphabeticPage({super.key});

  @override
  State<AlphabeticPage> createState() => _AlphabeticPageState();
}

class _AlphabeticPageState extends State<AlphabeticPage> {
  int currentPage = 0;
  int itemsPerPage = 20;
  String totalProductCount = "";
  List productNames = [];
  String selectedLetter = 'A';

  Future<void> fetchProductCountAndProducts() async {
    Future.wait([fetchProductCount() ]).then((_) {
      // After both therapeautic and form data are fetched, proceed to group items
      fetchProducts(selectedLetter);
    });
  }

  Future<void> fetchProductCount() async {
    final url = Uri.parse('${api}fetchalphabeticCount.php');
    final response = await http.post(url, body: {'letter': selectedLetter},);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var count = jsonData['TotalCount'];

      setState(() {
        totalProductCount = count.toString();
      });
    }
  }// Variable to track the selected letter

  Future<void> fetchProducts(String letter) async {
    int startIndex = currentPage * itemsPerPage;
    final response = await http.post(
      Uri.parse('${api}fetchAlphabetic.php?start=${startIndex.toString()}&limit=${itemsPerPage.toString()}'), // Replace with your PHP script URL
      body: {'letter': letter},
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        productNames = jsonData;
        selectedLetter = letter; // Update the selected letter
        print(productNames);
      });
    } else {
      print('Failed to load products');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchProductCountAndProducts();
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 3;
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Navigation(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(26, (index) {
                final letter = String.fromCharCode('A'.codeUnitAt(0) + index);
                return SizedBox(
                  height: 40,
                  width: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      fetchProducts(letter);
                      print(letter);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        letter == selectedLetter
                            ? kSecondaryColor // Change the color for the selected letter
                            : Colors.white,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: _size.width >= 370 ? 15 : 10,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Expanded(
              child:  ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: productNames.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                    children: [
                      for (var i = index * crossAxisCount ;i<index * crossAxisCount + crossAxisCount; i++)
                        if (i < productNames.length)
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter, // Align each card to the top
                              child: Padding(
                                  padding:EdgeInsets.only(bottom: 7,left: 7),
                                  child:DatabaseDataItem(
                                    title:productNames[index], press: () {  },
                                  )
                              ),
                            ),
                          ),

                    ],
                  );
                },
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.22),
              child: NumberPaginator(
                numberPages: (int.parse(totalProductCount) / itemsPerPage).ceil(),
                onPageChange: (index) {
                  setState(() {
                    currentPage = index;
                    fetchProducts(selectedLetter); // Fetch products when changing page
                  });
                },
              ),
            ),
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
      ],
      ),
    );
  }
}
class DatabaseDataItem extends StatefulWidget {
  final String title;
  final Function() press;

  DatabaseDataItem({required this.title, required this.press});

  @override
  _DatabaseDataItemState createState() => _DatabaseDataItemState();
}

class _DatabaseDataItemState extends State<DatabaseDataItem> {

  bool isHovered = false;


  @override

  Widget build(BuildContext context) {

    Size _size = MediaQuery.of(context).size;
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
        child:  AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: TextStyle(
            fontSize: isHovered ? 20.0 : 16.0,
            fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
            color: isHovered ? kPrimaryColor : Colors.black,),

          child: InkWell(
            onTap: widget.press,
            child: Container(
              width: _size.width <= 770
                  ? _size.width/2
                  : _size.width >= 975
                  ? 300
                  : 200,
              height: 100,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: isHovered ?   kgreyColor:kWhiteColor, // Change color on hover
                boxShadow: [if (isHovered) kDefaultShadow],
                border: Border.all(
                  color: kgreyColor, // Set the border color to grey
                  width: 3.0,       // Set the border width
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Add any widgets you want to display within the card, e.g., Text
                  Text(widget.title,textAlign: TextAlign.center,style: TextStyle(fontFamily: 'DMSans Regular'),),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('ADD',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'DMSans Regular'),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}