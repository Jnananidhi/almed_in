import 'package:almed_in/Screens/Home/products/widgets/form.dart';
import 'package:almed_in/Screens/Home/products/widgets/strength.dart';
import 'package:almed_in/Screens/Home/products/widgets/thereapeautic.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';

import 'headphone_product.dart';
import 'iphone_products.dart';
import 'samsung_products.dart';

class AllBrandsProduct extends StatefulWidget {
  const AllBrandsProduct({Key? key}) : super(key: key);

  @override
  _AllBrandsProductState createState() => _AllBrandsProductState();
}

class _AllBrandsProductState extends State<AllBrandsProduct> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TabBar(
              indicatorColor: kPrimaryColor,
              unselectedLabelColor: Colors.black,
              labelColor: kPrimaryColor,
              indicatorWeight: 2.0,
              unselectedLabelStyle: TextStyle(
                fontFamily: 'DMSans Regular',
                fontSize: _size.width >= 414 ? 18 : 12,
              ),
              labelStyle: TextStyle(
                fontFamily: 'DMSans Regular',
                fontSize: _size.width >= 414 ? 18 : 12,
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(
                  text: "Therapeautic",
                ),
                Tab(
                  text: "Strength",
                ),
                Tab(
                  text: "Form",
                ),
              ],
            ),

            Container(
              height: 500,
              child: Expanded( // Use Expanded to allow TabBarView to take available space
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: DatabaseDataCard(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: StrengthCard(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: FormCard(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

