import 'package:NeedZIndia/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NeedZIndia/screen/Otp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final phonenumberController = TextEditingController();
  final otpController = TextEditingController();
  String message='';
  String message1='';
  var deviceKey1;
  var token1;
  bool filled = false;
  String appSignature = "";
  bool isEnabled = false;
  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose(){
    phonenumberController.dispose();
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
                    //color: Colors.cyan[600],
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Image.asset('assets/images/logo.ico'),
                    )
                  ), ),
                SizedBox(height: 20,),
                Flexible(child:Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Text(
                    'Log in to Get Started',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 22),),),
                ),),
                SizedBox(height: 30,),
                Flexible(child: Container(
                  margin: EdgeInsets.fromLTRB(10,0,20,0),
                  child:TextFormField(
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixText: '+91 ',
                      prefixStyle: TextStyle(fontSize: 17,color: Colors.black),
                      icon: Icon(Icons.phone, color: Colors.black),
                      hintText: " Enter your Phone number",
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    keyboardType: TextInputType.phone,maxLength: 10,
                    controller: phonenumberController,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Enter a Valid Number';
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState(() {
                        if(value.length>0)
                          isEnabled=true;
                        else
                          isEnabled=false;
                      });
                    },
                  ),
                ),
                ),
                SizedBox(height: 15,),
                Flexible(child: Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  //height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    padding: EdgeInsets.all(10),
                    textColor: Colors.white,
                    color: Colors.cyan[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Send OTP',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 20),),),
                    onPressed: !isEnabled ? null : () async {
                      if (_formkey.currentState.validate()){
                        var countryCode= "+91";
                        var mobile = phonenumberController.text;
                        try {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Center(child: CircularProgressIndicator(color: Colors.cyan[600],),);
                              });
                          var rsp= await loginuser(countryCode,mobile,appSignature);
                          Navigator.pop(context);
                          if(rsp.success==false){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(rsp.userFriendlyMessage),
                                backgroundColor: Colors.red));                          }
                          else{
                            deviceKey1 = rsp.data.deviceKey;
                            print(deviceKey1);
                            if (deviceKey1 != Null){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("OTP has been sent to "+ mobile),
                                  backgroundColor: Colors.green));
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Enter a valid number"),
                                  backgroundColor: Colors.red));
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Otp()),
                            );
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('deviceKey', deviceKey1);
                            prefs.setString('mobile', mobile);
                          }
                        }on Exception catch (e){
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                          Navigator.pop(context);
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
      bottomSheet: Container(
        color: Colors.white,
        height: 50,
        margin: EdgeInsets.fromLTRB(0, 0, 25, 10),
        alignment: Alignment.centerRight,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)),
          textColor: Colors.white,
          color: Colors.cyan[600],
          child: Text("Skip Login",style: GoogleFonts.quicksand(
              textStyle: TextStyle(fontSize: 18)),textAlign: TextAlign.center,),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
    );
  }
}