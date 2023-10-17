
import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:flutter/material.dart';


class ProductListItem extends StatelessWidget {
  final Productt product;

  const ProductListItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45), // Adjust the value for the desired border curvature
      ),
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Image.network(
          product.imageUrl,
          width: 80,
          height: 80,
        ),
        title: Text(
          product.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity: ${product.quantity}'),
            Text(
              'MRP: ${product.mrp}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              'Discount: ${product.discount}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


