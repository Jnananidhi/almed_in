import 'dart:async';
import 'dart:convert';
import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
class Search_bar1 extends StatefulWidget {
  const Search_bar1({super.key});

  @override
  State<Search_bar1> createState() => _Search_bar1State();
}

class _Search_bar1State extends State<Search_bar1> {
  final searchController = TextEditingController();
  List<String> searchSuggestions = [];
  List<String> searcheditem = [];//items name comletely fetched from suggestins and onclick
  final _debouncer = Debouncer(milliseconds: 500); // Adjust the duration as needed

  // Function to make API call and update searchSuggestions
  Future<void> fetchSuggestions(String searchTerm) async {
    if (searchTerm.isEmpty) {
      setState(() {
        searchSuggestions = []; // Clear suggestions when the search term is empty
      });
      return;
    }
    var url = "${api}getProductsFromSearch.php";
    var response = await http.post(Uri.parse(url), body: {
      "searchTerm": searchTerm,
    });

    if (response.statusCode == 200) {
      // If the API call is successful
      var data = json.decode(response.body);
      print(data);

      if (data is List) {
        List<String> apiResponse = data.map((product) => product["name"].toString()).toList();

        // Update the state with the new suggestions
        setState(() {
          searchSuggestions = apiResponse;
        });
      } else {
        print("Error: API response is not a List");
      }
    } else {
      // Handle errors here, e.g., show an error message
      print("Error: ${response.statusCode}");
    }
  }
//productss list

  Future<void> searchitem(String searchTerm) async {
    if (searchTerm.isEmpty) {
      setState(() {
        searcheditem = []; // Clear suggestions when the search term is empty
      });
      return;
    }
    var url = "${api}getProductsFromSearch.php";
    var response = await http.post(Uri.parse(url), body: {
      "searchTerm": searchTerm,
    });

    if (response.statusCode == 200) {
      // If the API call is successful
      var data = json.decode(response.body);
      print(data);

      if (data is List) {
        List<String> apiResponse = data.map((product) => product["name"].toString()).toList();

        // Update the state with the new suggestions
        setState(() {
          searcheditem = apiResponse;
        });
      } else {
        print("Error: API response is not a List");
      }
    } else {
      // Handle errors here, e.g., show an error message
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: kMaxWidth / 1.5,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Color(0xFF00AFBB),
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: TextField(
                controller: searchController,
                onSubmitted: (searchTerm) {
                  if (searchTerm.isNotEmpty) {
                    print("sunad$searchTerm");
                   
                    searchitem(searchTerm).then((value) =>  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ProductScreen(selectedProductName: searchTerm),
                      ),
                    ));
                  }
                },
                onChanged: (searchTerm) {
                  // Debounce the API call
                  _debouncer.run(() {
                    fetchSuggestions(searchTerm);
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search Medicines Here..",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: InkWell(
                    child: ElevatedButton(
                      child: Container(
                        width: MediaQuery.of(context).size.width < 600
                            ? kMaxWidth / 25.5
                            : kMaxWidth / 15.5,
                        child: const Center(child: Text("Search")),
                      ),
                      onPressed: () {
                        String searchTerm = searchController.text;
                        if (searchTerm.isNotEmpty) {
                          print("manu$searchTerm");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProductScreen(selectedProductName: searchTerm),
                          //   ),
                          // );
                          searchitem(searchTerm).then((value) =>  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>ProductScreen(selectedProductName: searchTerm),
                            ),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: kWhiteColor,
                        backgroundColor: kPrimaryColor,
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
              width: kMaxWidth / 1.5,
              decoration: BoxDecoration(
                color: kgreyColor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: kPrimaryColor,
                ),
              ),
              constraints: const BoxConstraints(
                maxWidth: kMaxWidth,
                maxHeight: 200,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: searchSuggestions.map((suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                      onTap: () {
                        // You can perform an action when a suggestion is tapped
                        // For example, fill the search input with the suggestion
                        searchController.text = suggestion;
                        String selectedProductName = suggestion;
                        print("anu$selectedProductName");
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) =>  ProductScreen(selectedProductName: selectedProductName),
                        //     ));
                        searchitem(suggestion).then((value) =>  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>ProductScreen(selectedProductName: suggestion),
                          ),
                        ));
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

