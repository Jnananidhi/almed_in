import 'package:almed_in/Screens/Home/Map/address_selector_MAP.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:flutter/material.dart';
class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    //return MapView(key: ValueKey('map_key'));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Row(
          children: [
            // Left Section with Buttons
            Expanded(
              flex: 1, // Adjust the flex value as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    label:'+ Add Delivery Address',
                    onPressed: () {

                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(label: 'Continue to Payment', onPressed: (){

                  }),
                ],
              ),
            ),
            // Right Section with Search and Map
            Expanded(
              flex: 2, // Adjust the flex value as needed
              child: MapView(key: ValueKey('map_key')),
            ),
          ],
        ),
      ),
    );
  }
}

