import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:number_paginator/number_paginator.dart';

import 'package:number_paginator/number_paginator.dart';

class AlphabeticPage extends StatefulWidget {
  const AlphabeticPage({Key? key}) : super(key: key);

  @override
  State<AlphabeticPage> createState() => _AlphabeticPageState();
}

class _AlphabeticPageState extends State<AlphabeticPage> {
  List productNames = [];
  String selectedLetter = 'A';
  int currentPage = 1; // Track the current page
  String totalProductCount = "";

  static const int itemsPerPage = 2; // Number of items per page

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
        print(productNames);
      });
    } else {
      print('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProductCount();
    fetchProducts(selectedLetter, currentPage);
  }

  void onPageChanged(int newPage) {
    fetchProducts(selectedLetter, newPage+1);
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
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
                        fetchProducts(letter, currentPage);
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
                child: ListView.builder(
                  itemCount: productNames.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(productNames[index]),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.width < 600
                ? 90 // Adjust the value for mobile view
                : 50,
            left: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
            right: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.25,
            child: Search_bar(),
          ),
          // Add the pagination widget at the bottom of the page
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child:NumberPaginator(
              onPageChange: onPageChanged, numberPages: (int.parse(totalProductCount) / itemsPerPage).ceil(),
            ),
          ),
        ],
      ),
    );
  }
}

