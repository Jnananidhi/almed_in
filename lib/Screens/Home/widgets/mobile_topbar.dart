import 'package:almed_in/Screens/Home/cart_provider.dart';
import 'package:almed_in/Screens/Home/cart_screen_desktop.dart';
import 'package:almed_in/Screens/Home/cart_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class MobileNavigation extends StatefulWidget {
  const MobileNavigation({super.key});

  @override
  State<MobileNavigation> createState() => _MobileNavigationState();

}

class _MobileNavigationState extends State<MobileNavigation> {
  @override
  Widget build(BuildContext context) {
    var cartScreen = CartScreenMobile.of(context);
    if(cartScreen !=null){
      //print("CART LENGTH:${cartScreen.ca}",);
    }
    else{
      // print(cartScreen?.cart.length.toString(),);
    }
    return Row(
      children: [
        IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        const Spacer(),
        badges.Badge(
          position: badges.BadgePosition.topEnd(top: 0, end: 3),
          badgeContent:
          cartScreen != null
              ? Text(
           "",
            style: TextStyle(color: Colors.white),
          )
              : Text(
            "0",
            style: TextStyle(color: Colors.white),
          ),

          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart icon tap
            },
          ),
        ),
      ],
    );
  }
}
