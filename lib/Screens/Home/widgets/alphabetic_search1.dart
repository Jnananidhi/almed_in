import 'package:almed_in/Screens/Home/test.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar1.dart';
import 'package:almed_in/constants.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:number_paginator/number_paginator.dart';

import '../products/products_screen.dart';

class AlphabeticPage extends StatefulWidget {
  const AlphabeticPage({Key? key}) : super(key: key);

  @override
  State<AlphabeticPage> createState() => _AlphabeticPageState();
}

class _AlphabeticPageState extends State<AlphabeticPage> {
  List productNames = [];
  String selectedLetter = 'A';
  int currentPage = 1; // Track the current page
  String totalProductCount = " ";

  static const int itemsPerPage = 10;

  void fetchProductCount(String letter) async {
    final url = Uri.parse('${api}fetchalphabeticCount.php');
    final response = await http.post(url, body: {'letter': letter});

    if (response.statusCode == 200) {
      print('Fetched count for $letter: ${response.body}');
      var jsonData = json.decode(response.body);
      var count = jsonData['TotalCount'];

      setState(() {
        totalProductCount = count.toString();
      });
      if(count == "0")
      {
        Navigator.pushNamed(context, "/test");
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'No Medicine yet..',
            message:
            'There was no medicines from Alphabet $selectedLetter',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } else {
      print('Failed to fetch count for $letter. Status code: ${response.statusCode}');
    }
  }

  void fetchProducts(String letter, int page) async {

    final response = await http.post(
      Uri.parse('${api}fetchAlphabetic.php'),
      body: {'letter': letter, 'page': '$page', 'perPage': '$itemsPerPage'},
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        productNames = jsonData;
        selectedLetter = letter;
      });
    } else {
      print('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
     fetchProductCount(selectedLetter);
     fetchProducts(selectedLetter, currentPage);
  }

  void onPageChanged(int newPage) {
    fetchProducts(selectedLetter, newPage + 1);
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children:<Widget> [
              Navigation(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

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
                                setState(() {
                                  selectedLetter = letter;
                                  print('Fetching count for letter: $letter');
                                  fetchProductCount(letter);
                                  fetchProducts(letter, currentPage);
                                  print(letter);
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  letter == selectedLetter
                                      ? kSecondaryColor // Change the color for the selected letter
                                      : kgreyColor,
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
                      Container(
                        height: 400,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: productNames.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(productNames[index]),
                                    onTap: () {
                                      print("AAAAA");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductScreenFromSearch(selectedProductName: productNames[index]),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 400,
                          child: NumberPaginator(
                            onPageChange: onPageChanged,
                            //numberPages: 334,
                            numberPages: (int.parse(totalProductCount) / itemsPerPage).ceil(),
                          ),
                        ),
                      ),
                      BottomNav(),
                    ],

                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.width < 600
                ? 90 // Adjust the value for mobile view
                : 20,
            left: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
            right: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.25,
            child: Search_bar1(),
          ),
          // Add the pagination widget at the bottom of the page

        ],
      ),
    );
  }
}


