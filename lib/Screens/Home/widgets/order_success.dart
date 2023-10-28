import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("success_animation.json",repeat: false,height: 200),
          const Text("Order Successful",textAlign: TextAlign.center,style: TextStyle(color: Colors.teal,fontSize: 18,fontFamily: 'DMSans Bold',fontWeight: FontWeight.bold)),
          const Text("Your Order id 0000000 has been successfully confirmed\nThanks for buying at Almed..",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'DMSans Light',fontWeight: FontWeight.bold)),
        ],
    ),
      ),
    );
  }
}
