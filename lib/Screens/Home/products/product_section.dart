import 'package:almed_in/Screens/Home/products/products_screen.dart';
import 'package:almed_in/Screens/Home/products/widgets/form.dart';
import 'package:almed_in/Screens/Home/products/widgets/strength.dart';

import 'package:almed_in/Screens/Home/products/widgets/thereapeautic.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/Screens/Home/widgets/author.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'widgets/allproducts.dart';
import 'widgets/category.dart';
import 'widgets/trending_products.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            constraints: BoxConstraints(maxWidth: double.infinity,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: kSecondaryColor, width: 3))),
                    child: const Text(
                      "Company",
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Cateegory(),
                //trending product section
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: kSecondaryColor, width: 3))),
                    child: const Text(
                      "Theaureapatic",
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const DatabaseDataCard(),
                //trending product section
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: kSecondaryColor, width: 3))),
                    child: const Text(
                      "Form",
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const FormCard(),
                //trending product section
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: kSecondaryColor, width: 3))),
                    child: const Text(
                      "Strength",
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const StrengthCard(),
                //trending product section
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: kSecondaryColor, width: 3))),
                    child: const Text(
                      "Trending Products",
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                if (Responsive.isDesktop(context)) const TrendingProductCard(),
                if (!Responsive.isDesktop(context)) const MobTrendingProduct(),

                //now we create trending Product model
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child:Center(
                    child:
                    // CustomButton(label: "All Products",
                    //     onPressed: (){
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => const ProductScreen()),
                    //
                    //       );
                    //       //Navigator.pushNamed(context, "/product-screen");
                    //     },
                    // ),
                    ElevatedButton(
                      child: Container(
                          width: 100,
                          height: 50,
                          child: const Center(child: Text("All Products"))),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/product-screen");
                      },
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: kSecondaryColor, width: 3))),
                  child: const Text(
                    "Testimonials",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Author(),
                ),
                // now add all brands data
                //first of all we create model

                const SizedBox(
                  height: 100,
                ),
                //bottom Navigation menu
              ],
            ),
          ),
        ),
      ],
    );
  }
}
