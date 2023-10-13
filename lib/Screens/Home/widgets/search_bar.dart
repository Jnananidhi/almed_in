import 'dart:convert';

import 'package:almed_in/Screens/Home/faq_screen.dart';
import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/Screens/Home/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'package:almed_in/utils/utils.dart';
import 'package:http/http.dart' as http;

class Search_bar extends StatefulWidget  {
  const Search_bar({
    Key? key,
  }) : super(key: key);



  @override
  State<Search_bar> createState() => _Search_barState();
}
class _Search_barState extends State<Search_bar> {
  List contact = [];
  final searchcontroller = TextEditingController();
  List<String> searchSuggestions = [];

  void searchContacts(String searchTerm) {
    // Clear the previous search suggestions
    searchSuggestions.clear();

    // If the search term is empty, clear suggestions
    if (searchTerm.isEmpty) {
      setState(() {});
      return;
    }

    // Split the search term into individual words
    List<String> searchWords = searchTerm.toLowerCase().split(" ");

    // Filter the contacts based on the search term
    for (var item in contact) {
      String name = item['Name'].toString().toLowerCase();

      // Check for matches with each individual word
      for (var word in searchWords) {
        if (name.contains(word)) {
          searchSuggestions.add(item['Name'].toString());
          break; // Break the loop if a match is found for this item
        }
      }
    }

    setState(() {
      // You can perform any UI updates here
    });
  }



  Future getAllcategory() async {
    var url = "${api}almed_company.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        contact = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    print(contact);
    print('hello');
    return contact;
  }

  @override
  void initState() {
    getAllcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        constraints: const BoxConstraints(
        maxWidth: kMaxWidth,
    ),
    child: Column(
          children: [
      Container(

      child: Align(
        alignment: Alignment.topCenter,
        child: TextField(
          controller: searchcontroller,
          onChanged: (searchTerm) {
            setState(() {
              searchContacts(searchTerm);
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00AFBB)),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
          ),
        ),
      ),
    ),

    if (searchSuggestions.isNotEmpty)
    Container(
        color: kgreyColor,
        constraints: const BoxConstraints(
        maxWidth: kMaxWidth,
          maxHeight: 200,
        ),
         // Set your desired fixed height

        child: SingleChildScrollView( // Wrap with a SingleChildScrollView
            child: Column(
                children: searchSuggestions.map((suggestion) {
                    return ListTile(
                    title: Text(suggestion),
                    onTap: () {
                        // You can perform an action when a suggestion is tapped
                        // For example, fill the search input with the suggestion
                        searchcontroller.text = suggestion;
                        // Perform your search action here
                    },
                    );
                }).toList(),
            ),
        ),
    )]));

  }
}