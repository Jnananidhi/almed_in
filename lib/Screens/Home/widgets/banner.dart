import 'dart:convert';
import 'dart:async';
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
    return Padding(

      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircularHeroBanner(
            images: [
              'assets/products/banner/Banner1.png',
              'assets/products/banner/Banner2.png',
              'assets/products/banner/Banner3.png',
              'assets/products/banner/Banner4.png',
              'assets/products/banner/Banner5.png',
              'assets/products/banner/Banner6.png',
              'assets/products/banner/Banner7.png',
            ],
            height: 400.0, // Adjust the height of the banner as needed
          ),

        ],
      ),
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
      padding: EdgeInsets.only(top: 10, left: 30,right: 30),
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
                        borderRadius: BorderRadius.circular(10), // Same radius as the border
                        child: Image.network(
                          image,
                          height: _size.width >= 500 ? 340 : 200,
                          width: kMaxWidth,
                          fit: BoxFit.contain,
                        )),
                  )],
              )),
        ],
      ),
    );
  }
}

class CircularHeroBanner extends StatefulWidget {
  final List<String> images;
  final double height;
  final Duration autoScrollDuration;

  const CircularHeroBanner({
    Key? key,
    required this.images,
    this.height = 1000.0,
    this.autoScrollDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  _CircularHeroBannerState createState() => _CircularHeroBannerState();
}

class _CircularHeroBannerState extends State<CircularHeroBanner> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1, // Start from the second image for circular looping
      viewportFraction: 1.0, // Only display one image at a time
    );
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
           width: double.infinity,
          height: widget.height,
          child: PageView.builder(
            itemCount: widget.images.length + 2, // Add 2 extra pages for circular looping
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                if (page == 0) {
                  _currentPage = widget.images.length - 1;
                  _pageController.jumpToPage(widget.images.length);
                } else if (page == widget.images.length + 1) {
                  _currentPage = 0;
                  _pageController.jumpToPage(1);
                } else {
                  _currentPage = page - 1;
                }
              });
            },
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return SizedBox.shrink(); // Placeholder for first page
              } else if (index == widget.images.length + 1) {
                return SizedBox.shrink(); // Placeholder for last page
              } else {
                return _buildBannerItem(widget.images[index - 1]); // Other images
              }
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    return List.generate(widget.images.length, (index) {
      return _buildIndicator(index == _currentPage);
    });
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  Widget _buildBannerItem(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
          height: widget.height,
        ),
      ),
    );
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.autoScrollDuration, (timer) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}


// items: trending_products.map((item) {
// return SliderCard(
// title: item['title'],
// image: item['image'], // Assuming imageUrl is the field containing the image URL in your database.
// press: () {},
// );
// }).toList(),