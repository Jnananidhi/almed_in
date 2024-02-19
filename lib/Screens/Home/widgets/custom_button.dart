import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  CustomButton({required this.label, required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return kSecondaryColor; // Color when the button is hovered
            }
            return kPrimaryColor; // Default button color
          },
        ),
        elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return 6; // Elevation when the button is hovered
          }
          return 4; // Default elevation
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Adjust the radius to control the curve
          ),
        ),
      ),
      child: Text(
        widget.label,
        style: const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'DMSans Regular'),
      ),
    );
  }
}
