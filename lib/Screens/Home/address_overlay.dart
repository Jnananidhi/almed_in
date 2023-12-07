import 'package:almed_in/Screens/Home/address_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:almed_in/Screens/Home/Map/model_PlaceSearch.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
bool showSuggestions = true;
class AddressOverlay extends StatefulWidget {
  final BuildContext overlayContext;
  final OverlayEntry? overlayEntry;

  const AddressOverlay({Key? key, required this.overlayContext, this.overlayEntry}) : super(key: key);

  @override
  _AddressOverlayState createState() => _AddressOverlayState();
}

class _AddressOverlayState extends State<AddressOverlay> {
  bool displayContainer = false;
  // Define a variable to track which screen is currently displayed.
  final _formKey = GlobalKey<FormState>();
  String userInput = '';
  String Address = '';
  String RName = '';
  String Pnumber = '';

  int currentScreen = 1;
   late GoogleMapController? googleMapController;
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
      print(response);
      // Handle error or show a message to the user
    }
  }

  void _onSuggestionTap(PlaceSearch suggestion) async {
    if (googleMapController != null) {
      final placeDetailsUrl = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=${suggestion.placeId}&key=$GMAP_API';
      final response = await http.get(Uri.parse(placeDetailsUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = data['result'];

        final lat = result['geometry']['location']['lat'];
        final lng = result['geometry']['location']['lng'];

        final location = LatLng(lat, lng);

        googleMapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: location, zoom: 15.0),
          ),
        );
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      googleMapController = controller;
    });
  }


  // ... your searchPlaces and other methods

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(horizontal:  _size.width <= 770
          ? _size.width
          : _size.width >= 975
          ? 300
          : 200,vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Column(
        children: [
          // Back Icon and Title Bar
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      if (currentScreen == 2) {
                        // Navigate back to the first screen when on screen 2
                        currentScreen = 1;
                      } else {
                        // Close the overlay when on screen 1
                        widget.overlayEntry!.remove();
                      }
                    });
                  },
                ),
                const Spacer(),
                Text(
                  currentScreen == 1 ? "Select Delivery Location" : "Add Address",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close_outlined),
                  onPressed: () {
                      print("Close button pressed");
                      widget.overlayEntry!.remove();
                  },
                ),
              ],
            ),
          ),
          // Screen Content
          if (currentScreen == 1)
            _buildScreen1(context)
          else if (currentScreen == 2)
            _buildScreen2(context),
        ],
      ),
    );
  }


  // First screen content
  Widget _buildScreen1(BuildContext context) {
    return Container(
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
                height: 400, // Adjust the height as needed
                width: double.infinity, // Expand to available width
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(12.972442, 77.580643),
                    zoom: 12.0,
                  ),
                  markers: selectedLocationMarker != null ? {selectedLocationMarker!} : {},
                  onTap: _onMapTapped,
                  onMapCreated: _onMapCreated,
                ),
              ),
              // Display search results as suggestions
              if (searchResults.isNotEmpty)
                Visibility(
                  visible: showSuggestions,
                  child: Container(
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
                            _onSuggestionTap(suggestion);
                            setState(() {
                              showSuggestions = false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                    // Switch to the second screen
                    currentScreen = 2;
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
        ));
  }

  // Second screen content
  Widget _buildScreen2(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Pincode',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'DMSans Regular',

                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              onChanged: (text) {
                // Update the userInput variable when the text changes
                setState(() {
                  userInput = text;
                });
              },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'Please enter pincode';
                  }
                  return null;}
              ),


            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'House Number, Floor, Building Name, Locality',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'DMSans Regular',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              onChanged: (text) {
                // Update the userInput variable when the text changes
                setState(() {
                  Address = text;
                });
              },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Locality';
                  }
                  return null;}
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Recipient's Name",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'DMSans Regular',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              onChanged: (text) {
                // Update the userInput variable when the text changes
                setState(() {
                  RName = text;
                });
              },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Recipient's Name";
                  }
                  return null;}
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'DMSans Regular',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              onChanged: (text) {
                // Update the userInput variable when the text changes
                setState(() {
                  Pnumber = text;
                });
              },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phone Number';
                  }
                  return null;}
            ),

            SizedBox(height: 30),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.overlayEntry?.remove();
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AddressScreen(userInput: userInput,Address:Address,RName:RName,Pnumber:Pnumber,)),
                  );
                  }},
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
