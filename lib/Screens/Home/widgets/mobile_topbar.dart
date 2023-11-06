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
    return Row(
      children: [
        IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        const Spacer(),
        Consumer<CartProvider>(
          builder: (context, cart, child) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartScreenMobile();
                }));
              },
              child: badges.Badge(
                badgeContent: Text(cart.cartItemCount.toString()),
                child: Icon(Icons.shopping_cart),
              ),
            );
          },
        ),
      ],
    );
  }
}
