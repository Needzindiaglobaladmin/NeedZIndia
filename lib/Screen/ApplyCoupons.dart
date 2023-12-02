import 'dart:convert';
import 'dart:io';

import 'package:NeedZIndia/Class/GetCoupons.dart';
import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
class ApplyCoupons extends StatefulWidget {
  final double totalAmount;
  ApplyCoupons({Key key, this.totalAmount}) : super(key: key );
  @override
  _ApplyCoupons createState() => _ApplyCoupons();
}

class _ApplyCoupons extends State<ApplyCoupons> {
  List<GetCouponsData> coupons = [];
  bool loading = true;
  final couponController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.getCoupon();
  }

  @override
  void dispose(){
    couponController.dispose();
    super.dispose();
  }

  Future<GetCouponsResponse> getCoupon() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try{
      final url = Constant.GET_COUPONS_API;
      final response = await http.get(Uri.parse(Constant.apiShort_Url+ url),
        headers: <String, String>{HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      print("${response.body}");
      var response1 = GetCouponsResponse.fromJson(json.decode(response.body));
      if (response1.success == true) {
        if(mounted){
          setState(() {
            coupons = response1.data;
            loading = false;
          });
        }
        return response1;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response1.userFriendlyMessage),
            backgroundColor: Colors.red));
        if(mounted){
          setState(() {
            loading = false;
          });
        }
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
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('Coupons',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body:loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),): SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 80,
                width:  MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Container(
                  margin: EdgeInsets.fromLTRB(8, 20, 8, 20),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Coupon code'
                      ),
                      controller: couponController,
                    ),
                  )
                ),
              ),
              SizedBox(height: 10,),
              ListView.builder(
                //physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:  coupons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(18, 15, 5, 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.cyan[600],
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.cyan[600],
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Text(coupons[index].couponCode,
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),
                                      textAlign: TextAlign.center,),
                                  ),
                                ),
                                SizedBox(height: 2,),
                                ListTile(
                                  tileColor: Colors.white,
                                  title: Text(coupons[index].description,style: GoogleFonts.quicksand()),
                                  subtitle: Text('Min Order Amt: ' +coupons[index].minOrderAmountThresold.toStringAsFixed(0),style: GoogleFonts.quicksand(),),
                                  trailing:RaisedButton(
                                    color: Colors.white,
                                    textColor: Colors.white,
                                    child: Text("Apply now",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,color: Colors.green,fontWeight: FontWeight.w600),),),
                                    onPressed: (){
                                      print(widget.totalAmount);
                                      if(widget.totalAmount >= coupons[index].minOrderAmountThresold ){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Cart(
                                            coupon:coupons[index].couponCode
                                        )));
                                      }
                                      else{
                                        Toast.show('Minimum order value should be '+ coupons[index].minOrderAmountThresold.toStringAsFixed(0) ,context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.white,textColor: Colors.red);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 5,),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      bottomSheet:Container(
        height: 40,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          color: Colors.cyan[600],
          child: Text('Apply Coupon',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 15,color: Colors.white),),),
          onPressed: (){
            if(couponController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter a valid coupon")));
            }
            else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Cart(
                  coupon:couponController.text
              )));
            }
            }
        ),
      ),
    );
  }
}
