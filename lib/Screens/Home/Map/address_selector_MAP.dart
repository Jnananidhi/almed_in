import 'dart:async';
import 'dart:convert';

import 'package:almed_in/Screens/Home/Map/model_PlaceSearch.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../Authentication/login_screen.dart';
import '../about_screen.dart';
import '../address_screen.dart';
import '../contact_screen.dart';
import '../faq_screen.dart';
import '../products/products_screen.dart';
import '../widgets/menu.dart';

bool isDetailsVisible = false;
bool isCardVisible = false;
class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  String selectedMenuItem = 'Category';
  late GoogleMapController googleMapController;
  Completer<GoogleMapController> _controllerCompleter = Completer();
  TextEditingController searchController = TextEditingController();
  List<PlaceSearch> searchResults = [];
  Marker? selectedLocationMarker;
  LatLng? tappedLocation;
  void _onMapTapped(LatLng location) {
    setState(() {
      tappedLocation = location;
      if (selectedLocationMarker != null) {
        // Update the position of the existing marker
        selectedLocationMarker = selectedLocationMarker!.copyWith(
          positionParam: location,
        );
      } else {
        // Create a new marker
        selectedLocationMarker = Marker(
          markerId: MarkerId('selectedLocation'),
          position: location,
          draggable: true, // Make the marker draggable
          // You can customize the marker's icon here
        );
      }
    });
    print(location);
  }



  Future<void> searchPlaces(String searchTerm) async {

    //final sessionToken = 'YOUR_SESSION_TOKEN'; // Optional

    final endpoint = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final url = Uri.parse('$endpoint?input=$searchTerm&key=$GMAP_API');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        searchResults.clear();
        final data = json.decode(response.body);
        //print(data);
        if (data['status'] == 'OK') {
          final predictions = List<PlaceSearch>.from(data['predictions'].map((place) => PlaceSearch.fromJson(place)));
          searchResults.addAll(predictions);
        }
      });
    } else {
      // Handle error or show a message to the user
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Image(image: AssetImage('logo.png'),height: 80),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                isActive: true,
                title: 'Home',
                press: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'About Us',
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
                },
              ),

              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'FAQ',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FaqScreen()),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),

              DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: selectedMenuItem,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedMenuItem = newValue;
                      // Add logic to navigate to the related page based on selectedMenuItem
                      if (selectedMenuItem == 'Therapeutic') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),

                        );

                      } else if (selectedMenuItem == 'Strength') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                        );
                      }
                      else if (selectedMenuItem == 'Company') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                        );
                      }else if (selectedMenuItem == 'Form') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(selectedMenuItem: selectedMenuItem)),
                        );
                      }
                    });
                  }
                },
                items: ['Category','Therapeutic', 'Company', 'Form', 'Strength']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:  18 ,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                // Set the underline property to Container() to hide the underline.
                underline: Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'Vendor?',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginPage()),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MenuItems(
                title: 'Contact Us',
                press: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsApp()));},
              ),
            ],
          )),
      body: Card(
        margin: EdgeInsets.only(top:20,bottom: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  // Top Container
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          // Add the code to handle the back button press
                        },
                      ),
                      const Spacer(),
                      Text(
                        "Add Address",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                // Search Input MAP Container__________________________________________________________________________
                isDetailsVisible?AddressDetails():
                Container(
                child:Column(children:[SizedBox(
                  width: double.infinity, // Expand to available width
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search delivery location',
                    ),
                    onChanged: (query) {
                      // Perform location search based on user input (query)
                      // You can use the Google Places API to fetch location suggestions
                      searchPlaces(query);
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Use a Stack to overlay the search results on the map
                Stack(
                  children: [
                    Container(
                      height: 300, // Adjust the height as needed
                      width: double.infinity, // Expand to available width
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(12.972442, 77.580643),
                          zoom: 12.0,
                        ),
                        markers: selectedLocationMarker != null ? {selectedLocationMarker!} : {},
                        onTap: _onMapTapped,
                      ),
                    ),
                    // Display search results as suggestions
                    if (searchResults.isNotEmpty)
                      Container(
                        height: 150, // Adjust the height as needed
                        width: double.infinity, // Expand to available width
                        color: lightColor.withOpacity(0.7), // Set background color
                        child: ListView.builder(
                          itemCount: searchResults.length > 5 ? 5 : searchResults.length,
                          itemBuilder: (context, index) {
                            final suggestion = searchResults[index];
                            return ListTile(
                              title: Text(suggestion.description),
                              onTap: () {

                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isDetailsVisible = true;
                          AddressDetails();// Show the details container
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                      child: Text(
                        "Confirm address and continue",
                        style: TextStyle(
                          fontSize: 15,
                          color: lightColor,
                          fontFamily: 'DMSans Bold',
                        ),
                      ),
                    ),
                  ),],
                )),//____________MAP CONTAINER END_________________________________________
              ],
            ),
          ),
        ),
      ),
    );

  }
}
class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  String userInput = '';
  String Address = '';
  String RName = '';
  String Pnumber = '';
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isDetailsVisible,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Pincode',labelStyle: TextStyle(color: Colors.black,fontFamily: 'DMSans Regular')),
              onChanged: (text) {
                // Update the userInput variable when the text changes
                setState(() {
                  userInput = text;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'House Number,Floor,Building Name,Locality',labelStyle: TextStyle(color: Colors.black,fontFamily: 'DMSans Regular')),
              onChanged: (text) {
                // Update the userInput variable when the text changes
                setState(() {
                  Address = text;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Recipient's Name",labelStyle: TextStyle(color: Colors.black,fontFamily: 'DMSans Regular')),
              onChanged: (text) {
                // Update the userInput variable when the text changes
                setState(() {
                  RName = text;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Phone Number',labelStyle: TextStyle(color: Colors.black,fontFamily: 'DMSans Regular')),
              onChanged: (text) {
                // Update the userInput variable when the text changes
                setState(() {
                  Pnumber = text;
                });
              },
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AddressScreen(userInput: userInput,Address:Address,RName:RName,Pnumber:Pnumber)),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 15,
                    color: lightColor,
                    fontFamily: 'DMSans Bold',
                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

