import 'dart:convert';

import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../../constants.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<dynamic> ordersData=[];
  static const IconData currency_rupee_rounded = IconData(0xf02fa, fontFamily: 'MaterialIcons');
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }
  Future<void> fetchOrders() async {

    final response = await http.get(Uri.parse('${api}getOrders.php'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');

      final List<dynamic> jsonData = json.decode(response.body);
      List<dynamic> orders = List<Map<String, dynamic>>.from(jsonData);
      print("kp$orders");

      setState(() {
        ordersData = orders;
      });

      //print('Products loaded successfully for page $currentPage');
    } else {
      // print('Failed to load products for page $currentPage');
      // print('Response status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // Assuming you receive orders from PHP
      return Scaffold(

        body: Stack(
          children: [
            Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Navigation(), // Assuming this is a custom widget
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 600,
                          child: ListView.builder(
                            itemCount: ordersData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          'Order number: ${ordersData[index]['id']}',
                                          style: TextStyle(fontFamily: 'DMSans Bold'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Text('Price: '),
                                            Icon(Icons.attach_money, color: Colors.black),
                                            Text('${ordersData[index]['total_amount']}'),
                                          ],
                                        ),
                                      ),
                                    ),],),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: Text(
                                              'Date: ${ordersData[index]['date']}',
                                              style: TextStyle(fontFamily: 'DMSans Regular'),
                                            ),
                                          ),
                                        ),

                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          'Status: ${ordersData[index]['delivery_status']}',
                                          style: TextStyle(fontFamily: 'DMSans Regular'),
                                        ),
                                      ),
                                    ),],
                                    ),
                                    ExpansionTile(
                                      backgroundColor: Colors.white,
                                      title: Text('Order Details'),
                                      children: <Widget>[
                                        ListTile(
                                          title: Text('Price: \$${ordersData[index]['total_amount']}'),
                                        ),
                                        ListTile(
                                          title: Text('Date: ${ordersData[index]['date']}'),
                                        ),
                                        ListTile(
                                          title: Text('Status: ${ordersData[index]['delivery_status']}'),
                                        ),
                                        ListTile(
                                          title: Text('Quantity: ${ordersData[index]['total_ordered_quantity']}'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        BottomNav(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.width < 600 ? 90 : 20,
              left: MediaQuery.of(context).size.width < 600 ? 0 : MediaQuery.of(context).size.width * 0.22,
              right: MediaQuery.of(context).size.width < 600 ? 0 : MediaQuery.of(context).size.width * 0.25,
              child: Search_bar1(), // Assuming this is a custom widget
            ),
          ],
        ),

      );
    }
  }
