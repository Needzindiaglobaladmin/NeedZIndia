import 'dart:convert';
import 'dart:io';

import 'package:NeedZIndia/Class/updateUserClass.dart';
import 'package:NeedZIndia/Homepage/Homepage.dart';
import 'package:NeedZIndia/Screen/MyBookings.dart';
import 'package:NeedZIndia/Screen/MyOrders.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:NeedZIndia/Screen/MyAddress.dart';
import 'package:NeedZIndia/Screen/MyDetails.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NeedZIndia/screen/Login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';



class MyAccount extends StatefulWidget {
  @override
  _MyAccount createState() => _MyAccount();
}

class _MyAccount extends State<MyAccount> {
  final String url= Constant.GET_USERDATA_API;
  Map data;
  var list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool loading = true;
  String fullName ='';
  var firstName;
  var fName;
  var lName;
  String mobileNumber ='';
  String email ='';
  String gender ='';
  String image = '';
  var imageUrl;
  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }


  Future<UpdateUserResponse> getJsonData() async {
    var _prefs =await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var mobile = _prefs.getString('mobile');
    firstName = _prefs.getString('firstName');
    var lastName = _prefs.getString('lastName');
    var emailId =  _prefs.getString('emailId');
    var genderVar =  _prefs.getString('gender');
    imageUrl =  _prefs.getString('imageUrl');
    if(firstName == null){
      try{
        final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
            headers: <String, String>{HttpHeaders.authorizationHeader: token,
              'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            },  body: {'mobile': mobile}
        );
        var responseUser = UpdateUserResponse.fromJson(json.decode(response.body));
        if (responseUser.success == true) {
          if(mounted){
            setState(()  {
              fName = responseUser.data.firstName;
              lName = responseUser.data.lastName;
              fullName = responseUser.data.firstName + " " + responseUser.data.lastName;
              gender = responseUser.data.gender;
              email = responseUser.data.emailId;
              mobileNumber = responseUser.data.mobile;
              if(responseUser.data.imageUrl == null){
                image = 'https://www.needzindia.com/images/pp.png';
              }
              else{
                image = responseUser.data.imageUrl;
              }
              loading = false;
            });
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('firstName', responseUser.data.firstName );
          prefs.setString('lastName', responseUser.data.lastName);
          prefs.setString('gender', responseUser.data.gender );
          prefs.setString('emailId', responseUser.data.emailId );
          prefs.setString('imageUrl', responseUser.data.imageUrl);
          return responseUser;

        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(responseUser.userFriendlyMessage),
              backgroundColor: Colors.red));
          if(mounted){
            setState(() {
              loading=false;
            });
          }
        }
      }on Exception catch (e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
        if(mounted){
          setState(() {
            loading=false;
          });
        }
      }
    }
    else{
      if(mounted){
        setState(() {
          fName = firstName;
          lName = lastName;
          fullName = firstName+ " " + lastName;
          email = emailId;
          gender = genderVar;
          if(imageUrl==""){
            image ='https://www.needzindia.com/images/pp.png';
          }
          else{
            image = imageUrl;
          }
          mobileNumber = mobile;
          loading = false;
        });
      }
    }
  }
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    this.getJsonData();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final CartValue cartValue  = Provider.of<CartValue>(context);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('My Account',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child:loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),)
        ): fullName == " " ? ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                color: Colors.cyan[600],
              ),
              height: 255,
              child: Center(
                child:Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      backgroundImage: image == '' ? AssetImage('assets/images/avatar.png')
                          :CachedNetworkImageProvider( image + "?a="+ DateTime.now().millisecondsSinceEpoch.toString()),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      child: Text(toBeginningOfSentenceCase('Welcome'),style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 18),color: Colors.white),textAlign: TextAlign.left,),
                    ),
                    SizedBox(height:3,),
                    Container(
                      child: Text('To',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 18),color: Colors.white),textAlign: TextAlign.left,),
                    ),
                    SizedBox(height:3,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin:EdgeInsets.fromLTRB(30,0,0,0),
                          child: Text('NeedZ India',style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 18),color: Colors.white),textAlign: TextAlign.left,),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyDetails(
                              firstName: fName,lastName:lName, gender: gender, emailId: email,imageUrl: image,
                            )));
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 2),
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.edit_outlined,color: Colors.white,size: 18,),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height:3,),
                    Container(
                      child: Text('(Fill your details by clicking on edit icon in the right corner)',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 12),color: Colors.white),textAlign: TextAlign.left,),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //child: Text('My details',style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.shopping_bag,color: Colors.blueGrey,size: 30,)
                    ),
                  ),
                  Expanded(
                    flex : 8,
                    child: ListTile(
                      trailing:  Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,),
                      title: Text('My Orders',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 22,color: Colors.blueGrey),),textAlign: TextAlign.start,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //child: Text('My details',style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.book_online,color: Colors.blueGrey,size: 30,)
                    ),
                  ),
                  Expanded(
                    flex : 8,
                    child: ListTile(
                      trailing:  Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,),
                      title:Text('My Bookings',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 22,color: Colors.blueGrey),),textAlign: TextAlign.start,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBookings()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //child: Text('My details',style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.home_filled,color: Colors.blueGrey,size: 30,)
                    ),
                  ),
                  Expanded(
                    flex : 8,
                    child: ListTile(
                      trailing:  Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,),
                      title:Text('My Addresses',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 22,color: Colors.blueGrey),),textAlign: TextAlign.start,),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyAddress()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child:ListTile(
                leading: Icon(Icons.power_settings_new,color: Colors.blueGrey,size: 25,),
                title: Transform.translate(
                  offset: Offset(-12, 0),
                  child: Text('Log Out',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 22,color: Colors.blueGrey),),textAlign: TextAlign.start,),
                ),
                onTap: ()  {
                  return showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(title: Text('Are you sure you want to Log out?',style: GoogleFonts.quicksand(
                            textStyle: TextStyle(color: Colors.blueGrey),)), actions: <Widget>[
                            GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child:  Text('No',style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(color: Colors.blueGrey,fontSize: 18),)),
                                ),
                                onTap: () => Navigator.of(context).pop(false)),
                            GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text('Yes',style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(color: Colors.cyan[600],fontSize: 18),)),
                                ),
                                onTap: () async {
                                  var _prefs =await SharedPreferences.getInstance();
                                  var token = _prefs.remove('token');
                                  var mobile = _prefs.remove('mobile');
                                  var firstName = _prefs.remove('firstName');
                                  var lastName = _prefs.remove('lastName');
                                  var emailId =  _prefs.remove('emailId');
                                  var genderVar =  _prefs.remove('gender');
                                  var imageUrl =  _prefs.remove('imageUrl');
                                  print(token);
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Login()), (e) => false);
                                }
                            ),
                          ]));

                },
              ),
            ),
            SizedBox(height:5),
          ],
        ): ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                color: Colors.cyan[600],
              ),
              height: 255,
              child: Center(
                child:Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      backgroundImage:image == '' ? AssetImage('assets/images/avatar.png')
                          :CachedNetworkImageProvider( image + "?a="+ DateTime.now().millisecondsSinceEpoch.toString()),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Text(toBeginningOfSentenceCase(fName)+" "+toBeginningOfSentenceCase(lName),style: GoogleFonts.quicksand(
                                textStyle: TextStyle(fontSize: 20),color: Colors.white),textAlign: TextAlign.left,),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            child: Image.asset('assets/images/verified.png'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: Text(toBeginningOfSentenceCase(gender),style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 15),color: Colors.white),textAlign: TextAlign.center,),
                    ),
                    SizedBox(height:3,),
                    Container(
                      child: Text('+91'+ mobileNumber,style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 15),color: Colors.white),textAlign: TextAlign.center,),
                    ),
                    SizedBox(height:3,),
                    Container(
                        width: MediaQuery.of(context).size.width ,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Text(email,style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(fontSize: 15),color: Colors.white),textAlign: TextAlign.center,),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyDetails(
                                  firstName: fName,lastName:lName, gender: gender, emailId: email, imageUrl: image,
                                )));
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 2),
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.edit_outlined,color: Colors.white,size: 18,),
                              ),
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //child: Text('My details',style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.shopping_bag,color: Colors.blueGrey,size: 30,)
                    ),
                  ),
                  Expanded(
                    flex : 8,
                    child: ListTile(
                      trailing:  Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,),
                      title: Text('My Orders',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 22,color: Colors.blueGrey),),textAlign: TextAlign.start,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //child: Text('My details',style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.book_online,color: Colors.blueGrey,size: 30,)
                    ),
                  ),
                  Expanded(
                    flex : 8,
                    child: ListTile(
                      trailing:  Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,),
                      title:Text('My Bookings',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 22,color: Colors.blueGrey),),textAlign: TextAlign.start,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBookings()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //child: Text('My details',style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.home_filled,color: Colors.blueGrey,size: 30,)
                    ),
                  ),
                  Expanded(
                    flex : 8,
                    child: ListTile(
                      trailing:  Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,),
                      title:Text('My Addresses',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 22,color: Colors.blueGrey),),textAlign: TextAlign.start,),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyAddress()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child:ListTile(
                leading: Icon(Icons.logout,color: Colors.blueGrey,size: 25,),
                title:Transform.translate(
                  offset: Offset(-12, 0),
                  child: Text('Log Out',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 22,color: Colors.blueGrey),),textAlign: TextAlign.start,),
                ),
                onTap: ()  {
                  return showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(title: Text('Are you sure you want to Log out?',style: GoogleFonts.quicksand(
                            textStyle: TextStyle(color: Colors.blueGrey),)), actions: <Widget>[
                            GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child:  Text('No',style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(color: Colors.blueGrey,fontSize: 18),)),
                                ),
                                onTap: () => Navigator.of(context).pop(false)),
                            GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text('Yes',style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(color: Colors.cyan[600],fontSize: 18),)),
                                ),
                                onTap: () async {
                                  var _prefs =await SharedPreferences.getInstance();
                                  var token = _prefs.remove('token');
                                  var mobile = _prefs.remove('mobile');
                                  var firstName = _prefs.remove('firstName');
                                  var lastName = _prefs.remove('lastName');
                                  var emailId =  _prefs.remove('emailId');
                                  var genderVar =  _prefs.remove('gender');
                                  var imageUrl =  _prefs.remove('imageUrl');
                                  cartValue.clear();
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      Homepage()), (Route<dynamic> route) => false);
                                }
                            ),

                          ]));

                },
              ),
            ),
            SizedBox(height:5),
          ],
        ),
        onRefresh: refreshList,
      ),
    );
  }
}
