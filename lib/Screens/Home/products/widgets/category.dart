import 'dart:convert';

import 'package:almed_in/Screens/Home/Category.dart';
import 'package:almed_in/Screens/Home/company_list_screen.dart';
import 'package:almed_in/Screens/Home/products/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/responsive.dart';
import 'package:http/http.dart' as http;

import '../../../../constants.dart';

class Cateegory extends StatefulWidget {
  const Cateegory({
    Key? key,
  }) : super(key: key);
  @override
  State<Cateegory> createState() => _CateegoryState();
}

class _CateegoryState extends State<Cateegory> {

  bool isHover = false;
  List contact = [];
  bool showAllItems = false;

  Future getAllcategory() async {
    var url = "${api}almed_company.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        contact = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return contact;
  }

  @override
  void initState() {
    getAllcategory();
    super.initState();
  }

  void toggleShowAllItems() {
    setState(() {
      showAllItems = !showAllItems;
    });
  }
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();

  @override
    Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 5;
    return Column(
    children: [
      if (!showAllItems)
        Container(
          //padding: EdgeInsets.all(8.0),

          child: Row(
            children: [
              for (var i = 0; i < crossAxisCount && i < contact.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CategoryCard(
                      title: capitalize(contact[i]['Company']),
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FetchedCategoryProduct(selectedProductName: contact[i]['Company'],),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
    if (showAllItems)
    if( MediaQuery.of(context).size.width > 600)
      Container(
        height: contact.length*107/crossAxisCount, // Fixed height for the additional items grid
        child: ListView.builder(
          scrollDirection: Axis.vertical, // Display items vertically
          itemCount: (contact.length), // Calculate the number of rows
          itemBuilder: (context, rowIndex) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
              children: [
                for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                  if (i < contact.length)
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter, // Align each card to the top
                        child: Padding(
                          padding:EdgeInsets.only(bottom: 7,left: 7),
                          child: CategoryCard(
                            title: contact[i]['Company'],
                            press: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FetchedCategoryProduct(selectedProductName: contact[i]['Company'],),
                                ),
                              );
                            },

                          ),
                        ),
                      ),
                    ),

              ],
            );
          },
        ),
      ),
      if (showAllItems)
      if( MediaQuery.of(context).size.width < 600)
        Container(
          height: contact.length*100/crossAxisCount, // Fixed height for the additional items grid
          child: ListView.builder(
            scrollDirection: Axis.vertical, // Display items vertically
            itemCount: contact.length , // Calculate the number of rows
            itemBuilder: (context, rowIndex) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                children: [
                  for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                    if (i < contact.length)
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter, // Align each card to the top
                          child: Padding(
                            padding:EdgeInsets.only(bottom: 5),
                            child: CategoryCard(
                              title: contact[i]['Company'],
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FetchedCategoryProduct(selectedProductName: contact[i]['Company'],),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                ],
              );
            },
          ),
        ),
      Padding(
        padding: EdgeInsets.only(top: 10, right: 10), // Add right padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Align children to the end (right side)
          children: [
            CustomButton(
              text: ("SEE ALL"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CompanyScreen()),
                );
              },
            ),
          ],
        ),
      ),
      ],
    );
  }
}


class CategoryCard extends StatefulWidget {
  final String title;
  //final String image;
  final Function() press;

  // DatabaseDataItem({required this.title, required this.image,required this.press});
  CategoryCard({required this.title, required this.press});
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {

  bool isHovered = false;


  @override

  Widget build(BuildContext context) {

    Size _size = MediaQuery.of(context).size;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child:  AnimatedDefaultTextStyle(
        duration: Duration(milliseconds: 300),
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
          color: isHovered ? kPrimaryColor : Colors.black,),

        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: widget.press,
          child: Container(
            width: _size.width <= 770
                ? _size.width/2
                : _size.width >= 975
                ? 300
                : 200,
            height: 160,
            padding: const EdgeInsets.symmetric(
                vertical: 10
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: kWhiteColor, // Change color on hover
              boxShadow: isHovered ? [kDefaultShadow] : [],
              border: Border.all(
                color: kgreyColor, // Set the border color to grey
                width: 2.0,       // Set the border width
              ),
            ),
            child: Column(
              children: [
                // Add any widgets you want to display within the card, e.g., Text
                // Image.network(
                //   widget.image,
                //   width: 100, // Set width as needed
                //   height: 100, // Set height as needed
                //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                //     if (loadingProgress == null) {
                //       return child;
                //     } else {
                //       return Center(
                //         child: CircularProgressIndicator(
                //           value: loadingProgress.expectedTotalBytes != null
                //               ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                //               : null,
                //         ),
                //       );
                //     }
                //   },
                //   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                //     return  Image.asset(
                //       'default.png', // Path to default image
                //       fit: BoxFit.cover,
                //       width: 100, // Set width as needed
                //       height: 100,
                //     );
                //   },
                // ),
                ClipOval(
                  child: Image.asset(
                    'company.webp', // Path to default image
                    fit: BoxFit.contain,
                    width: 100, // Set width as needed
                    height: 100,
                  ),
                ),
                Spacer(),
                Text(widget.title,textAlign: TextAlign.center,style: TextStyle(fontFamily: 'DMSans Regular',fontSize: 16),),
                Spacer(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


