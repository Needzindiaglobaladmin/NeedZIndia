import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('About us',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                child: Text('About us',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 26),),),
              ),
              Container(
                height: 1,
                color: Colors.cyan,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                child: Text('NeedZ India is an upcoming online shopping application build to make people\'s life easier. You can shop for your daily needs from NeedZ India. We have various range of grocery products. We also provide PAN and Passport services just book a slot and we will be at your place to assist you for the mentioned services. The domain needzindia.com is owned by us.',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 18,color: Colors.blueGrey),),textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                child: Text('Privacy policy',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 26),),),
              ),
              Container(
                height: 1,
                color: Colors.cyan,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                child: Text('NeedZ India is the licensed owner of the brand NeedZ India and the application NeedZ India respects your privacy. This Privacy Policy provides succinctly the manner your data is collected and used by NeedZ India on the Site. As a visitor to the Site/ Customer you are advised to please read the Privacy Policy carefully. By accessing the services provided by the Site you agree to the collection and use of your data by NeedZ India in the manner provided in this Privacy Policy.',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 18,color: Colors.blueGrey),),textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('What information is, or may be, collected form you?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text('As part of the registration process on the App, NeedZ India may collect the following personally identifiable information about you: Name including first and last name, alternate email address, mobile phone number and contact details, Postal code, Demographic profile (like your age, gender, occupation, education, address etc.) and information about the pages on the App you visit/access, the links you click on the App, the number of times you access the page and any such browsing information.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('How do we Collect the Information ?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text('NeedZ India  will collect personally identifiable information about you only as part of a voluntary registration process, on-line survey or any combination thereof. The Site may contain links to other Web sites. NeedZ India is not responsible for the privacy practices of such Web sites which it does not own, manage or control. The Site and third-party vendors, including Google, use first-party cookies (such as the Google Analytics cookie) and third-party cookies (such as the DoubleClick cookie) together to inform, optimize, and serve ads based on someone\'s past visits to the Site.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('How is information used ?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text('NeedZ India will use your personal information to provide personalized features to you on the Site and to provide for promotional offers to you through the Site and other channels. NeedZ India will also provide this information to its business associates and partners to get in touch with you when necessary to provide the services requested by you. NeedZ India will use this information to preserve transaction history as governed by existing law or policy. NeedZ India may also use contact information internally to direct its efforts for product improvement, to contact you as a survey respondent, to notify you if you win any contest; and to send you promotional materials from its contest sponsors or advertisers. NeedZ India will also use this information to serve various promotional and advertising materials to you via display advertisements through the Google Ad network on third party websites. You can opt out of Google Analytics for Display Advertising and customize Google Display network ads using the Ads Preferences Manager. Information about Customers on an aggregate (exlcuding any information that may identify you specifically) covering Customer transaction data and Customer demographic and location data may be provided to partners of NeedZ India for the purpose of creating additional features on the application, creating appropriate merchandising or creating new products and services and conducting marketing research and statistical analysis of customer behaviour and transactions.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('With whom your information will be shared?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text('NeedZ India will not use your financial information for any purpose other than to complete a transaction with you. NeedZ India does not rent, sell or share your personal information and will not disclose any of your personally identifiable information to third parties. In cases where it has your permission to provide products or services you\'ve requested and such information is necessary to provide these products or services the information may be shared with NeedZ India\'s business associates and partners. NeedZ India may, however, share consumer information on an aggregate with its partners or third parties where it deems necessary. In addition NeedZ India may use this information for promotional offers, to help investigate, prevent or take action regarding unlawful and illegal activities, suspected fraud, potential threat to the safety or security of any person, violations of the Site\'s terms of use or to defend against legal claims, special circumstances such as compliance with subpoenas, court orders, requests/order from legal authorities or law enforcement agencies requiring such disclosure.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('What Choice are available to you regarding collection, use and distribution of your information ?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text('To protect against the loss, misuse and alteration of the information under its control, NeedZ India has in place appropriate physical, electronic and managerial procedures. For example, NeedZ India servers are accessible only to authorized personnel and your information is shared with employees and authorised personnel on a need to know basis to complete the transaction and to provide the services requested by you. Although NeedZ India will endeavour to safeguard the confidentiality of your personally identifiable information, transmissions made by means of the Internet cannot be made absolutely secure. By using this site, you agree that NeedZ India will have no liability for disclosure of your information due to errors in transmission or unauthorized acts of third parties.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('How can you correct inaccuracies in the information ?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text('To correct or update any information you have provided, the Site allows you to do it online. ',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('Policy updates',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text('NeedZ India reserves the right to change or update this policy at any time. Such changes shall be effective immediately upon posting to the Site.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                child: Text('Contact Information',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 26),),),
              ),
              Container(
                height: 1,
                color: Colors.cyan,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10,10,0,5),
                child: Text('NeedZ India,',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),textAlign: TextAlign.center,),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                child: Text('Tribeni, Hooghly, India',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),textAlign: TextAlign.center,),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                child: Text('Mobile: +91 7439551502 / 6289222486',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),textAlign: TextAlign.center,),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                child: Text('Email id: customersupport@needzindia.com',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey),),textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
