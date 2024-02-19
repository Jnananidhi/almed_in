import 'dart:convert';
import 'package:almed_in/Screens/Home/Category.dart';
import 'package:http/http.dart' as http;
import 'package:almed_in/Screens/Home/products/product_listing.dart';
import 'package:almed_in/Screens/Home/products/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/model/trending_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../widgets/custom_listview.dart';

class TrendingProductCard extends StatefulWidget {
  const TrendingProductCard({
    Key? key,
  }) : super(key: key);

  @override
  State<TrendingProductCard> createState() => _TrendingProductCardState();
}

class _TrendingProductCardState extends State<TrendingProductCard> {
  List trendingProducts = [];
  Future getAllcategory() async {
    var url = "${api}fetch_trending_products.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        trendingProducts = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return trendingProducts;
  }
  @override
  void initState() {
    getAllcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGridView.countBuilder(
        //shrink wrap to avoid error
        shrinkWrap: true,
        physics: ScrollPhysics(),
        crossAxisCount: 4,
        itemCount: trendingProducts.length,
        itemBuilder: (BuildContext context, int index) => TrendingProducts(
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FetchedCategoryProduct(selectedProductName: trendingProducts[index]['BRAND_NAME']),
              ),
            );
          },
          title: trendingProducts[index]['BRAND_NAME'],
          image: trendingProducts[index]['IMAGE'],
          price: trendingProducts[index]['PRICE'],
        ),
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
    );
  }
}

class MobTrendingProduct extends StatefulWidget {
  const MobTrendingProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<MobTrendingProduct> createState() => _MobTrendingProductState();
}

class _MobTrendingProductState extends State<MobTrendingProduct> {
  List trendingProducts = [];
  Future getAllcategory() async {
    var url = "${api}therapeautic.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        trendingProducts = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return trendingProducts;
  }
  @override
  void initState() {
    getAllcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGridView.countBuilder(
        //shrink wrap to avoid error
        shrinkWrap: true,
        physics: ScrollPhysics(),
        crossAxisCount: 2,
        itemCount: trendingProducts.length,
        itemBuilder: (BuildContext context, int index) => TrendingProducts(
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FetchedCategoryProduct(selectedProductName: trendingProducts[index]['BRAND_NAME']),
              ),
            );
          },
          title: trendingProducts[index]['BRAND_NAME'],
          image: trendingProducts[index]['IMAGE'],
          price: trendingProducts[index]['PRICE'],
        ),
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
    );
  }
}

class TrendingProducts extends StatefulWidget {
  final String title;
  final String image;
  final String price;
  final Function() press;
  const TrendingProducts({
    Key? key,
    required this.title,
    required this.image,
    required this.price,
    required this.press,
  }) : super(key: key);

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.press,
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        child: AnimatedContainer(
          duration: kDefaultDuration,
          width: 300,
          height: 280,
          decoration: BoxDecoration(

            boxShadow: isHover ? [kDefaultShadow] : [],
            borderRadius: BorderRadius.circular(15.0),
            color: kWhiteColor, // Change color on hover
            border: Border.all(
              color: kgreyColor, // Set the border color to grey
              width: 3.0,       // Set the border width
            ),
          ),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Network image or default image
                        widget.image.isNotEmpty
                            ? Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'default.png', // Path to default image
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: 150,
                            );
                          },
                        )
                            : Image.asset(
                          'default.png', // Path to default image
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\₹${widget.price}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              isHover
                  ? Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // MaterialButton(
                          //   color: kSecondaryColor,
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(50)),
                          //   height: 40,
                          //   onPressed: () {
                          //     // Navigator.pushNamed(context, "/ProductItem");
                          //   },
                          //   child: const Text(
                          //     "Quick View",
                          //     style: TextStyle(color: kWhiteColor),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),

                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
