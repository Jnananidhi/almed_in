import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/constants.dart';

//change the name of class
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
                  image: 'assets/products/banner/banner1.jpg',
                  press: () {}),
              SliderCard(
                  title: 'Mobile',
                  image: 'assets/products/banner/banner2.jpg',
                  press: () {}),
              SliderCard(
                  title: 'Headphone',
                  image: 'assets/products/banner/banner_3.png',
                  press: () {}),
              SliderCard(
                  title: 'Headphone',
                  image: 'assets/products/banner/banner_4.png',
                  press: () {}),
            ],
            options: CarouselOptions(
                height: _size.width == 300
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
                autoPlayInterval: Duration(seconds: 3),
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
          dotsCount: 4,
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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: kWhiteColor,
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Image.asset(
                image,
                height: _size.width >= 500 ? 400 : 200,
                width: _size.width >= 500 ? 1200 : 200,
                fit: BoxFit.fill,
              ),
            ],
          )),
        ],
      ),
    );
  }
}
