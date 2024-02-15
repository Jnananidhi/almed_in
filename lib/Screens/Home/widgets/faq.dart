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
                   description: '''Non availability \nHigh cost \nAssured quality \nOvercome the competition ''',
                   press: () {}),
               ExpandableCard(
                   question: "How can I order in almed.in?",
                   description: '''Visit our website aimed in\nRegister (first time only)\nblace the order by searching molecule names.\nMake payment or select cash on delivery option.\n(You will get medicines within one hour''',
                   press: () {}),
               ExpandableCard(
                   question: "What is the self-ife of the medicines you supply?",
                   description: '''Most of the medicine in general have long self-life minimum 6 month to 1 year.''',
                   press: () {}),
               ExpandableCard(
                   question: "How do I cancel my order?",
                   description: '''You can cancel the order before or at the time of delivery. If Payment is made for such orders, refund will be processed to the payment source, if the order amount paid online''',
                   press: () {}),
               ExpandableCard(
                   question: "Where we serve?",
                   description: '''Our services are available in Bangalore city now and we will be extending soon other parts of Karnataka.''',
                   press: () {}),
               ExpandableCard(
                   question: "Do you supply patient directly?",
                   description: '''No. We are supplying only to the licensed retailers & Doctors(MBBS). Almed.in vision is to help the chemist.''',
                   press: () {}),
               ExpandableCard(
                   question: "How almed in products are chosen to list?",
                   description: '''We are giving you best quality product with minimum rate\nWe are giving least possible MRP product\nWe are giving least possible rate product of GMP manufacturing.''',
                   press: () {}),
               ExpandableCard(
                   question: "Do you refund for unsold or expiry products ?",
                   description: '''Mostly No. But in some cases, if the company gives us a refund, we  will refund as per norms.''',
                   press: () {}),
//                ExpandableCard(
//                    question: "Terms of Service",
//                    description: ''' ''',
//                    press: () {}),
//                ExpandableCard(
//                    question: "Privacy Policy",
//                    description: '''''',
//                    press: () {}),
//                ExpandableCard(
//                    question: "Refund Policy",
//                    description: ''' We understand that there will be genuine reasons when you decide to cancel or return an order.&nbsp; To process a return/cancel/refund, please raise a ticket on the Android / IOS app/ website for any issue within 4 days of delivery. No refunds will be processed beyond 4 days from the date of delivery.\n
// To be eligible for a return, your item must be unused and in the same condition that you received it. It must also be in the original packaging.\n
// We will process the return only if all products returned in an invoice, but not part of it.\n
// 4 days return policy may not apply, if Gov. or Drug controller department recalls any particular product, for reasons like NSQ or any other reason, we will take back such products and refund of such products as per norms.\n
// To complete your return, we require a receipt or proof of purchase.\n
// Please do not send your purchase back to the manufacturer.\n
// There are certain situations where only partial refunds are granted: (if applicable)\n
// Refunds (if applicable)\n
// Once your return is received and inspected, we will send you an email to notify you that we have received your returned item. We will also notify you of the approval or rejection of your return/refund.\n
// If you are approved, then your refund will be processed, and a credited automatically to your credit card or original method of payment, within a 15 amount of days.\n
// If the payment is made cash on delivery, in such cases refund will be processed to customer bank account.\n
// Late or missing refunds (if applicable)\n
// Then contact your credit card company, it may take some time before your refund is officially posted.\n
// Next contact your bank. There is often some processing time before a refund is posted.\n
// If you’ve done all of this and you still have not received your refund yet, please contact us at info@almed.in\n
// Only regular priced items may be refunded, unfortunately sale items cannot be refunded.\n''',
//                    press: () {}),
//                ExpandableCard(
//                    question: "Shipping Policy",
//                    description: '''''',
//                    press: () {}),

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
