import 'dart:async';
import 'package:NeedZIndia/Class/SlotBookingResponse.dart';
import 'package:NeedZIndia/Homepage/Homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';




class SlotBookedDetails extends StatefulWidget {
  final SlotBookingData bookingDetails;
  SlotBookedDetails({Key key, this.bookingDetails}) : super(key: key );
  @override
  _SlotBookedDetails createState() => _SlotBookedDetails();
}

class _SlotBookedDetails extends State<SlotBookedDetails> {
  bool loading = true;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      if(mounted){
        setState(() {
          loading = false;
        });
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        titleSpacing: 0,
        title: FittedBox(fit: BoxFit.fitWidth,
          child: Text('Booking details', style: GoogleFonts.quicksand()),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body: loading?  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) : WillPopScope(
        onWillPop: () async =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Homepage()), (e) => false),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Center(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/images/success.png'),
                        ),
                        Text('Slot Booked Successfully!!',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey,fontWeight: FontWeight.w700),),),
                        SizedBox(height: 2,),
                        Container(
                          child: Text('Thank you for booking with us.',style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),textAlign: TextAlign.center,),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                    color: Colors.white,
                    child:Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(20,10,0,10),
                            child: Icon(Icons.delivery_dining,color: Colors.blueGrey,size: 30,),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                              alignment: Alignment.topLeft,
                              child:Text('Booking Dispatch Date',style: GoogleFonts.quicksand(
                                textStyle: TextStyle(fontSize: 21,color: Colors.blueGrey,fontWeight: FontWeight.w700),),)
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(50, 6, 0, 10),
                          alignment: Alignment.topLeft,
                          child:Text(DateFormat("EEE, d MMM yyyy").format(DateTime.parse(widget.bookingDetails.serviceDispatchingDate)),style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.w700),),)
                      ),
                    ],)
                ),
                SizedBox(height: 5,),
                Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 0.5,
                                child: Container(color: Colors.blueGrey[200],),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                alignment: Alignment.topLeft,
                                child: Text('Booking ID - '+ widget.bookingDetails.serviceBookingId.toString(),style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),),
                              ),
                              SizedBox(
                                height: 0.5,
                                child: Container(color: Colors.blueGrey[200],),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 0.5,
                                child: Container(color: Colors.blueGrey[200],),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                alignment: Alignment.topLeft,
                                child: Text('Service Details',style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),),
                              ),
                              SizedBox(
                                height: 0.5,
                                child: Container(color: Colors.blueGrey[200],),
                              ),
                              Container(
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 15, 0, 5),
                                      alignment: Alignment.topLeft,
                                      child: Text(widget.bookingDetails.serviceName,style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(fontSize: 20,),fontWeight: FontWeight.w600),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      alignment: Alignment.topLeft,
                                      child: Text("Time Slot: "+ widget.bookingDetails.timeSlotName,
                                        style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(fontSize: 18,color: Colors.blueGrey),),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      alignment: Alignment.topLeft,
                                      child: Text("Number of Persons: "+ widget.bookingDetails.numOfPersons.toString(),
                                        style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(fontSize: 18,color: Colors.blueGrey),),),
                                    ),
                                    SizedBox(height: 15,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    )
                ),
                SizedBox(height: 2,),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 15, 0, 5),
                        alignment: Alignment.topLeft,
                        child: Text('Booking Address',style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 22,),fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 8, 0, 8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              alignment: Alignment.topLeft,
                              child:Text(toBeginningOfSentenceCase(
                                  widget.bookingDetails.shippingAddress.name.toUpperCase() +' , '+widget.bookingDetails.shippingAddress.mobileNumber
                              ),
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                textAlign: TextAlign.left,),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(toBeginningOfSentenceCase(
                                        widget.bookingDetails.shippingAddress.street.toUpperCase(),','),
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                    child: Text(toBeginningOfSentenceCase(
                                        widget.bookingDetails.shippingAddress.landmark.toUpperCase() + ","),
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                    child: Text(toBeginningOfSentenceCase(
                                        widget.bookingDetails.shippingAddress.district.toUpperCase() + ","),
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                    child: Text(toBeginningOfSentenceCase(
                                        widget.bookingDetails.shippingAddress.city.toUpperCase() + ","),
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                    child: Text(toBeginningOfSentenceCase(
                                        widget.bookingDetails.shippingAddress.pincode + ","),
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                    child: Text(toBeginningOfSentenceCase(
                                        widget.bookingDetails.shippingAddress.country.toUpperCase()),
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                    child: widget.bookingDetails.shippingAddress.alternateMobileNumber.isEmpty == true?Text(''):Text(toBeginningOfSentenceCase(','+
                                        widget.bookingDetails.shippingAddress.alternateMobileNumber),
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                  ),
                                ],
                              ),
                            ),
                          ],

                        ),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 15, 0, 20),
                    alignment: Alignment.topLeft,
                    child: Text('Service Charge - ₹'+ widget.bookingDetails.totalBookingAmount.toString(),style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,color: Colors.black),fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 15, 0, 20),
                        alignment: Alignment.topLeft,
                        child: Text('Payment mode - '+ widget.bookingDetails.paymentMode.toUpperCase(),style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18,),fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}