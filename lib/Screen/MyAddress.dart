import 'dart:convert';
import 'dart:io';
import 'package:NeedZIndia/Api.dart';
import 'package:NeedZIndia/Class/GetAddress.dart';
import 'package:NeedZIndia/Screen/AddAddress.dart';
import 'package:NeedZIndia/Screen/EditAddress.dart';
import 'package:NeedZIndia/Screen/MyAccount.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddress createState() => _MyAddress();
}

class _MyAddress extends State<MyAddress> {
  final String url = Constant.GET_ADDRESS_API;
  List<GetAddressData> data;
  var list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool loading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }


  Future<GetAddressResponse> getJsonData() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var mobile = _prefs.getString('mobile');
    try{
      final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
          headers: <String, String>{HttpHeaders.authorizationHeader: token,
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          }, body: {'mobile': mobile}
      );
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseAdd.userFriendlyMessage),
            backgroundColor: Colors.red));
      }
    }on Exception catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 0));

    setState(() {
      this.getJsonData();
    });

    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.cyan[600],
          titleSpacing: 0.0,
          title: FittedBox(fit: BoxFit.fitWidth,
            child: Text('My Address', style: GoogleFonts.quicksand(
              textStyle: TextStyle(fontSize: 22),),),
          ),
        ),
        body: WillPopScope(
          onWillPop: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyAccount())),
          child: RefreshIndicator(
            key: refreshKey,
            child:loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) : data.isEmpty == true?
            Center(
              child:Text('No Address found!',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 18),color: Colors.blueGrey),textAlign: TextAlign.center,),
            ): SafeArea(
              child:SingleChildScrollView(
                physics: new BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    new ListView.builder(
                        physics: new BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:  data.isEmpty== true ? 0 : data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SafeArea(
                            child: SingleChildScrollView(
                              child: Form(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      child: Wrap(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10,10,10,5),
                                            child: Text(toBeginningOfSentenceCase(
                                                data[index].name),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 18),),
                                              textAlign: TextAlign.left,),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            height: 20,
                                            width: 50,
                                            padding: EdgeInsets.fromLTRB(5, 2, 5, 0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                              borderRadius: BorderRadius.circular(2),
                                              color: Colors.cyan[50],
                                            ),
                                            child: Text(toBeginningOfSentenceCase(
                                                data[index].type),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 12),),
                                              textAlign: TextAlign.center,),
                                          ),
                                          SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Text(toBeginningOfSentenceCase(
                                                data[index].street + ","),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text(toBeginningOfSentenceCase(
                                                data[index].landmark + ","),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),),
                                          ),
                                          SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Text(toBeginningOfSentenceCase(
                                                data[index].district + ","),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text(toBeginningOfSentenceCase(
                                                data[index].city + ","),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),),
                                          ),
                                          SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Text(toBeginningOfSentenceCase(
                                                data[index].state + ","),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text(toBeginningOfSentenceCase(
                                                data[index].country),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),),
                                          ),
                                          SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Text(toBeginningOfSentenceCase(
                                                data[index].pincode),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),),
                                          ),
                                          SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 5, 0, 2),
                                            child: data[index].alternateMobileNumber.isEmpty == true ? Text(toBeginningOfSentenceCase(
                                                data[index].mobileNumber),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),):Text(toBeginningOfSentenceCase(
                                                data[index].mobileNumber+ "/"+data[index].alternateMobileNumber),
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),),),
                                          ),
                                          SizedBox(height: 0.5,
                                            child: Container(
                                              color: Colors.black26,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(child:
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: IconButton(
                                                    icon: Icon(Icons.edit,size: 20,),
                                                    color: Colors.blueGrey,
                                                    onPressed: () {
                                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>
                                                          EditAddress( data: data[index])));
                                                    },
                                                  ),
                                                ),
                                                ),
                                                Container(
                                                  child: Text("|",style: TextStyle(color: Colors.blueGrey,fontSize: 30),),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: IconButton(
                                                      icon: Icon(Icons.delete,size: 20,),
                                                      color: Colors.blueGrey,
                                                      onPressed: ()  {
                                                        return showDialog(
                                                            context: _scaffoldKey.currentContext,
                                                            builder: (context) =>
                                                                AlertDialog(
                                                                    title: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: <Widget>[
                                                                        Container(
                                                                          alignment: Alignment.topLeft,
                                                                          child:  Text('Delete Address?',style: GoogleFonts.quicksand(
                                                                            textStyle: TextStyle(color: Colors.black,fontSize: 18),),textAlign: TextAlign.right,),
                                                                        ),
                                                                        SizedBox(height: 5,),
                                                                        Text('Are you sure you want delete this address?',style: GoogleFonts.quicksand(
                                                                          textStyle: TextStyle(color: Colors.blueGrey,fontSize: 15),)),
                                                                      ],
                                                                    ),
                                                                    actions: <Widget>[
                                                                      GestureDetector(
                                                                          child:Container(
                                                                            margin: EdgeInsets.fromLTRB(10,5,10,20),
                                                                            child:  Text('No',style: GoogleFonts.quicksand(
                                                                              textStyle: TextStyle(color: Colors.blueGrey,fontSize: 16),)),
                                                                          ),
                                                                          onTap: () => Navigator.of(context).pop(false)),
                                                                      GestureDetector(
                                                                          child: Container(
                                                                            margin: EdgeInsets.fromLTRB(10,5,20,20),
                                                                            child:  Text('Yes',style: GoogleFonts.quicksand(
                                                                              textStyle: TextStyle(color: Colors.cyan,fontSize: 16),)),
                                                                          ),
                                                                          onTap: () async {
                                                                            Navigator.of(context).pop();
                                                                            var _prefs = await SharedPreferences
                                                                                .getInstance();
                                                                            var mobile = _prefs.getString(
                                                                                'mobile');
                                                                            var id = data[index].id;
                                                                            try {
                                                                              if(mounted){
                                                                                setState(() {
                                                                                  loading = true;
                                                                                });
                                                                              }
                                                                              var rsp = await deleteaddresses(
                                                                                  mobile, id);
                                                                              if(mounted){
                                                                                setState(() {
                                                                                  loading = false;
                                                                                });
                                                                              }
                                                                              if (rsp.success== false) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    content: Text(rsp.userFriendlyMessage),
                                                                                    backgroundColor: Colors.red));
                                                                              }
                                                                              else {
                                                                                await getJsonData();
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    content: Text(rsp.userFriendlyMessage),
                                                                                    backgroundColor: Colors.green));
                                                                              }
                                                                            } on Exception catch (e) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                  content: Text("Something went wrong")));
                                                                            }
                                                                          }
                                                                      ),
                                                                    ]));
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
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
                    SizedBox(height:65),
                  ],
                ),
              ),
            ),
            onRefresh: refreshList,
          ) ,
        ),
        floatingActionButton: FloatingActionButton.extended(
            elevation: 0.0,
            icon: new Icon(Icons.add, color: Colors.white, size: 15,),
            label: Text('Add address',
              style: TextStyle(fontSize: 12, color: Colors.white),),
            backgroundColor: Colors.cyan[600],
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var firstName = prefs.getString('firstName');
              var lastName=prefs.getString('lastName');
              var mobile =prefs.getString('mobile');
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddAddress(firstName: firstName,lastName: lastName,mobile: mobile
                ,)));
            }
        )
    );
  }
}
