import 'dart:convert';
import 'dart:io';
import 'package:NeedZIndia/Class/GetAddress.dart';
import 'package:NeedZIndia/Screen/CheckoutAddAddress.dart';
import 'package:NeedZIndia/Screen/PaymentOptions.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';



class SelectAddress extends StatefulWidget {
  final double mrp;
  final int quantity;
  final double discount;
  final double totalAmount;
  final String deliveryCharges;
  final List cartIds;
  final String specialDiscount;
  final String coupon;
  final String previousPage;
  final String bookingDate;
  final String timeSlotId;
  final int serviceId;
  final int pricePerPerson;
  final int numberOfPerson;
  SelectAddress({Key key, this.mrp,this.quantity,this.discount,this.totalAmount,this.deliveryCharges,this.cartIds,this.specialDiscount,
    this.coupon,this.previousPage,this.bookingDate,this.timeSlotId,this.serviceId,this.pricePerPerson,this.numberOfPerson}) : super(key: key );
  @override
  _SelectAddress createState() => _SelectAddress();
}

class _SelectAddress extends State<SelectAddress> {
  final String url =Constant.GET_ADDRESS_API;
  List<GetAddressData> data;
  var list;
  var random;
  bool loading = true;
  String radioItem = '';
  int quantity =0;
  int numberOfPerson ;
  @override
  void initState() {
    super.initState();
    print(widget.cartIds);
    quantity = widget.quantity;
    if(widget.previousPage=='SlotBooking'){
      numberOfPerson = widget.numberOfPerson * widget.pricePerPerson;
    }
    print(numberOfPerson);
    this.getJsonData();
  }

  Future<GetAddressResponse> getJsonData() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var mobile = _prefs.getString('mobile');
    try{
      //showAlertDialog(context);
      final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
          headers: <String, String>{HttpHeaders.authorizationHeader: token,
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          }, body: {'mobile': mobile}
      );
      //Navigator.pop(context);
      print(response.body);
      var responseAdd = GetAddressResponse.fromJson(json.decode(response.body));
      if (responseAdd.success == true) {
        print('response body : ${response.body}');
        if(mounted){
          setState(() {
            data = responseAdd.data;
            loading= false;
          });
        }
        return responseAdd;
      } else {
        print(responseAdd.userFriendlyMessage);
      }
    }on Exception catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.cyan[600],
          titleSpacing: 0.0,
          title: FittedBox(fit: BoxFit.fitWidth,
            child: Text('Select Address', style: GoogleFonts.quicksand(
              textStyle: TextStyle(fontSize: 22),),),
          ),
        ),
        body:loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) :
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: RaisedButton(
                  color: Colors.white,
                  child: Text('+ Add Address',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize:18,color: Colors.cyan[600],fontWeight: FontWeight.bold),),textAlign: TextAlign.left,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckoutAddAddress(
                        mrp:widget.mrp,
                        quantity:widget.quantity,discount:widget.discount,deliveryCharges:widget.deliveryCharges,
                        totalAmount:widget.totalAmount,cartIds: widget.cartIds,specialDiscount:widget.specialDiscount,coupon:widget.coupon,
                        serviceId: widget.serviceId,bookingDate:widget.bookingDate,timeSlotId:widget.timeSlotId,previousPage: widget.previousPage,bookingAmount:widget.pricePerPerson,persons :widget.numberOfPerson
                    )),
                    );
                  },
                ),
              ),
              ListView.builder(
                  physics: new BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.isEmpty == true ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10,),
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blueGrey,
                                      width: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      RadioListTile(
                                        activeColor: Colors.cyan[600],
                                        groupValue: radioItem,
                                        title: Container(
                                          margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                                alignment: Alignment.topLeft,
                                                child:Text(toBeginningOfSentenceCase(
                                                    data[index].name),
                                                  style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                  textAlign: TextAlign.left,),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Wrap(
                                                  children: <Widget>[
                                                    Container(
                                                      // margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                      child: Text(toBeginningOfSentenceCase(
                                                          data[index].street + ","),
                                                        style: GoogleFonts.quicksand(
                                                          textStyle: TextStyle(fontSize: 18),),),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                                      child: Text(toBeginningOfSentenceCase(
                                                          data[index].landmark + ","),
                                                        style: GoogleFonts.quicksand(
                                                          textStyle: TextStyle(fontSize: 18),),),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                                      child: Text(toBeginningOfSentenceCase(
                                                          data[index].district + ","),
                                                        style: GoogleFonts.quicksand(
                                                          textStyle: TextStyle(fontSize: 18),),),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                                      child: Text(toBeginningOfSentenceCase(
                                                          data[index].city + ","),
                                                        style: GoogleFonts.quicksand(
                                                          textStyle: TextStyle(fontSize: 18),),),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                                      child: Text(toBeginningOfSentenceCase(
                                                          data[index].state + ","),
                                                        style: GoogleFonts.quicksand(
                                                          textStyle: TextStyle(fontSize: 18),),),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                                      child: Text(toBeginningOfSentenceCase(
                                                          data[index].country),
                                                        style: GoogleFonts.quicksand(
                                                          textStyle: TextStyle(fontSize: 18),),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                //margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                                child: Text(toBeginningOfSentenceCase(
                                                    data[index].mobileNumber),
                                                  style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(fontSize: 18),),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        value: data[index].id.toString(),
                                        onChanged: (val) {
                                          setState(() {
                                            radioItem = val;
                                            print(radioItem);
                                          });
                                        },
                                      ),
                                    ],
                                  )
                              ),
                              SizedBox(height: 2,),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
              widget.previousPage == 'cart'?
              Container(
                margin: EdgeInsets.fromLTRB(5, 4, 5, 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 0.2,
                  ),
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5),
                      alignment:Alignment.centerLeft,
                      child: Text("Price details " + "($quantity items)",style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),textAlign: TextAlign.left,),
                    ),
                    SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                    SizedBox(height: 5,),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Total MRP:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Discount:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Delivery Charges:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ),
                                widget.specialDiscount != '-1'?
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Coupon discount:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ):Container(),
                                SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                                SizedBox(height: 6,),
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Total Amount:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),)
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                                    alignment:Alignment.centerRight,
                                    child: Text("₹" + widget.mrp.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                                    alignment:Alignment.centerRight,
                                    child: Text("₹" + widget.discount.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,color: Colors.lightBlueAccent),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                                    alignment:Alignment.centerRight,
                                    child: Text(widget.deliveryCharges ?? null,style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,color: Colors.lightBlue),),)
                                ),
                                widget.specialDiscount != '-1'?
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                                    alignment:Alignment.centerRight,
                                    child: Text('-₹'+widget.specialDiscount.toString(),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,color: Colors.green),),)
                                ):Container(),
                                SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                                SizedBox(height: 6,),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                                    alignment:Alignment.centerRight,
                                    child: Text("₹" + widget.totalAmount.toStringAsFixed(2) ?? null,style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),)
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ): Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 15, 0, 20),
                  alignment: Alignment.topLeft,
                  child: Text('Service Charge - ₹'+ numberOfPerson.toString(),style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 18,color: Colors.black),fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(height:80),
            ],
          ),
        ),
      bottomSheet: Container(
        height: 40,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          color: Colors.cyan[600],
          child: widget.previousPage == 'cart'? Text('Proceed to Checkout',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 15,color: Colors.white),),):Text('Proceed to Book',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 15,color: Colors.white),),),
          onPressed: (){
            if(radioItem.isEmpty==true){
              Toast.show('Select Address', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
            }
            else{
              print(widget.cartIds);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentOptions(addressId: radioItem,
                cartIds: widget.cartIds,totalAmount: widget.totalAmount,coupon: widget.coupon,
                  serviceId: widget.serviceId,bookingDate:widget.bookingDate,timeSlotId:widget.timeSlotId,previousPage: widget.previousPage,bookingAmount:numberOfPerson.toString(), persons :widget.numberOfPerson),),);
            }
          },
        ),
      ),
    );
  }
}
