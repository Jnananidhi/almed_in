
import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/widgets/order_success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class ProductListItem extends StatelessWidget {
  final Productt product;

  const ProductListItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Adjust the value for the desired border curvature
      ),
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Image.network(
          product.imageUrl,
          width: 200,
          height: 200,
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


class ProductItem extends StatefulWidget {
  final Productt product;

  ProductItem(this.product, {super.key});

  @override
  State<ProductItem> createState() => ProductItemState(
      product: product);
}

class ProductItemState extends State<ProductItem> {
  var product;
    ProductItemState(
  {required this.product});

  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final widthPercentage = 0.3; // 30% of the screen width
    final heightPercentage = 0.4; // 20% of the screen height

    final containerWidth = screenWidth * widthPercentage;
    final containerHeight = screenHeight * heightPercentage;
    return InkWell(
      onTap: (){},
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      child: AnimatedContainer(
        duration: kDefaultDuration,
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: kgreyColor, width: 3),
            boxShadow: [if (isHover) kDefaultShadow]),
        child: Stack(
            fit: StackFit.passthrough,
            children: [
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

          Image.network(
          product.imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          height: 10,
        ),

        Text(
          product.name,
          style:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
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
              isHover
                  ? Container(
                color: Colors.black12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      height: 40,
                      onPressed: () {
                        context.read<CartProvider>().addToCart(product);
                      },
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: kSecondaryColor,
                      height: 40,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderSuccessScreen()),
                        );
                      },
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ],
                ),
              )
                  : Container(),
            ],
        ),
      ));
  }
  }


