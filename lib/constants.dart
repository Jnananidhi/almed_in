import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//color
const kPrimaryColor = Color(0xff372e86);
const kSecondaryColor = Color(0xFF00AFBB);
const lightColor =Color(0xFFEEF4FF);
const kDarkblueColor = Color(0xff25396f);
const kgreyColor = Color(0xfff1f1f1);
const kDarkgreyColor = Color(0xff8d91a7);
const kWhiteColor = Color(0xffffffff);

const kDefaultPadding = 20.0;
const kMaxWidth = 1232.0;
const kDefaultDuration = Duration(milliseconds: 250);

//our product shadow
final kDefaultShadow = BoxShadow(
  offset: const Offset(0, 10),
  spreadRadius: 5,
  blurRadius: 20,
  color: const Color(0xFF0700B1).withOpacity(0.15),
);

//const String api = "api/"; //for server
const String api = 'http://localhost/almed/';
const String GMAP_API ="AIzaSyCOucQzY-nsUsDumyl8M1HjP-wGqTClB-M";
 
const String aboutus = '''Almed.in is India's first online B28 marketplace for all content medicines. We have more than 800 molecule contents and about 3000 of their extensions.
That means you can search product by its contents, we will suggest you alternative brands. These suggestions are carefully done by experienced 
professionals, based on preference like quality, price, & MRP. Each content may have options to select as per your customer needs. At Almed.in you can 
get a wide variety of medicines ranging from Anti diabetic, Anti-infective, Cardiology, Nephrology, Dermatology, Gynaecology, Oncology, Gastrology, ENT,
Ophthalmology, Vitamins, Supplements, Vaccines and Blood Products. 
Almed.in believes correct medicine at right time is most important than non-available particular brand. 
Almed.in has product collection from various sources like quality generics, branded, and all speciality medicines to complete the range. 
Almed.in is unique in...

« All content medicines, 

« Faster services, 

« Latest easy e-com buying.

Please note that Almed.in is only for the retailers not to the patients directly. 
Almed.in is brought to you by Zenex International most trusted speciality pharma distributor in Bengaluru since 2002 ''';

const String WhyAlmed = '''Medical shop's common problems like,

« Prescription bounce due to non-availability of a particular brand.
« Competition from chain stores, online shops, and generic shops.
« Missing products in the orders.
« Accurate information & availability of new products in the market.
« Worried about the quality of generic medicines.

The non-availability of medicine brands is also a factor in these rising costs. Hence, by having suitable alternatives, you can easily switch to the next best option.
This makes it more feasible and cost-effective.

We believe that everyone should get access to medicine no matter their income.
The cost of branded medicines is higher than the molecular alternatives. With an extensive range of 3000+ molecules of these branded medicines, we have the
best price that you will need. We provide''';

