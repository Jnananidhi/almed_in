import 'package:flutter/material.dart';



class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:UserProfilePage()
    );
  }
}

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with the path to the user's profile picture
          ),
          SizedBox(height: 10),
          Text(
            'John Doe', // Replace with the user's name
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          Text(
            'john.doe@example.com', // Replace with the user's email
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement the functionality to edit user information
              // This button can open a form for editing user details
            },
            child: Text('Edit Profile'),
          ),
          SizedBox(height: 20),
          Text(
            'Order History', // You can customize the title
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // Display a list of user's order history
          // You can use a ListView.builder or any other widget for this purpose
          Expanded(
            child: ListView(
              children: <Widget>[
                OrderHistoryItem(orderNumber: 'Order #12345', date: '2023-01-15', total: '\$99.99'),
                OrderHistoryItem(orderNumber: 'Order #67890', date: '2023-03-20', total: '\$49.99'),
                // Add more order history items here
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderHistoryItem extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String total;

  OrderHistoryItem({
    required this.orderNumber,
    required this.date,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(orderNumber),
      subtitle: Text('Date: $date, Total: $total'),
      trailing: Icon(Icons.arrow_forward),
      // Implement functionality to view details of each order
      onTap: () {
        // Add logic to view order details
      },
    );
  }
}
