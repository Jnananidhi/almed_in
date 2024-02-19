import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';
import 'package:http/http.dart' as http;

//change the name of clas
class HeroBanner extends StatefulWidget {
  const HeroBanner({Key? key}) : super(key: key);

  @override
  _HeroBannerState createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  List trending_products = [];
  Future getAllcategory() async {
    var url = "${api}getbanners.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        trending_products = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return trending_products;
  }

  @override
  void initState() {
    getAllcategory();
    super.initState();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        CarouselSlider(
            items: [
              SliderCard(
                  title: 'Headphone',
                  image: 'assets/products/banner/Banner1.png',
                  press: () {}),
              SliderCard(
                  title: 'Mobile',
                  image: 'assets/products/banner/Banner2.png',
                  press: () {}),
              SliderCard(
                  title: 'Headphone',
                  image: 'assets/products/banner/Banner3.png',
                  press: () {}),
              SliderCard(
                  title: 'Headphone',
                  image: 'assets/products/banner/Banner4.png',
                  press: () {}),
              SliderCard(
                  title: 'Headphone',
                  image: 'assets/products/banner/Banner5.png',
                  press: () {}),
              SliderCard(
                  title: 'Headphone',
                  image: 'assets/products/banner/Banner6.png',
                  press: () {}),
              SliderCard(
                  title: 'Headphone',
                  image: 'assets/products/banner/Banner7.png',
                  press: () {}),
            ],
            // items: trending_products.map((item) {
            //   return SliderCard(
            //     title: item['title'],
            //     image: item['image'], // Assuming imageUrl is the field containing the image URL in your database.
            //     press: () {},
            //   );
            // }).toList(),
            options: CarouselOptions(
                height: _size.width <500
                    ? 250
                    : _size.width >= 500
                    ? 400
                    : 300,
                aspectRatio: 15 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 900),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (int p, CarouselPageChangedReason) {
                  setState(() {
                    index = p;
                  });
                })),
        DotsIndicator(
          dotsCount: 7,
          position: index.toDouble(),
          decorator: DotsDecorator(
            activeColor: kPrimaryColor.withOpacity(0.5),
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }
}

class SliderCard extends StatelessWidget {
  const SliderCard({
    Key? key,
    required this.title,
    required this.image,
    required this.press,
  }) : super(key: key);
  final String title, image;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      //padding: EdgeInsets.only(top: 10, left: 10,right: 10),
      color: kWhiteColor,
      width: _size.width,
      child: Row(
        children: [
          Expanded(
              child: Column(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                    //   border: Border.all(
                    //     color: Color(0xFF00AFBB), // Border color
                    //     width: 1.0, // Border width
                    //   ),
                    // ),
                    child: ClipRRect(
                       // borderRadius: BorderRadius.circular(20), // Same radius as the border
                        child: Image.network(
                          image,
                          height: _size.width >= 500 ? 340 : 200,
                          width: _size.width,
                          fit: BoxFit.fill,
                        )),
                  )],
              )),
        ],
      ),
    );
  }
}

