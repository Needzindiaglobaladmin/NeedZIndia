import 'package:NeedZIndia/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NeedZIndia/Homepage/Homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';



class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formkey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  var token1;
  bool isEnabled = false;



  @override
  void initState() {
    super.initState();
  }




  @override
  void dispose(){
    otpController.dispose();
    super.dispose();
  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.cyan[600],
        ),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:Form(key: _formkey,
          child: Center(
            child: Column(
              children: <Widget>[
                Flexible(
                  child:Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                      color: Colors.cyan[600],
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/images/logo.ico'),
                  ), ),
                SizedBox(height: 20,),
                Flexible(child:Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Text(
                    'OTP Verification',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 22),),),
                ),
                ),
                SizedBox(height: 30,),
                Flexible(child: Container(
                  margin: EdgeInsets.fromLTRB(10,0,20,0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock, color: Colors.black),
                      hintText: "Enter your OTP",
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    keyboardType: TextInputType.phone,maxLength: 6,
                    controller: otpController,
                    onChanged: (value){
                      setState(() {
                        if(value.length>0)
                          isEnabled=true;
                        else
                          isEnabled=false;
                      });
                    },
                  ), ),),
                SizedBox(height: 15,),
                Flexible(child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  //height: 50,
                  width: MediaQuery.of(context).size.width,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    padding: EdgeInsets.all(10),
                    textColor: Colors.white,
                    color: Colors.cyan[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Submit',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 20),),),
                    onPressed: !isEnabled ? null : () async{
                      var _prefs =await SharedPreferences.getInstance();
                      var deviceKey = _prefs.getString('deviceKey');
                      var firebaseToken = _prefs.getString('firebaseToken');
                      if(_formkey.currentState.validate()){
                        print(deviceKey);
                        print(firebaseToken);
                        var otp= otpController.text;
                        print(otp);
                        try{
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Center(child: CircularProgressIndicator(color: Colors.cyan[600]),);
                              });
                          var rsp1= await verification(deviceKey ,otp,firebaseToken);
                          Navigator.pop(context);
                          if(rsp1.success==false){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(rsp1.userFriendlyMessage),
                                backgroundColor: Colors.red));
                          }
                          else{
                            print(rsp1);
                            token1 = rsp1.data.token;
                            print(token1);
                            if(token1==Null){
                              print("Not received");
                            }
                            else{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('token', token1);
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  Homepage()), (Route<dynamic> route) => false);
                            }
                          }
                        }
                        on Exception catch (e){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                        }
                      }
                    },
                  ),
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}