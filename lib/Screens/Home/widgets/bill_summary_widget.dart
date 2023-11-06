import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BillSummary extends StatelessWidget {

  double shippingCost = 0;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Adjust the value for the desired border curvature
      ),
      child: Container(
        height: 300,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: lightColor,
          border: Border.all(color: kPrimaryColor,width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bill Summary',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'DMSans Bold',
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 2,),
            BillItem(label: 'Total Bill (MRP) ' ,value:cart.calculateTotalMRP().toString()),
            BillItem(label: 'Total Discount ',value:'-'+cart.calculateTotalDiscount().toString()),
            BillItem(label: 'Shipping Fee ' ,value: '50'),
            Divider(thickness: 2,),
            BillItem(label: 'To Be Paid ',value:cart.calculateTotalAmount(shippingCost=50.00).toString(), isTotal: true),
          ],
        ),
      ),
    );
  }
}

class BillItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  BillItem({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'DMSans Regular',
                fontWeight: isTotal?FontWeight.bold:FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'DMSans Regular',
                fontWeight: isTotal?FontWeight.bold:FontWeight.normal,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
      ],
    );
  }
}