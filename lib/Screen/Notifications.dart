import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Notifications extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('My Notifications',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Flexible(child:SizedBox(
                height: 70,
                child: Container(
                  color: Color(0xFFFFFFFF),
                ),
              ), ),
              Container(
                width: double.infinity,
                height: 250,
                margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: Image.asset(
                  "assets/images/noti.jpg",
                  height: 250,
                  width: double.infinity,
                ),
              ),
              Flexible(child:SizedBox(
                height: 40,
                child: Container(
                  color: Color(0xFFFFFFFF),
                ),
              ), ),
              Flexible(
                  child:Container(
                    width: double.infinity,
                    child: Text(
                      "0 notification",
                      style: TextStyle(
                        color: Color(0xFF67778E),
                        fontFamily: 'Roboto-Light.ttf',
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ) ),
            ],
          ),
        ),
      ),
    );
  }
}