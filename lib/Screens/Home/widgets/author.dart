import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:almed_in/responsive.dart';

import 'package:almed_in/constants.dart';

//copy all data
class Author extends StatelessWidget {
  const Author({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Responsive.isDesktop(context))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryCard(
                  image: "assets/products/users/pharmacy.png",
                  title: 'M.S.R Pharma',
                  description: '''Almed in is perhaps the only pharmaceutical distributor to stock up every available variety of Quality generic drugs currently on offer in the market. What makes Almed in an absolute favorite is the availability of an exhaustive range of medicines at best price. What you people won't find anywhere else, you'll find on Almed.in''',
                 ),
              CategoryCard(
                  image: "assets/products/users/pharmacy.png",
                  title: 'Sridhar Medicals',
                  description: '''As an online medicine distribution platform, Almed in is our most preferred choice, especially since the delivery process is so fast and easy. It has the fastest delivery of medicines we have experienced. This is important for us since this ensures that even the most uncommon of generic drug components are delivered within a short span of time.''',
                 ),
              CategoryCard(
                  image: "assets/products/users/pharmacy.png",
                  title: 'Maruthi Medicals',
                  description: '''Almed in never fails to surprise us when it comes to delivering medicines, even the most atypical ones, that too, at a break-neck speed. We were looking for particular capsules and syrups urgently and had approached many companies for the same. But it was Almed in that came to our rescue by supplying the products within a mere hour.''',
                  ),
            ],
          ),
        if (!Responsive.isDesktop(context))
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryCard(
                  image: "assets/products/users/pharmacy.png",
                  title: 'M.S.R Pharma',
                  description: '''Almed in is perhaps the only pharmaceutical distributor to stock up every available variety of Quality generic drugs currently on offer in the market. What makes Almed in an absolute favorite is the availability of an exhaustive range of medicines at best price. What you people won't find anywhere else, you'll find on Almed.in''',
                  ),
              CategoryCard(
                  image: "assets/products/users/pharmacy.png",
                  title: 'Sridhar Medicals',
                  description: ''' As an online medicine distribution platform, Almed in is our most preferred choice, especially since the delivery process is so fast and easy. It has the fastest delivery of medicines we have experienced. This is important for us since this ensures that even the most uncommon of generic drug components are delivered within a short span of time. The right medicine at the right time can save lives and no one understands it better than Almed.in.''',
                  ),
              CategoryCard(
                  image: "assets/products/users/pharmacy.png",
                  title: 'Maruthi Medicals',
                  description: '''Almed in never fails to surprise us when it comes to delivering medicines, even the most atypical ones, that too, at a break-neck speed. We were looking for particular capsules and syrups urgently and had approached many companies for the same. But it was Almed in that came to our rescue by supplying the products within a mere hour.''',
                 ),
            ],
          ),
      ],
    );
  }
}

class CategoryCard extends StatefulWidget {

  const CategoryCard({
    Key? key,
    required this.image,
    required this.title,

    required this.description,
  }) : super(key: key);
  final String image, title, description;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return InkWell(
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      child: Container(
        width: _size.width <= 770
            ? _size.width
            : _size.width >= 975
                ?kMaxWidth/3
                : 200,
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
                color:  lightColor,// Adjust the value as needed
            ),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: _size.width >= 370 ? 18 : 11,color: kPrimaryColor),
            ),
            const SizedBox(
              height: 15,
            ),

        Padding(
          padding:  const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.format_quote_rounded,
              color: kSecondaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            widget.description,textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16,fontFamily: 'DMSans Regular',height: 1.5),
          ),),
            const SizedBox(
              height: 15,
            ),

          ],
        ),
      ),
    );
  }
}
