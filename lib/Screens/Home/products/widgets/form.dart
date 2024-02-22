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
    final crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 5;
    return Column(
      children: [
        if (!showAllItems)
          Container(
            //padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                for (var i = 0; i < crossAxisCount && i < form.length; i++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: FormDataItem(
                        image: form[i]['IMAGE'],
                        title: form[i]['FORM'],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FetchedCategoryProduct(selectedProductName: form[i]['image']),
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
              height: form.length*100/crossAxisCount, // Fixed height for the additional items grid
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
                                padding:EdgeInsets.only(bottom: 7,left: 7),
                                child: FormDataItem(
                                  image: form[i]['IMAGE'],
                                  title: form[i]['FORM'],
                                  press: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FetchedCategoryProduct(selectedProductName: form[i]['image']),
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
                              child: FormDataItem(
                                image: form[i]['IMAGE'],
                                title: form[i]['FORM'],
                                press: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FetchedCategoryProduct(selectedProductName: form[i]['image']),
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
        Padding(
          padding: EdgeInsets.only(top: 10, right: 10), // Add right padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align children to the end (right side)
            children: [
              CustomButton(
                text: ( "SEE ALL"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FormScreen()),
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

class FormDataItem extends StatefulWidget {
  final String title;
  final String image;
  final Function() press;

  FormDataItem({required this.title, required this.image,required this.press});

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

                boxShadow: isHovered ? [kDefaultShadow] : [],
                borderRadius: BorderRadius.circular(15.0),
                color: kWhiteColor, // Change color on hover
                border: Border.all(
                  color: kgreyColor, // Set the border color to grey
                  width: 2.0,       // Set the border width
                ),
              ),
                child: Column(
                  children: [
                    // Add any widgets you want to display within the card, e.g., Text
                    Image.network(
                      widget.image,
                      width: 100, // Set width as needed
                      height: 100, // Set height as needed
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return  Image.asset(
                          'Form.webp', // Path to default image
                          fit: BoxFit.fill,
                          width: 100, // Set width as needed
                          height: 100,
                        );
                      },
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