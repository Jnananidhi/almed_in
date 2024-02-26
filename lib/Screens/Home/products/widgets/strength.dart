import 'package:almed_in/Screens/Home/Category.dart';
import 'package:almed_in/Screens/Home/company_list_screen.dart';
import 'package:almed_in/Screens/Home/products/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../constants.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StrengthCard extends StatefulWidget {

  const StrengthCard({
    Key? key,
  }) : super(key: key);
  @override
  State<StrengthCard> createState() => _StrengthCardState();
}

class _StrengthCardState extends State<StrengthCard> {
  bool isHover = false;
  List strength = [];
  bool showAllItems = false;

  Future getAllcategory() async {
    var url = "${api}STRENGTH.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        strength = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return strength;
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
    final crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 5;
    return Column(
      children: [
        if (!showAllItems)
          Container(
           // padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                for (var i = 0; i < crossAxisCount && i < strength.length; i++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: strengthDataItem(
                        title: strength[i]['STRENGTH'],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FetchedCategoryProduct(selectedProductName: strength[i]['STRENGTH']),
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
              padding: EdgeInsets.all(8.0),
              height:  strength.length*100/crossAxisCount, // Fixed height for the additional items grid
              child: ListView.builder(
                scrollDirection: Axis.vertical, // Display items vertically
                itemCount:strength.length, // Calculate the number of rows
                itemBuilder: (context, rowIndex) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                    children: [
                      for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                        if (i < strength.length)
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter, // Align each card to the top
                              child: strengthDataItem(
                                title: strength[i]['STRENGTH'],
                                press: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FetchedCategoryProduct(selectedProductName: strength[i]['STRENGTH']),
                                    ),
                                  );
                                },

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
              height:  strength.length*100/crossAxisCount, // Fixed height for the additional items grid
              child: ListView.builder(
                scrollDirection: Axis.vertical, // Display items vertically
                itemCount: strength.length, // Calculate the number of rows
                itemBuilder: (context, rowIndex) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                    children: [
                      for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                        if (i < strength.length)
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter, // Align each card to the top
                              child: Padding(
                                padding:EdgeInsets.only(bottom: 7),
                                child: strengthDataItem(
                                  title: strength[i]['STRENGTH'],
                                  press: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FetchedCategoryProduct(selectedProductName: strength[i]['STRENGTH']),
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
                    MaterialPageRoute(builder: (context) => const StrengthScreen()),
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


class strengthDataItem extends StatefulWidget {
  final String title;
 // final String image;
  final Function() press;

  strengthDataItem({
    required this.title,
    //required this.image,
    required this.press,
  });

  @override
  _strengthDataItemState createState() => _strengthDataItemState();
}

class _strengthDataItemState extends State<strengthDataItem> {
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: isHovered ? [BoxShadow(color: kPrimaryColor.withOpacity(0.8), blurRadius: 10, offset: Offset(0, 5))] : [],
          color: kWhiteColor, // Change color on hover
          border: Border.all(
            color: Color(0xFFC9C9C9),  // Set the border color to grey
            width: 1.0, // Set the border width
          ),
        ),
        width: _size.width <= 770 ? _size.width / 2 : _size.width >= 975 ? 300 : 200,
        height: 160,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: widget.press,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child:
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
                //     return
                      Image.asset(
                       'strength.jpg',  // Path to default image
                      fit: BoxFit.fill,
                      width: 100, // Set width as needed
                      height: 100,
                    ),
                 // },
               // ),
              ),
              SizedBox(height: 10),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DMSans Regular',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isHovered ? kPrimaryColor : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
