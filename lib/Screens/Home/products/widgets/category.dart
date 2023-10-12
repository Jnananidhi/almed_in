import 'dart:convert';

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

  @override
    Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 4;
    return Column(
    children: [

    Container(
      child: Padding(
      padding: EdgeInsets.all(8.0), // Add space between cards
      child:
          SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
                    for (var item in contact.take(crossAxisCount))
                    CategoryCard(
                    title: item['Company'],
                    press: () {
                    // Handle card tap action here
                    },
                    ),
                 ],
              ),
            ),
          )
    ),

    if (showAllItems)
    Container(
          height: 200, // Fixed height for the additional items grid
          child: ListView.builder(
                scrollDirection: Axis.vertical, // Display items vertically
                itemCount: (contact.length - crossAxisCount) ~/ crossAxisCount + 1, // Calculate the number of rows
                  itemBuilder: (context, rowIndex) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                      children: [
                        for (var i = rowIndex * crossAxisCount + crossAxisCount; i < (rowIndex + 1) * crossAxisCount + crossAxisCount; i++)
                          if (i < contact.length)
                            Expanded(
                              child: Align(
                                  alignment: Alignment.topCenter, // Align each card to the top
                                  child: CategoryCard(
                                    title: contact[i]['Company'],
                                    press: () {
                                      // Handle card tap action here
                                    },
                                  ),
                                ),
                              ),

                      ],
                );
              },
            ),
          ),
        ElevatedButton(
          onPressed: toggleShowAllItems,
          child: Text(showAllItems ? "Hide" : "View More"),
        ),
      ],
    );
  }
}

// class CategoryCard  extends StatefulWidget {
//   const CategoryCard({
//     Key? key,
//     required this.image,
//     required this.title,
//     required this.press,
//   }) : super(key: key);
//   final String image, title;
//   final VoidCallback press;
//   @override
//   State<CategoryCard> createState() => _CategoryCardState();
// }

// class _CategoryCardState extends State<CategoryCard> {
//   bool isHover = false;
//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: InkWell(
//         onTap: widget.press,
//         onHover: (value) {
//           setState(() {
//             isHover = value;
//           });
//         },
//         child: Container(
//           width: _size.width <= 770
//               ? _size.width
//               : _size.width >= 975
//               ? 300
//               : 200,
//           padding: const EdgeInsets.symmetric(
//             vertical: 10,
//           ),
//           decoration: BoxDecoration(
//               color: kgreyColor, boxShadow: [if (isHover) kDefaultShadow]),
//           child: Column(
//             children: [
//               Image.asset(
//                 widget.image,
//                 height: 200,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               MaterialButton(
//                 color: kSecondaryColor,
//                 height: 40,
//                 onPressed: () {},
//                 child: Text(
//                   widget.title,
//                   style: TextStyle(color: kWhiteColor),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CategoryCard extends StatefulWidget {
  final String title;
  final Function() press;

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
      child: InkWell(
        onTap: widget.press,
        child: Container(
          width: _size.width <= 770
              ? _size.width
              : _size.width >= 975
              ? 300
              : 200,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isHovered ?   kgreyColor:Colors.white, // Change color on hover
              boxShadow: [if (isHovered) kDefaultShadow]
          ),
          child: Column(
            children: [
              // Add any widgets you want to display within the card, e.g., Text
              Text(widget.title,style:TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}


