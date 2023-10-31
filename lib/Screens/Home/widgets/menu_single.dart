import 'package:almed_in/Screens/Home/home_screen.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'package:flutter/material.dart';

class Menu2 extends StatefulWidget {
  const Menu2({super.key});

  @override
  State<Menu2> createState() => _Menu2State();
}

class _Menu2State extends State<Menu2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: kWhiteColor,
        width: double.infinity,
        child: Column(
            children: [

              Container(
                  constraints: const BoxConstraints(
                    maxWidth: kMaxWidth,
                  ),
                  child: Column(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              if (!Responsive.isDesktop(context))
                                IconButton(
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    icon: Icon(Icons.menu)),
                              //title
                              Container(
                                color: kWhiteColor,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                                      );
                                    },
                                    child: Image.asset(
                                      'logo_500w.png',  // Make sure the path is correct
                                      fit: BoxFit.contain,
                                      height: 120,
                                    )
                                ),
                              ),
    ],),),],),),],));
  }
  }

