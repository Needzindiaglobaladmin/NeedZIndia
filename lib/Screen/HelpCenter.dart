import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('Customer Support',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Text('Payment related queries',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87),),textAlign: TextAlign.start,),
              ),
              Container(
                color: Colors.white,
                child:Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child:  Text('Currently, we are accepting only two payment options which are POD (pay online at your door) and COD (Cash on delivery). If you choose POD at the time of ordering then you can pay us online at your door using any payment app as per your preference.',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                )
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Text('Delivery related queries',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87),),textAlign: TextAlign.start,),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('Do you charge for delivery?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child:  Text('Yes, we do but it depends upon your order value. If you order value is above the specified minimum amount then you will be eligible for free delivery.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('What is your delivery time?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child:  Text('We deliver your order within 24 hours. It can delay if some internal error occurs.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Text('Cancellation related queries',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87),),textAlign: TextAlign.start,),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('Can I cancel my order and booking?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child:  Text('Cancellation is only applicable for booking. Currently we are not offering order cancellation.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Text('General queries',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87),),textAlign: TextAlign.start,),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('What cities do you operate in?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child:  Text('NeedZ India currently operates in Kuntighat, Tribeni, Mogra, Bansberia, Bandel, Hooghly and Chuchura.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('Do you deliver in my location?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child:  Text('We deliver in selected localities across the cities we are present in. You can edit location in homepage to check if we deliver in your area.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('What is the minimum order value?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                      child:  Text('There is no minimum order value.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: Text('Do you charge any amount or taxes over and above the rates shown?',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child:  Text('No, we do not charge anything over and above the rates shown. However, we do have a delivery fee in case the order does not reach the minimum order value for free delivery.',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Text('For more queries',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87),),textAlign: TextAlign.start,),
              ),
              Container(
                alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child:Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child:  Text('Reach us at: +91 7439551502 / +91 6289222486',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                  )
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child:Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child:  Text('Mail us at: customersupport@needzindia.com',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blueGrey),),),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}