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
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();

  @override
    Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 5;
    return Column(
    children: [
      if (!showAllItems)
        Container(
          padding: EdgeInsets.all(8.0),

          child: Row(
            children: [
              for (var i = 0; i < crossAxisCount && i < contact.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 7),
                    child: CategoryCard(
                      title: capitalize(contact[i]['Company']),
                      press: () {},
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
                            press: (){},

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
                                // Handle card tap action here
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
      ElevatedButton(
        child: Container(
          width: 100,
          height: 50,
          child: Center(child: Text(showAllItems ? "Hide" : "View More")),),
        style: ElevatedButton.styleFrom(
          foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        onPressed: toggleShowAllItems,

      ),
      ],
    );
  }
}


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
      child:  AnimatedDefaultTextStyle(
        duration: Duration(milliseconds: 300),
        style: TextStyle(
        fontSize: 16.0,
        fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
        color: isHovered ? kPrimaryColor : Colors.black,),

      child: InkWell(
        onTap: widget.press,
        child: Container(

          width: _size.width <= 770
              ? _size.width/2
              : _size.width >= 975
              ? 300
              : 200,
          height: 100,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: isHovered ?  kgreyColor:kWhiteColor, // Change color on hover
              //boxShadow: [if (isHovered) kDefaultShadow],
            border: Border.all(
              color: kgreyColor, // Set the border color to grey
              width: 3.0,       // Set the border width
            ),
          ),
          child: Column(
            children: [
              // Add any widgets you want to display within the card, e.g., Text
              Text(widget.title,textAlign: TextAlign.center,style: TextStyle(fontFamily: 'DMSans Regular'),),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.local_hospital, // You can use any medical icon here
                    color: Colors.blue,
                    size: 24,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}


