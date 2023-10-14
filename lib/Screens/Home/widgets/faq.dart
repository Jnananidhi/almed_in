import 'package:flutter/material.dart';
import 'package:almed_in/responsive.dart';
import 'package:almed_in/responsive.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/Screens/Home/widgets/expandablecard.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
         if (Responsive.isDesktop(context))
           Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               ExpandableCard(
                   question: "Why ALMED?",
                   description: WhyAlmed,
                   press: () {}),
               ExpandableCard(
                   question: "Why chemist should order in almed.in?",
                   description: '''We have good coverage of all molecule contents of medicines and made available in almed.in. We have better quality products and margin. Our deliveries are very fast.''',
                   press: () {}),
               ExpandableCard(
                   question: "Why alternate medicines?",
                   description: '''Non availability \n High cost \n Assured quality \n Overcome the competition ''',
                   press: () {}),
               ExpandableCard(
                   question: "How can I order in almed.in?",
                   description: ''' Visit our website aimed in\nRegister (first time only)\nblace the order by searching molecule names.\nMake payment or select cash on delivery option.\n(You will get medicines within one hour''',
                   press: () {}),
               ExpandableCard(
                   question: "What is the self-ife of the medicines you supply?",
                   description: '''Most of the medicine in general have long self-life minimum 6 month to 1 year.''',
                   press: () {}),
               ExpandableCard(
                   question: "How do | cancel my order?",
                   description: ''' You can cancel the order before or at the time of delivery. If Payment is made for such orders, refund will be processed to the payment source, if the order amount paid online''',
                   press: () {}),
               ExpandableCard(
                   question: "Where we serve?",
                   description: ''' Our services are available in Bangalore city now and we will be extending soon other parts of Karnataka.''',
                   press: () {}),
               ExpandableCard(
                   question: "Do you supply patient directly?",
                   description: ''' No. We are supplying only to the licensed retailers & Doctors(MBBS). Almed.in vision is to help the chemist.''',
                   press: () {}),
               ExpandableCard(
                   question: "How almed in products are chosen to list?",
                   description: ''' We are giving you best quality product with minimum rate\nWe are giving least possible MRP product\nWe are giving least possible rate product of GMP manufacturing.''',
                   press: () {}),
               ExpandableCard(
                   question: "Do you refund for unsold or expiry products ?",
                   description: ''' Mostly No. But in some cases, if the company gives us a refund, we will refund as per norms.''',
                   press: () {}),


             ],
           ),
         if (!Responsive.isDesktop(context))
           Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               ExpandableCard(
                   question: "Why ALMED?",
                   description: WhyAlmed,
                   press: () {}),
               ExpandableCard(
                   question: "Why chemist should order in almed.in?",
                   description: '''We have good coverage of all molecule contents of medicines and made available in almed.in. We have better quality products and margin. Our deliveries are very fast.''',
                   press: () {}),
               ExpandableCard(
                   question: "Why alternate medicines?",
                   description: ''' Non availability \n High cost \n Assured quality \n Overcome the competition ''',
                   press: () {}),
               ExpandableCard(
                   question: "How can I order in almed.in?",
                   description: ''' Visit our website aimed in\nRegister (first time only)\nblace the order by searching molecule names.\nMake payment or select cash on delivery option.\n(You will get medicines within one hour''',
                   press: () {}),
               ExpandableCard(
                   question: "What is the self-ife of the medicines you supply?",
                   description: '''Most of the medicine in general have long self-life minimum 6 month to 1 year.''',
                   press: () {}),
               ExpandableCard(
                   question: "How do | cancel my order?",
                   description: ''' You can cancel the order before or at the time of delivery. If Payment is made for such orders, refund will be processed to the payment source, if the order amount paid online''',
                   press: () {}),
               ExpandableCard(
                   question: "Where we serve?",
                   description: ''' Our services are available in Bangalore city now and we will be extending soon other parts of Karnataka.''',
                   press: () {}),
               ExpandableCard(
                   question: "Do you supply patient directly?",
                   description: ''' No. We are supplying only to the licensed retailers & Doctors(MBBS). Almed.in vision is to help the chemist.''',
                   press: () {}),
               ExpandableCard(
                   question: "How almed in products are chosen to list?",
                   description: ''' We are giving you best quality product with minimum rate\nWe are giving least possible MRP product\nWe are giving least possible rate product of GMP manufacturing.''',
                   press: () {}),
               ExpandableCard(
                   question: "Do you refund for unsold or expiry products ?",
                   description: ''' Mostly No. But in some cases, if the company gives us a refund, we will refund as per norms.''',
                   press: () {}),

             ],
           ),
       ],

    );
  }
}
