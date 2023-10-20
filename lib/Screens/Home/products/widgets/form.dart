import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../constants.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormCard extends StatefulWidget {

  const FormCard({
    Key? key,
  }) : super(key: key);
  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  bool isHover = false;
  List form = [];
  bool showAllItems = false;

  Future getAllcategory() async {
    var url = "${api}FORM.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        form = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return form;
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
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              boxShadow: [if (isHover) kDefaultShadow]),
          child:
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var item in form.take(crossAxisCount))
                  FormDataItem(
                    title:  item['FORM'],
                    press: (){},

                  ),
              ],
            ),
          ),
        ),

        if (showAllItems)
          if( MediaQuery.of(context).size.width > 600)
            Container(
              padding: EdgeInsets.all(8.0),
              height: form.length/0.1, // Fixed height for the additional items grid
              child: ListView.builder(
                scrollDirection: Axis.vertical, // Display items vertically
                itemCount: (form.length - crossAxisCount) ~/ crossAxisCount + 1, // Calculate the number of rows
                itemBuilder: (context, rowIndex) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                    children: [
                      for (var i = rowIndex * crossAxisCount + crossAxisCount; i < (rowIndex + 1) * crossAxisCount + crossAxisCount; i++)
                        if (i < form.length)
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter, // Align each card to the top
                              child: FormDataItem(
                                title: form[i]['FORM'],
                                press: (){},

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
              padding: EdgeInsets.all(8.0),
              height: crossAxisCount*form.length/0.1, // Fixed height for the additional items grid
              child: ListView.builder(
                scrollDirection: Axis.vertical, // Display items vertically
                itemCount: (form.length - crossAxisCount) ~/ crossAxisCount + 1, // Calculate the number of rows
                itemBuilder: (context, rowIndex) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                    children: [
                      for (var i = rowIndex * crossAxisCount + crossAxisCount; i < (rowIndex + 1) * crossAxisCount + crossAxisCount; i++)
                        if (i < form.length)
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter, // Align each card to the top
                              child: FormDataItem(
                                title: form[i]['FORM'],
                                press: (){},
                              ),
                            ),
                          ),

                    ],
                  );
                },
              ),
            ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: toggleShowAllItems,
          child: Text(showAllItems ? "Hide" : "View More"),
        ),
      ],
    );
  }
}

class FormDataItem extends StatefulWidget {
  final String title;
  final Function() press;

  FormDataItem({required this.title, required this.press});

  @override
  _FormDataItemState createState() => _FormDataItemState();
}

class _FormDataItemState extends State<FormDataItem> {

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
            fontSize: isHovered ? 20.0 : 16.0,
            fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
            color: isHovered ? kPrimaryColor : Colors.black,),

          child: InkWell(
            onTap: widget.press,
            child: Container(
              width: _size.width <= 770
                  ? _size.width
                  : _size.width >= 975
                  ? 300
                  : 200,
              padding: const EdgeInsets.symmetric(
                vertical: 10
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: isHovered ?   kgreyColor:kWhiteColor, // Change color on hover
                boxShadow: [if (isHovered) kDefaultShadow],
                border: Border.all(
                  color: kgreyColor, // Set the border color to grey
                  width: 3.0,       // Set the border width
                ),
              ),
              child: Column(
                children: [
                  // Add any widgets you want to display within the card, e.g., Text
                  Text(widget.title,),
                ],
              ),
            ),
          ),
        ));
  }
}