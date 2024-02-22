import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar1.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kWhiteColor,
      //scrollable widget
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Image(image: AssetImage('assets/logo_rmbck.png'),height: 80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(

                    title: 'Home',
                    press: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    isActive: true,
                    title: 'About Us',
                    press: () {
                      Navigator.pushNamed(context, "/aboutAlmed.in");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'FAQ',
                    press: () {
                      Navigator.pushNamed(context, "/faq");

                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'Search Medicines',
                    press: () {
                      Navigator.pushNamed(context, "/alphabeticSearch");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'Seller?',
                    press: () {
                      Navigator.pushNamed(context, "/login");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuItems(
                    title: 'Contact Us',
                    press: () {Navigator.pushNamed(context, "contactUs");},
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      body: Stack(
          children:[ Column(
            children: <Widget>[
              const Navigation(),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //now we create menu and header
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: const Column(

                          children: <Widget>[
                            SizedBox(height: 20),
                            Text(
                              'Terms of Services',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "OVERVIEW",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "This website is operated by Almed.  Throughout the site, the terms “we”, “us” and “our” refer to Almed, Almed offers this website, including all information, tools and services available from this site to you, the user, conditioned upon your acceptance of all terms, conditions, policies and notices stated here.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "By visiting our site and/ or purchasing something from us, you engage in our “Service” and agree to be bound by the following terms and conditions (“Terms of Service”, “Terms”), including those additional terms and conditions and policies referenced herein and/or available by hyperlink. These Terms of Service apply  to all users of the site, including without limitation users who are browsers, vendors, customers, merchants, and/ or contributors of content.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Any new features or tools which are added to the current store shall also be subject to the Terms of Service. You can review the most current version of the Terms of Service at any time on this page. We reserve the right to update, change or replace any part of these Terms of Service by posting updates and/or changes to our website. It is your responsibility to check this page periodically for changes. Your continued use of or access to the website following the posting of any changes constitutes acceptance of those changes.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 1 – ONLINE STORE TERMS",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site. You may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws). You must not transmit any worms or viruses or any code of a destructive nature. A breach or violation of any of the Terms will result in an immediate termination of your Services.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 2 – GENERAL CONDITIONS",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We reserve the right to refuse service to anyone for any reason at any time. You understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; and (b) changes to confirm and adapt to technical requirements of connecting networks or devices. Credit card information is always encrypted during transfer over networks. You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the website through which the service is provided, without express written permission by us. The headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms. ",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 3 – ACCURACY, COMPLETENESS AND TIMELINESS OF INFORMATION",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We are not responsible if information made available on this site is not accurate, complete or current. The material on this site is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, more complete or more timely sources of information. Any reliance on the material on this site is at your own risk. This site may contain certain historical information. Historical information, necessarily, is not current and is provided for your reference only. We reserve the right to modify the contents of this site at any time, but we have no obligation to update any information on our site. You agree that it is your responsibility to monitor changes to our site.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 4 – MODIFICATIONS TO THE SERVICE AND PRICES",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Prices for our products are subject to change without notice. We reserve the right at any time to modify or discontinue the Service (or any part or content thereof) without notice at any time. We shall not be liable to you or to any third-party for any modification, price change, suspension or discontinuance of the Service.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 5 – PRODUCTS OR SERVICES",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Certain products or services may be available exclusively online through the website. These products or services may have limited quantities and are subject to return or exchange only according to our Return Policy.\n"
                                    "We have made every effort to display as accurately as possible the colors and images of our products that appear at the store. We cannot guarantee that your computer monitor’s display of any color will be accurate.\n"
                                    "We reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at anytime without notice, at the sole discretion of us. We reserve the right to discontinue any product at any time. Any offer for any product or service made on this site is void where prohibited."
                                    "We do not warrant that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 6 – ACCURACY OF BILLING AND ACCOUNT INFORMATION",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.\n"
                                    "You agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.\n"
                                    "For more detail, please review our Returns Policy.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 7 – OPTIONAL TOOLS",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "You acknowledge and agree that we provide access to such tools ”as is” and “as available” without any warranties, representations or conditions of any kind and without any endorsement. We shall have no liability whatsoever arising from or relating to your use of optional third-party tools.\n"
                                    "Any use by you of optional tools offered through the site is entirely at your own risk and discretion and you should ensure that you are familiar with and approve of the terms on which tools are provided by the relevant third-party provider(s).\n"
                                    "We may also, in the future, offer new services and/or features through the website (including, the release of new tools and resources). Such new features and/or services shall also be subject to these Terms of Service.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 8 – THIRD-PARTY LINKS",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Certain content, products and services available via our Service may include materials from third-parties.\n"
                                    "Third-party links on this site may direct you to third-party websites that are not affiliated with us. We are not responsible for examining or evaluating the content or accuracy and we do not warrant and will not have any liability or responsibility for any third-party materials or websites, or for any other materials, products, or services of third-parties.\n"
                                    "We are not liable for any harm or damages related to the purchase or use of goods, services, resources, content, or any other transactions made in connection with any third-party websites. Please review carefully the third-party’s policies and practices and make sure you understand them before you engage in any transaction. Complaints, claims, concerns, or questions regarding third-party products should be directed to the third-party.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 9 – USER COMMENTS, FEEDBACK AND OTHER SUBMISSIONS",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "If, at our request, you send certain specific submissions (for example contest entries) or without a request from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, ‘comments’), you agree that we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us. We are and shall be under no obligation (1) to maintain any comments in confidence; (2) to pay compensation for any comments; or (3) to respond to any comments.\n"
                                    "We may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party’s intellectual property or these Terms of Service.\n"
                                    "You agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that your comments will not contain libelous or otherwise unlawful, abusive or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as to the origin of any comments. You are solely responsible for any comments you make and their accuracy. We take no responsibility and assume no liability for any comments posted by you or any third-party.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 10 – PERSONAL INFORMATION",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Your submission of personal information through the store is governed by our Privacy Policy.\n",
                                    style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 11 – ERRORS, INACCURACIES AND OMISSIONS",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Occasionally there may be information on our site or in the Service that contains typographical errors, inaccuracies or omissions that may relate to product descriptions, pricing, promotions, offers, product shipping charges, transit times and availability. We reserve the right to correct any errors, inaccuracies or omissions, and to change or update information or cancel orders if any information in the Service or on any related website is inaccurate at any time without prior notice (including after you have submitted your order). We undertake no obligation to update, amend or clarify information in the Service or on any related website, including without limitation, pricing information, except as required by law. No specified update or refresh date applied in the Service or on any related website, should be taken to indicate that all information in the Service or on any related website has been modified or updated.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 12 – PROHIBITED USES",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "In addition to other prohibitions as set forth in the Terms of Service, you are prohibited from using the site or its content: (a) for any unlawful purpose; (b) to solicit others to perform or participate in any unlawful acts; (c) to violate any international, federal, provincial or state regulations, rules, laws, or local ordinances; (d) to infringe upon or violate our intellectual property rights or the intellectual property rights of others; (e) to harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate based on gender, sexual orientation, religion, ethnicity, race, age, national origin, or disability; (f) to submit false or misleading information; (g) to upload or transmit viruses or any other type of malicious code that will or may be used in any way that will affect the functionality or operation of the Service or of any related website, other websites, or the Internet; (h) to collect or track the personal information of others; (i) to spam, phish, pharm, pretext, spider, crawl, or scrape; (j) for any obscene or immoral purpose; or (k) to interfere with or circumvent the security features of the Service or any related website, other websites, or the Internet. We reserve the right to terminate your use of the Service or any related website for violating any of the prohibited uses.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 13 – DISCLAIMER OF WARRANTIES; LIMITATION OF LIABILITY",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We do not guarantee, represent or warrant that your use of our service will be uninterrupted, timely, secure or error-free. We do not warrant that the results that may be obtained from the use of the service will be accurate or reliable. You agree that from time to time we may remove the service for indefinite periods of time or cancel the service at any time, without notice to you. You expressly agree that your use of, or inability to use, the service is at your sole risk. The service and all products and services delivered to you through the service are (except as expressly stated by us) provided ‘as is’ and ‘as available’ for your use, without any representation, warranties or conditions of any kind, either express or implied, including all implied warranties or conditions of merchantability, merchantable quality, fitness for a particular purpose, durability, title, and non-infringement.\n"
                                    "In no case shall Almed, our directors, officers, employees, affiliates, agents, contractors, interns, suppliers, service providers or licensors be liable for any injury, loss, claim, or any direct, indirect, incidental, punitive, special, or consequential damages of any kind, including, without limitation lost profits, lost revenue, lost savings, loss of data, replacement costs, or any similar damages, whether based in contract, tort (including negligence), strict liability or otherwise, arising from your use of any of the service or any products procured using the service, or for any other claim related in any way to your use of the service or any product, including, but not limited to, any errors or omissions in any content, or any loss or damage of any kind incurred as a result of the use of the service or any content (or product) posted, transmitted, or otherwise made available via the service, even if advised of their possibility. Because some states or jurisdictions do not allow the exclusion or the limitation of liability for consequential or incidental damages, in such states or jurisdictions, our liability shall be limited to the maximum extent permitted by law.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 14 – INDEMNIFICATION",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "You agree to indemnify, defend and hold harmless Almed and our parent, subsidiaries, affiliates, partners, officers, directors, agents, contractors, licensors, service providers, subcontractors, suppliers, interns and employees, harmless from any claim or demand, including reasonable attorneys’ fees, made by any third-party due to or arising out of your breach of these Terms of Service or the documents they incorporate by reference, or your violation of any law or the rights of a third-party.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 15 – SEVERABILITY",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "In the event that any provision of these Terms of Service is determined to be unlawful, void or unenforceable, such provision shall nonetheless be enforceable to the fullest extent permitted by applicable law, and the unenforceable portion shall be deemed to be severed from these Terms of Service, such determination shall not affect the validity and enforceability of any other remaining provisions.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 16 – TERMINATION",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "The obligations and liabilities of the parties incurred prior to the termination date shall survive the termination of this agreement for all purposes. These Terms of Service are effective unless and until terminated by either you or us. You may terminate these Terms of Service at any time by notifying us that you no longer wish to use our Services, or when you cease using our site. If in our sole judgment you fail, or we suspect that you have failed, to comply with any term or provision of these Terms of Service, we also may terminate this agreement at any time without notice and you will remain liable for all amounts due up to and including the date of termination; and/or accordingly may deny you access to our Services (or any part thereof).",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 17 – ENTIRE AGREEMENT",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "The failure of us to exercise or enforce any right or provision of these Terms of Service shall not constitute a waiver of such right or provision. \n"
                                    "These Terms of Service and any policies or operating rules posted by us on this site or in respect to The Service constitutes the entire agreement and understanding between you and us and govern your use of the Service, superseding any prior or contemporaneous agreements, communications and proposals, whether oral or written, between you and us (including, but not limited to, any prior versions of the Terms of Service). Any ambiguities in the interpretation of these Terms of Service shall not be construed against the drafting party.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 18 – GOVERNING LAW",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "These Terms of Service and any separate agreements whereby we provide you Services shall be governed by and construed in accordance with the laws of India and jurisdiction of Bengaluru,Karnataka.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 19 – CHANGES TO TERMS OF SERVICE",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "You can review the most current version of the Terms of Service at any time at this page. We reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Service by posting updates and changes to our website. It is your responsibility to check our website periodically for changes. Your continued use of or access to our website or the Service following the posting of any changes to these Terms of Service constitutes acceptance of those changes.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECTION 20 – CONTACT INFORMATION",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Questions about the Terms of Service should be sent to us at info@almed.in.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Shopping policy",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We are operating only in Karnataka initially.  All our orders placed in almed.in are processed the same day.  In Bengaluru city, our deliveries are made within 4 hours.  And other cities it may take 1 to 3 working days.  And our deliveries are free in Bengaluru city but in other cities, a nominal shipping charge may be charged.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Delivery address",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Please note that we are unable to modify the delivery address once you have placed the orders.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Tracking your order",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Bold'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Once you are order has been dispatched we will send you a confirmation E-mail with tracking information.",
                                style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'DMSans Light'),
                              ),
                            ),
                            SizedBox(height: 20),


                          ],
                        ),
                      ),
                      const BottomNav()
                    ],
                    //now we create banner
                    //for this import packages

                    //now we will make our site responsive

                  ),
                ),
              ),

            ],
          ),
            Positioned(
              top: MediaQuery.of(context).size.width < 600
                  ? 90// Adjust the value for mobile view
                  :20,
              left: MediaQuery.of(context).size.width < 600
                  ? 0 // Adjust the value for mobile view
                  : MediaQuery.of(context).size.width * 0.22, // Adjust the value for desktop view
              right: MediaQuery.of(context).size.width < 600
                  ? 0 // Adjust the value for mobile view
                  : MediaQuery.of(context).size.width * 0.25,
              child: Search_bar1(),
            ),

          ]),
    );
  }
}
