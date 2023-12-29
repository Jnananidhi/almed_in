import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Navigation(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
            child: Text("My orders",style: TextStyle(fontFamily: 'DMSans Bold',fontSize: 20),),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Adjust the value for the desired border curvature
                ),

                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.asset(
                   "widget.product.imageUrl",
                    width: 200,
                    height: 200,
                  ),
                  title: Text(
                    "widget.product.name",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity:'),
                      Text(
                        'Total Paid: ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Ordered on: ',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
