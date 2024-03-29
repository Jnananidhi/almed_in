import 'dart:async';
import 'dart:convert';
import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:universal_html/html.dart' as html;
import '../test.dart';


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



  void clearSearchSuggestions() {
    searchSuggestions.clear();
    searchController.clear(); // Clear the text in the search box
    setState(() {});
  }

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
        List<String> apiResponse = data.map((product) => product["content"].toString()).toList();

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
        List<String> apiResponse = data.map((product) => product["content"].toString()).toList();

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
  void initState() {
    html.window.onClick.listen((event) {
      final clickedElement = event.target;

      // Check if the clicked element is not a child of the search box.
      if (clickedElement != searchController) {
        clearSearchSuggestions();
      }
    });
    super.initState();
  }
  int hoveredIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: kMaxWidth / 1.5,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Color(0xFF00AFBB),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: searchController,
                  onSubmitted: (searchTerm) {
                    if (searchTerm.isNotEmpty) {
                      print("sunad$searchTerm");
                      searchitem(searchTerm).then((value) =>  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>ProductScreenFromSearch(selectedProductName: searchTerm),
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
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: InkWell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),

                        child: ElevatedButton(
                          child: Container(
                            width: MediaQuery.of(context).size.width < 600
                                ? kMaxWidth / 25.5
                                : kMaxWidth / 15.5,
                            child: const Center(child: Text("Search",style: TextStyle(fontSize: 12),)),
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
                                  builder: (context) =>ProductScreenFromSearch(selectedProductName: searchTerm),
                                ),
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: kWhiteColor,
                            backgroundColor: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Suggestions ListView
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchSuggestions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          // Change the background color when hovered
                          // Here you can use a color of your choice
                          // For example, Colors.grey.withOpacity(0.2)
                          // This will set the background color to a semi-transparent grey
                          // when hovered
                          hoveredIndex = index; // Assuming hoveredIndex is a state variable
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          // Reset background color when not hovered
                          hoveredIndex = -1;
                        });
                      },
                      child: Container(
                        color: index == hoveredIndex
                            //? Colors.grey.withOpacity(0.3) // Background color when hovered
                        ?Color(0xFFCBECF9)
                            : Colors.transparent, // Default background color
                        child: ListTile(
                          leading: Icon(Icons.search),
                          title: Text(searchSuggestions[index],style: TextStyle(fontSize: 14),),
                          onTap: () {
                            String selectedSuggestion = searchSuggestions[index];
                            searchitem(selectedSuggestion).then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductScreenFromSearch(selectedProductName: selectedSuggestion),
                              ),
                            ));
                          },
                        ),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),


          // if (searchSuggestions.isNotEmpty)
          //   Container(
          //     width: kMaxWidth / 1.5,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(20.0),
          //       border: Border.all(
          //         color: kSecondaryColor,
          //       ),
          //     ),
          //     constraints: const BoxConstraints(
          //       maxWidth: kMaxWidth,
          //       maxHeight: 400,
          //     ),
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: searchSuggestions.map((suggestion) {
          //           return ListTile(
          //             title: Text(suggestion),
          //             onTap: () {
          //               // You can perform an action when a suggestion is tapped
          //               // For example, fill the search input with the suggestion
          //               searchController.text = suggestion;
          //               String selectedProductName = suggestion;
          //               print("anu$selectedProductName");
          //               // Navigator.push(
          //               //     context,
          //               //     MaterialPageRoute(builder: (context) =>  ProductScreen(selectedProductName: selectedProductName),
          //               //     ));
          //               searchitem(suggestion).then((value) =>  Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) =>ProductScreenFromSearch(selectedProductName: suggestion),
          //                 ),
          //               ));
          //             },
          //           );
          //         }).toList(),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

