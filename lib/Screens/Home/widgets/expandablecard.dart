
import 'package:flutter/material.dart';
import 'package:almed_in/responsive.dart';
import 'package:almed_in/constants.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class ExpandableCard extends StatefulWidget {
  const ExpandableCard({
    Key? key,
    required this.question,
    required this.description,
    required this.press,

  }) : super(key: key);
  final String question,description;
  final VoidCallback press;

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return  Container(
      color: kWhiteColor,
      width: double.infinity,
      child: Column(
        children: [
      Container(
      constraints: const BoxConstraints(
      maxWidth: kMaxWidth,
      ),
      child: Column(
          children: [
      Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child:Center(
      child: ExpansionTileCard(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.question,
            style: const TextStyle(
              fontSize: 20,
              fontFamily:'DMSans SemiBold' ,
              color: Colors.black,
            ),
          ),
        ],
      ),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.description, textAlign: TextAlign.left,
                style: const TextStyle(fontFamily:'DMSans Regular' ,fontSize: 18, color: Colors.black, )),
          )
        ],
      ),
      ),
    )]))]));
  }
}
