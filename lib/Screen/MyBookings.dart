import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:NeedZIndia/Api.dart';
import 'package:NeedZIndia/Categories/Services/ServicesCat.dart';
import 'package:NeedZIndia/Class/GetBookings.dart';
import 'package:NeedZIndia/Screen/MyBookingDetails.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class MyBookings extends StatefulWidget {
  @override
  _MyBookings createState() => _MyBookings();
}

class _MyBookings extends State<MyBookings> {
  bool loading = true;
  List<GetBookingsData> bookingData= [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool load = false;
  int offset =0;
  final scrollController = ScrollController();
  int formatted;
  int selected = -1;

  @override
  void initState() {
    super.initState();
    GetBookings();
    formatted = DateTime.now().toUtc().millisecondsSinceEpoch;
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        offset++;
        GetBookingsOffset();
      }
    });
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  Future<GetBookingsResponse> GetBookings() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try{
      var queryParameters;
      queryParameters = {
        'offset':  '0',
      };
      var uri =
      Uri.https( Constant.URL,'/api/getBookings.php', queryParameters);
      final response = await http.get((uri),
        headers: <String, String>{HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      var response1 = GetBookingsResponse.fromJson(json.decode(response.body));
      if (response1.success == true) {
       if(mounted){
         setState(() {
           bookingData = response1.data;
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future<GetBookingsResponse> GetBookingsOffset() async {
    if(!load){
      if(mounted){
        setState(() {
          load = true;
        });
      }
      var _prefs = await SharedPreferences.getInstance();
      var token = _prefs.getString('token');
      try{
        var queryParameters;
        queryParameters = {
          "offset":  offset.toString(),
        };
        var uri =
        Uri.https(Constant.URL,'/api/getBookings.php',queryParameters);
        final response = await http.get((uri),
          headers: <String, String>{HttpHeaders.authorizationHeader: token,
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          },
        );
        var response1 = GetBookingsResponse.fromJson(json.decode(response.body));
        if (response1.success == true) {
          if(mounted){
            setState(() {
              bookingData.addAll(response1.data);
              loading = false;
              load = false;
            });
          }
          return response1;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response1.userFriendlyMessage),
              backgroundColor: Colors.red));
          if(mounted){
            setState(() {
              load = false;
              loading = false;
            });
          }
        }
      }on Exception catch (e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
      }
    }
  }


  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          titleSpacing: 0,
          title: FittedBox(fit: BoxFit.fitWidth,
            child: Text('My Bookings', style: GoogleFonts.quicksand()),
          ),
          backgroundColor: Colors.cyan[600],
        ),
        body: RefreshIndicator(
          key: refreshKey,
          child: loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) :bookingData.isEmpty == true ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/noresultsfound.jpg'),
                    Text('You don\'t have any bookings yet' ,style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18),color: Colors.blueGrey),textAlign: TextAlign.center,),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      width: 200,
                      child: RaisedButton(
                        color: Colors.cyan[600],
                        child: Text('Book now',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 15,color: Colors.white),),),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ServicesCat()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
          ):
          loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),): new ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount:  bookingData.isEmpty == true ? 0 : bookingData.length+1,
              itemBuilder: (BuildContext context, int index) {
                if(index == bookingData.length){
                  return _buildProgressIndicator();
                }
                else{
                  return SafeArea(
                    child:SingleChildScrollView(
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5,),
                            bookingData[index].isCancelled || bookingData[index].cancel == true ?
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.cancel,size: 30,color: Colors.red,),
                                    tileColor: Colors.white,
                                    title: Text('Booking for '+bookingData[index].serviceName,style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 20),),),
                                    subtitle: Text(DateFormat("EEE, d MMM yyyy").format(DateTime.parse(bookingData[index].serviceDispatchingDate)),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 18),),),),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Text('Booking Cancelled',style: GoogleFonts.quicksand(textStyle: TextStyle(color: Colors.red)),),
                                  )
                                ],
                              ),
                            ): GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyBookingDetails(bookingDetails: bookingData[index]),)
                                );
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.check_box,size: 30,color: Colors.green,),
                                      tileColor: Colors.white,
                                      title: Text('Booking for '+bookingData[index].serviceName,style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 20),),),
                                      subtitle: Text(DateFormat("EEE, d MMM yyyy").format(DateTime.parse(bookingData[index].serviceDispatchingDate)),style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(fontSize: 18),),),
                                      trailing: Icon(Icons.navigate_next_sharp,size: 25,color: Colors.blueGrey,),
                                    ),
                                    formatted >= DateTime.parse(bookingData[index].serviceDispatchingDate).toUtc().millisecondsSinceEpoch.toInt() ? Container():
                                    Container(
                                      child: RaisedButton(
                                        child: Text('Cancel',style: GoogleFonts.quicksand(),),
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        onPressed: () async {
                                          var serviceBookingId = bookingData[index].serviceBookingId.toString();
                                          print(serviceBookingId);
                                          try {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Center(child: CircularProgressIndicator(),);
                                                });
                                            var rsp= await cancelSlot(serviceBookingId);
                                            Navigator.pop(context);
                                            if(rsp.success==false){
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  content: Text(rsp.userFriendlyMessage),
                                                  backgroundColor: Colors.red));
                                            }
                                            else{
                                             if(mounted){
                                               setState(() {
                                                 bookingData[index].cancel = true;
                                               });
                                             }
                                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                 content: Text(rsp.userFriendlyMessage),
                                                 backgroundColor: Colors.green));
                                            }
                                          }on Exception catch (e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
          ),
          onRefresh: refreshList,
        ) ,
    );
  }
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: load ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}