import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';
import 'package:http/http.dart' as http;

import '../products/product_listing.dart';
import 'package:universal_html/html.dart' as html;

class Search_bar extends StatefulWidget  {
  const Search_bar({
    Key? key,
  }) : super(key: key);



  @override
  State<Search_bar> createState() => _Search_barState();
}
class _Search_barState extends State<Search_bar> {
  List contact = [];
  List strength = [];
  List therapeautic = [];
  List form = [];
  List product = [];
  List company = [];
  final searchcontroller = TextEditingController();
  List<String> searchSuggestions = [];

  void clearSearchSuggestions() {
    searchSuggestions.clear();
    searchcontroller.clear(); // Clear the text in the search box
    setState(() {});
  }

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
      String name = item['pname'].toString().toLowerCase();

      // Check for matches with each individual word
      for (var word in searchWords) {
        if (name.contains(word)) {
          searchSuggestions.add(item['pname'].toString());
          break; // Break the loop if a match is found for this item
        }
      }
    }

    // Filter the 'strength' list based on the search term
    for (var item in strength) {
      String name = item['STRENGTH'].toString().toLowerCase();

      // Check for matches with each individual word
      for (var word in searchWords) {
        if (name.contains(word)) {
          searchSuggestions.add(item['STRENGTH'].toString());
          break; // Break the loop if a match is found for this item
        }
      }
    }

    // Filter the 'strength' list based on the search term
    for (var item in therapeautic) {
      String name = item['therapeautic'].toString().toLowerCase();

      // Check for matches with each individual word
      for (var word in searchWords) {
        if (name.contains(word)) {
          searchSuggestions.add(item['therapeautic'].toString());
          break; // Break the loop if a match is found for this item
        }
      }
    }

    // Filter the 'strength' list based on the search term
    for (var item in form) {
      String name = item['FORM'].toString().toLowerCase();

      // Check for matches with each individual word
      for (var word in searchWords) {
        if (name.contains(word)) {
          searchSuggestions.add(item['FORM'].toString());
          break; // Break the loop if a match is found for this item
        }
      }
    }
    for (var item in product) {
      String name = item['Name'].toString().toLowerCase();

      // Check for matches with each individual word
      for (var word in searchWords) {
        if (name.contains(word)) {
          searchSuggestions.add(item['Name'].toString());
          break; // Break the loop if a match is found for this item
        }
      }
    }
    for (var item in company) {
      String name = item['Company'].toString().toLowerCase();

      // Check for matches with each individual word
      for (var word in searchWords) {
        if (name.contains(word)) {
          searchSuggestions.add(item['Company'].toString());
          break; // Break the loop if a match is found for this item
        }
      }
    }

    setState(() {
      // You can perform any UI updates here
    });
  }



  Future getAllcategory() async {
    var url = "${api}product.php";
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
  Future getstrength() async {
    var url = "${api}STRENGTH.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        strength = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return strength;
  }
  Future gettherapeautic() async {
    var url = "${api}therapeautic.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        therapeautic = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return therapeautic;
  }
  Future getform() async {
    var url = "${api}FORM.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        form = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return form;
  }

  Future getproduct_name() async {
    var url = "${api}product_name.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        product = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return product;
  }

  Future getcompany() async {
    var url = "${api}product_name.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        company = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return company;
  }

  @override
  void initState() {
    getAllcategory();
    getstrength();
    gettherapeautic();
    getform();
    getproduct_name();
    getcompany();
    html.window.onClick.listen((event) {
      final clickedElement = event.target;

      // Check if the clicked element is not a child of the search box.
      if (clickedElement != searchcontroller) {
        clearSearchSuggestions();
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
        constraints: const BoxConstraints(
        maxWidth: kMaxWidth/1.5,
    ),
    child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
                border: Border.all(
                  color: Color(0xFF00AFBB),
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: TextField(
                  controller: searchcontroller,
                  onSubmitted: (searchTerm) {
                    // Perform navigation to the product screen with the search term
                    if (searchTerm.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductListScreen(selectedProductName: searchTerm),
                        ),
                      );
                    }
                  },
                  onChanged: (searchTerm) {
                    setState(() {
                      searchContacts(searchTerm);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search Content Here..",
                    border: InputBorder.none,
                    // Remove the default border
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: InkWell(

                      child:ElevatedButton(
                        child: Container(
                            width:  MediaQuery.of(context).size.width < 600
                                ?  kMaxWidth/25.5// Adjust the value for mobile view
                                :  kMaxWidth/15.5,
                            child: const Center(child: Text("Search"))),
                        onPressed: (){
                          // Perform navigation to the product screen with the search term
                          String searchTerm = searchcontroller.text;
                          if (searchTerm.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductListScreen(selectedProductName: searchTerm),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: kWhiteColor, backgroundColor: Color(0xFF00AFBB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

    if (searchSuggestions.isNotEmpty)
    Container(
       width: kMaxWidth/1.5,
      decoration: BoxDecoration(
        color: kgreyColor,
        borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
        border: Border.all(
          color: Color(0xFF00AFBB),
        ),
      ),
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
                        String selectedProductName = suggestion;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ProductListScreen(selectedProductName: selectedProductName),),
                        );
                    },
                    );
                }).toList(),
            ),
        ),
    )]));

  }
}