import 'dart:convert';

import 'package:almed_in/Screens/Home/Map/model_PlaceSearch.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';


class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController googleMapController;
  TextEditingController searchController = TextEditingController();
  List<PlaceSearch> searchResults = [];

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 700,
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
                    height: 500,
                    width: 700,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(12.972442, 77.580643),
                        zoom: 1.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        setState(() {
                          googleMapController = controller;
                        });
                      },
                    ),
                  ),
                  // Display search results as suggestions
                  if (searchResults.isNotEmpty)
                    Container(
                      height: 150, // Adjust the height as needed
                      color: lightColor.withOpacity(0.7), // Set background color
                      child: ListView.builder(
                        itemCount: searchResults.length > 5 ? 5 : searchResults.length,
                        itemBuilder: (context, index) {
                          final suggestion = searchResults[index];
                          return ListTile(
                            title: Text(suggestion.description),
                            onTap: () {
                              // Handle selection of the suggestion
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );



  }
}