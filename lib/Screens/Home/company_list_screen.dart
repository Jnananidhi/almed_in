import 'dart:convert';

import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  bool isHover = false;
  List form = [];
  bool showAllItems = true;

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
    final crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 5;
    return Stack(
      children:[ Column(
        children:<Widget>[
          Navigation(),
          // if (!showAllItems)
          //   Container(
          //     padding: EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         for (var i = 0; i < crossAxisCount && i < form.length; i++)
          //           Expanded(
          //             child: Padding(
          //               padding: EdgeInsets.only(right: 7),
          //               child: CompanyDataItem(
          //                 image: form[i]['image'],
          //                 title: form[i]['FORM'],
          //                 press: () {},
          //               ),
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),

          if (showAllItems)
            if( MediaQuery.of(context).size.width > 600)
    Expanded(
      child: SingleChildScrollView(
        child:Container(
                padding: EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height, // Fixed height for the additional items grid
                child: ListView.builder(
                  scrollDirection: Axis.vertical, // Display items vertically
                  itemCount: form.length, // Calculate the number of rows
                  itemBuilder: (context, rowIndex) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                      children: [
                        // for (var i = rowIndex * crossAxisCount + crossAxisCount; i < (rowIndex + 1) * crossAxisCount + crossAxisCount; i++)
                        for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                          if (i < form.length)
                            Expanded(
                              child: Align(
                                alignment: Alignment.topCenter, // Align each card to the top
                                child: Padding(
                                  padding:EdgeInsets.all(10),
                                  child: CompanyDataItem(
                                    image: form[i]['image'],
                                    title: form[i]['FORM'],
                                    press: (){
                                    },
                                  ),
                                ),
                              ),
                            ),

                      ],
                    );
                  },
                ),
              ),),),
          if (showAllItems)
            if( MediaQuery.of(context).size.width < 600)
              Container(
                padding: EdgeInsets.all(8.0),
                height: form.length*100/crossAxisCount, // Fixed height for the additional items grid
                child: ListView.builder(
                  scrollDirection: Axis.vertical, // Display items vertically
                  // itemCount: (form.length - crossAxisCount) ~/ crossAxisCount + 1, // Calculate the number of rows
                  itemCount: form.length,
                  itemBuilder: (context, rowIndex) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                      children: [
                        for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                          if (i < form.length)
                            Expanded(
                              child: Align(
                                alignment: Alignment.topCenter, // Align each card to the top
                                child: CompanyDataItem(
                                  image: form[i]['image'],
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
        ],
      ),],
    );
  }
}

class CompanyDataItem extends StatefulWidget {
  final String title;
  final String image;
  final Function() press;

  CompanyDataItem({required this.title, required this.image,required this.press});

  @override
  _CompanyDataItemState createState() => _CompanyDataItemState();
}

class _CompanyDataItemState extends State<CompanyDataItem> {

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
                ? _size.width/2
                : _size.width >= 975
                ? 300
                : 200,
            height: 160,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(40), // Adjust the radius as needed
                  child: Image.network(
                    widget.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover, // Use "cover" to fill the circular area
                  ),
                ),
                Text(widget.title,textAlign: TextAlign.center,style: TextStyle(fontFamily: 'DMSans Regular',fontSize: 18),),
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
      ),
    );
  }
}
