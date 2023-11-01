import 'package:almed_in/Screens/Home/Map/address_selector_MAP.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool isMapViewVisible = false;// Initially, the map view is invisible

  void toggleMapViewVisibility() {
    setState(() {
      isMapViewVisible = !isMapViewVisible;
    });
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
          child: Row(
            children: [
              // Left Section with Buttons
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: toggleMapViewVisibility,
                      child: Text(
                        "+ Add delivery address",
                        style: TextStyle(
                          fontSize: 15,
                          color: kPrimaryColor,
                          fontFamily: 'DMSans Bold',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                        child: Text(
                          "Continue Payment",
                          style: TextStyle(
                            fontSize: 15,
                            color: lightColor,
                            fontFamily: 'DMSans Bold',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Recent addresses",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'DMSans Regular',
                      ),
                    ),
                  ],
                ),
              ),
              // Right Section with Search and Map
              Expanded(
                flex: 2,
                child: isMapViewVisible
                    ? MapView(key: ValueKey('map_key'))
                    : Container(), // Render the MapView only when isMapViewVisible is true
              ),
            ],
          ),
        ),
      );
    }
  }