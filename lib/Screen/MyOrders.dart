import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'package:NeedZIndia/Class/OrderDetails.dart';
import 'package:NeedZIndia/Homepage/Homepage.dart';
import 'package:NeedZIndia/Screen/OrderDetails.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class MyOrders extends StatefulWidget {
  @override
  _MyOrders createState() => _MyOrders();
}

class _MyOrders extends State<MyOrders> {
  bool loading = true;
  List<OrderDetailsData> orderDetailsList= [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool load = false;
  int offset =0;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    GetOrderPlacedList();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        offset++;
        OrderDetailsOffset();
        print("Reached");
      }
    });
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  Future<OrderDetailsResponse> GetOrderPlacedList() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try{
      var queryParameters;
      queryParameters = {
        'offset':  '0',
      };
      var uri =
      Uri.https(Constant.URL,'/api/getOrders.php',queryParameters);
      final response = await http.get((uri),
        headers: <String, String>{HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      var response1 = OrderDetailsResponse.fromJson(json.decode(response.body));
      if (response1.success == true) {
        if(mounted){
          setState(() {
            orderDetailsList = response1.data;
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
                      content: Text("Something went wrong")));
    }
  }

  Future<OrderDetailsResponse> OrderDetailsOffset() async {
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
          'offset':  offset.toString(),
        };
        var uri =
        Uri.https(Constant.URL,'/api/getOrders.php', queryParameters);
        final response = await http.get(uri,
          headers: <String, String>{HttpHeaders.authorizationHeader: token,
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          },
        );
        print("${response.body}");
        var response1 = OrderDetailsResponse.fromJson(json.decode(response.body));
        if (response1.success == true) {
          if(mounted){
            setState(() {
              orderDetailsList.addAll(response1.data);
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong")));
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
            child: Text('My Orders', style: GoogleFonts.quicksand()),
          ),
          backgroundColor: Colors.cyan[600],
        ),
        body: RefreshIndicator(
          key: refreshKey,
          child: loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) :orderDetailsList.isEmpty == true ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/noresultsfound.jpg'),
                    Text('You haven\'t ordered anything yet' ,style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18),color: Colors.blueGrey),textAlign: TextAlign.center,),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      width: 200,
                      child: RaisedButton(
                        color: Colors.cyan[600],
                        child: Text('Order now',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 15,color: Colors.white),),),
                        onPressed: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Homepage()), (e) => false);
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
              itemCount:  orderDetailsList.isEmpty == true ? 0 : orderDetailsList.length+1,
              itemBuilder: (BuildContext context, int index) {
                if(index == orderDetailsList.length){
                  return _buildProgressIndicator();
                }
                else{
                  return SafeArea(
                    child:SingleChildScrollView(
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5,),
                            ListView.builder(
                                physics: new BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:  orderDetailsList[index].orderItems.isEmpty == true ? 0 : 1,
                                itemBuilder: (BuildContext context, int index2) {
                                  return SafeArea(
                                    child:SingleChildScrollView(
                                      child: Form(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              color: Colors.white,
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                      flex:1,
                                                      child: Container(
                                                        margin: EdgeInsets.all(5),
                                                        height:120,
                                                        width: 200,
                                                        child: FadeInImage.assetNetwork(
                                                          placeholder: 'assets/images/loading.gif',
                                                          image: orderDetailsList[index].orderItems[index2].imageUrl,
                                                        ),
                                                      )
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: ListTile(
                                                      title: orderDetailsList[index].orderItems.length==1?Text(orderDetailsList[index].orderItems[index2].productName,style: GoogleFonts.quicksand(
                                                        textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),):Text(orderDetailsList[index].orderItems[index2].productName+' +'+(orderDetailsList[index].orderItems.length-1).toString()+' more items',style: GoogleFonts.quicksand(
                                                        textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                                                      trailing: Icon(Icons.navigate_next),
                                                      subtitle: orderDetailsList[index].isDelivered?Text('Delivered',style: GoogleFonts.quicksand(
                                                        textStyle: TextStyle(fontSize: 15,color: Colors.green),),):orderDetailsList[index].isCancelled?Text('Cancelled',style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(fontSize: 15,color: Colors.red),),):Text('Your Product will arrive soon',style: GoogleFonts.quicksand(
                                                        textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),),
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderDetails(orderDetails: orderDetailsList[index],orderItems: orderDetailsList[index].orderItems,
                                                          shippingAddress: orderDetailsList[index].shippingAddress,variants: orderDetailsList[index].orderItems[index2].variants,),)
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
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
        ),
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