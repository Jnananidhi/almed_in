import 'dart:convert';

import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class FormScreen extends StatefulWidget {
  final String? selectedmenuitem;
  const FormScreen({super.key, this.selectedmenuitem});

  @override
  State<FormScreen> createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {
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
    return Material(
      child: Stack(
        children:[ Column(
          children:<Widget>[
            Navigation(),
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
        ),
          Positioned(
          top: MediaQuery.of(context).size.width < 600
              ? 90// Adjust the value for mobile view
              :50,
          left: MediaQuery.of(context).size.width < 600
              ? 0 // Adjust the value for mobile view
              : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
          right: MediaQuery.of(context).size.width < 600
              ? 0 // Adjust the value for mobile view
              : MediaQuery.of(context).size.width * 0.25,
          child: Search_bar(),
        ),],
      ),
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
                SizedBox(
                  height: 20,
                ),
                Text(widget.title,textAlign: TextAlign.center,style: TextStyle(fontFamily: 'DMSans Regular',fontSize: 18),),
               // Spacer(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: <Widget>[
                //     Icon(
                //       Icons.local_hospital, // You can use any medical icon here
                //       color: Colors.blue,
                //       size: 24,
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ThereapeauticScreen extends StatefulWidget {
  const ThereapeauticScreen({super.key});

  @override
  State<ThereapeauticScreen> createState() => ThereapeauticScreenState();
}

class ThereapeauticScreenState extends State<ThereapeauticScreen> {
  bool isHover = false;
  List therapeautic = [];
  bool showAllItems = true;

  Future getAllcategory() async {
    var url = "${api}therapeautic.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        therapeautic = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return therapeautic;
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
    return Material(
      child: Stack(
        children:[ Column(
          children:<Widget>[
            Navigation(),
             if( MediaQuery.of(context).size.width > 600)
                Expanded(
                  child: SingleChildScrollView(
                    child:Container(
                      padding: EdgeInsets.all(8.0),
                      height: MediaQuery.of(context).size.height, // Fixed height for the additional items grid
                      child: ListView.builder(
                        scrollDirection: Axis.vertical, // Display items vertically
                        itemCount: therapeautic.length, // Calculate the number of rows
                        itemBuilder: (context, rowIndex) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                            children: [
                              // for (var i = rowIndex * crossAxisCount + crossAxisCount; i < (rowIndex + 1) * crossAxisCount + crossAxisCount; i++)
                              for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                                if (i < therapeautic.length)
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topCenter, // Align each card to the top
                                      child: Padding(
                                        padding:EdgeInsets.all(10),
                                        child: DatabaseDataItem(
                                          title: therapeautic[i]['therapeautic'],
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
              if( MediaQuery.of(context).size.width < 600)
                Container(
                  padding: EdgeInsets.all(8.0),
                  height: therapeautic.length*100/crossAxisCount, // Fixed height for the additional items grid
                  child: ListView.builder(
                    scrollDirection: Axis.vertical, // Display items vertically
                    // itemCount: (form.length - crossAxisCount) ~/ crossAxisCount + 1, // Calculate the number of rows
                    itemCount: therapeautic.length,
                    itemBuilder: (context, rowIndex) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                        children: [
                          for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                            if (i < therapeautic.length)
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topCenter, // Align each card to the top
                                  child: DatabaseDataItem(
                                    title: therapeautic[i]['therapeautic'],
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
        ),
          Positioned(
            top: MediaQuery.of(context).size.width < 600
                ? 90// Adjust the value for mobile view
                :50,
            left: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
            right: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.25,
            child: Search_bar(),
          ),],
      ),
    );
  }
}

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => CompanyScreenState();
}

class CompanyScreenState extends State<CompanyScreen> {
  bool isHover = false;
  List company = [];
  bool showAllItems = false;

  Future getAllcategory() async {
    var url = "${api}almed_company.php";
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        company = jsonData;
      });
    }
    else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return company;
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
    return Material(
      child: Stack(
        children:[ Column(
          children:<Widget>[
            Navigation(),
              if( MediaQuery.of(context).size.width > 600)
                Expanded(
                  child: SingleChildScrollView(
                    child:Container(
                      padding: EdgeInsets.all(8.0),
                      height: MediaQuery.of(context).size.height, // Fixed height for the additional items grid
                      child: ListView.builder(
                        scrollDirection: Axis.vertical, // Display items vertically
                        itemCount: company.length, // Calculate the number of rows
                        itemBuilder: (context, rowIndex) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                            children: [
                              // for (var i = rowIndex * crossAxisCount + crossAxisCount; i < (rowIndex + 1) * crossAxisCount + crossAxisCount; i++)
                              for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                                if (i < company.length)
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topCenter, // Align each card to the top
                                      child: Padding(
                                        padding:EdgeInsets.all(10),
                                        child: DatabaseDataItem(
                                          title: company[i]['Company'],
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
              if( MediaQuery.of(context).size.width < 600)
                Container(
                  padding: EdgeInsets.all(8.0),
                  height: company.length*100/crossAxisCount, // Fixed height for the additional items grid
                  child: ListView.builder(
                    scrollDirection: Axis.vertical, // Display items vertically
                    // itemCount: (form.length - crossAxisCount) ~/ crossAxisCount + 1, // Calculate the number of rows
                    itemCount: company.length,
                    itemBuilder: (context, rowIndex) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                        children: [
                          for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                            if (i < company.length)
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topCenter, // Align each card to the top
                                  child: DatabaseDataItem(
                                    title: company[i]['Company'],
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
        ),
          Positioned(
          top: MediaQuery.of(context).size.width < 600
              ? 90// Adjust the value for mobile view
              :50,
          left: MediaQuery.of(context).size.width < 600
              ? 0 // Adjust the value for mobile view
              : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
          right: MediaQuery.of(context).size.width < 600
              ? 0 // Adjust the value for mobile view
              : MediaQuery.of(context).size.width * 0.25,
          child: Search_bar(),
        ),],
      ),
    );
  }
}


class StrengthScreen extends StatefulWidget {
  const StrengthScreen({super.key});

  @override
  State<StrengthScreen> createState() => StrengthScreenState();
}

class StrengthScreenState extends State<StrengthScreen> {
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
    return Material(
      child: Stack(
        children:[ Column(
          children:<Widget>[
            Navigation(),
            if( MediaQuery.of(context).size.width > 600)
              Expanded(
                child: SingleChildScrollView(
                  child:Container(
                    padding: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height, // Fixed height for the additional items grid
                    child: ListView.builder(
                      scrollDirection: Axis.vertical, // Display items vertically
                      itemCount: strength.length, // Calculate the number of rows
                      itemBuilder: (context, rowIndex) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                          children: [
                            // for (var i = rowIndex * crossAxisCount + crossAxisCount; i < (rowIndex + 1) * crossAxisCount + crossAxisCount; i++)
                            for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                              if (i < strength.length)
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topCenter, // Align each card to the top
                                    child: Padding(
                                      padding:EdgeInsets.all(10),
                                      child: DatabaseDataItem(
                                        title: strength[i]['STRENGTH'],
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
              if( MediaQuery.of(context).size.width < 600)
                Container(
                  padding: EdgeInsets.all(8.0),
                  height: strength.length*100/crossAxisCount, // Fixed height for the additional items grid
                  child: ListView.builder(
                    scrollDirection: Axis.vertical, // Display items vertically
                    // itemCount: (form.length - crossAxisCount) ~/ crossAxisCount + 1, // Calculate the number of rows
                    itemCount: strength.length,
                    itemBuilder: (context, rowIndex) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top of each row
                        children: [
                          for (var i = rowIndex * crossAxisCount ;i<rowIndex * crossAxisCount + crossAxisCount; i++)
                            if (i < strength.length)
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topCenter, // Align each card to the top
                                  child: DatabaseDataItem(
                                    title: strength[i]['STRENGTH'],
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
        ),
          Positioned(
            top: MediaQuery.of(context).size.width < 600
                ? 90// Adjust the value for mobile view
                :50,
            left: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
            right: MediaQuery.of(context).size.width < 600
                ? 0 // Adjust the value for mobile view
                : MediaQuery.of(context).size.width * 0.25,
            child: Search_bar(),
          ),],
      ),
    );
  }
}


//generalized card
class DatabaseDataItem extends StatefulWidget {
  final String title;
  final Function() press;

  DatabaseDataItem({required this.title, required this.press});

  @override
  _DatabaseDataItemState createState() => _DatabaseDataItemState();
}

class _DatabaseDataItemState extends State<DatabaseDataItem> {

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
              height: 100,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Add any widgets you want to display within the card, e.g., Text
                  Text(widget.title,textAlign: TextAlign.center,),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.health_and_safety, // You can use any medical icon here
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