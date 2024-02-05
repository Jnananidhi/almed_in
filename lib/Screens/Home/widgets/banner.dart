import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';

//change the name of clas
class HeroBanner extends StatefulWidget {
  const HeroBanner({Key? key}) : super(key: key);

  @override
  _HeroBannerState createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
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
            options: CarouselOptions(
                height: _size.width <500
                    ? 250
                    : _size.width >= 500
                    ? 500
                    : 300,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
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
      padding: EdgeInsets.only(top: 10, left: 10,right: 10),
      color: kWhiteColor,
      width: kMaxWidth,
      child: Row(
        children: [
          Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                      border: Border.all(
                        color: Color(0xFF00AFBB), // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Same radius as the border
                        child: Image.asset(
                          image,
                          height: _size.width >= 500 ? 400 : 200,
                          width: _size.width >= 500 ? 1200 : 600,
                          fit: BoxFit.fill,
                        )),
                  )],
              )),
        ],
      ),
    );
  }
}

