import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:NeedZIndia/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:NeedZIndia/Categories/Services/BookingSlots.dart';
import 'package:NeedZIndia/Class/Services.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressive_image/progressive_image.dart';

class Passport extends StatefulWidget {
  @override
  _Passport createState() => _Passport();
}

class _Passport extends State<Passport> {
  bool _loading = true;
  ServicesData servicesData;

  @override
  void initState() {
    super.initState();
    getServices();
  }


  Future<ServicesResponse> getServices() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try{
      final url = Constant.GET_SERVICESANDSLOTS_API;
      final response = await http.get(Uri.parse(Constant.apiShort_Url+ url),
        headers: <String, String>{HttpHeaders.authorizationHeader: token==null?"":token,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      print("${response.body}");
      var response1 = ServicesResponse.fromJson(json.decode(response.body));
      if (response1.success == true) {
        print(response1.data);
        print(response1.success);
        print(response1.message);
        print(response1.userFriendlyMessage);
        print(response1.status);
        if(mounted){
          setState(() {
            servicesData = response1.data;
            _loading = false;
          });
        }
        return response1;
      } else {
        Toast.show(response1.userFriendlyMessage ,context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        if(mounted){
          setState(() {
            _loading = false;
          });
        }
      }
    }on Exception catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('Passport',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body: _loading? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) :SafeArea(
        child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      height: SizeConfig.blockSizeVertical * 25,
                      width: MediaQuery.of(context).size.width,
                      child: Carousel(
                        boxFit: BoxFit.fill,
                        images: [
                          ProgressiveImage(
                            placeholder: AssetImage('assets/images/fade_image.jpg'),
                            // size: 1.87KB
                            thumbnail: NetworkImage('https://www.needzindia.com/Carousels_images/passport_car.jpg'),
                            // size: 1.29MB
                            image: NetworkImage('https://www.needzindia.com/Carousels_images/passport_car.jpg'),
                            height: 300,
                            width: 500,
                          ),
                        ],
                        dotSize: 0.0,
                        dotSpacing: 15.0,
                        dotColor: Colors.lightGreenAccent,
                        indicatorBgPadding: 5.0,
                        dotBgColor: Colors.white.withOpacity(0.10),
                      )),
                  SizedBox(height: 3,),
                  SizedBox(height: 3,
                    child: Container(
                      color: Colors.cyan[600],
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 30, 10, 25),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text('Welcome to NeedZ India\'s Passport Service',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),),
                      )
                  ),
                  Text('We made it easier for you just handover the documents to our executive and get your Passport after completion of procedures.',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 16,),),textAlign: TextAlign.center,),
                  SizedBox(height: 30,),
                  Text('Instructions Step by Step:-',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 20,),decoration: TextDecoration.underline,),textAlign: TextAlign.center,),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 0, 10),
                    alignment: Alignment.centerLeft,
                    child: Text('Step 1 - Book a time slot',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 18,),),textAlign: TextAlign.left,),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    alignment: Alignment.centerLeft,
                    child: Text('Step 2 - Handover your required documents to the executive sent by NeedZ India.',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 18,),),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    alignment: Alignment.centerLeft,
                    child: Text('Step 3 - Complete all procedure under the guidance of the executive.',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 18,),),textAlign: TextAlign.left,),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    alignment: Alignment.centerLeft,
                    child: Text('Step 4 - Make the Payment',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 18,),),textAlign: TextAlign.left,),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    alignment: Alignment.centerLeft,
                    child: Text('Note - Required documents are xerox of Aadhaar Card, PAN Card, Voter Card, Certificates of last examination passed and two copy passport size photo',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 16,),),textAlign: TextAlign.left,),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    alignment: Alignment.center,
                    child: Text('Book time slot',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 18,),),textAlign: TextAlign.left,),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    //height: 50,
                    width: 200,
                    child: RaisedButton(
                        padding: EdgeInsets.all(10),
                        textColor: Colors.white,
                        color: Colors.cyan[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text('Choose Slot',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 18),),),
                        onPressed: ()  {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> BookingSlots(servicesData: servicesData,serviceName:'Passport')),
                          );
                        }
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 30, 0, 10),
                    alignment: Alignment.center,
                    child: Text('For Further enquiries reach us at:\n +91 7439551502 / 6289222486',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 18,),),textAlign: TextAlign.left,),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
