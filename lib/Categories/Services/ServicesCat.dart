
import 'package:NeedZIndia/Categories/Services/BodyCheckUp.dart';
import 'package:NeedZIndia/Categories/Services/PanCard.dart';
import 'package:NeedZIndia/Categories/Services/Passport.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:NeedZIndia/Categories/Services/CarouselproServices.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesCat extends StatefulWidget {
  @override
  _ServicesCat createState() => _ServicesCat();
}

class _ServicesCat extends State<ServicesCat> {
  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing:0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child:Text('Services', style: GoogleFonts.quicksand()),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 5,),
                CarouselproServices(),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PanCard()),
                    );
                  },
                  child: Container(
                    height: 110,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child:Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 0, 1),
                              child: Image.asset('assets/images/pan.png'),
                            )
                        ),
                        Expanded(
                            flex: 2,
                            child:ListTile(
                              title: Text('Pan Card', style: GoogleFonts.quicksand(
                                textStyle: TextStyle(fontSize: 25,color:  Colors.blueGrey),),),
                              trailing: Icon(Icons.navigate_next_rounded,color: Colors.blueGrey),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Passport()),
                    );
                  },
                  child: Container(
                    height: 110,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child:Container(
                              child: Image.asset('assets/images/passportimg.jpg'),
                            )
                        ),
                        Expanded(
                          flex: 2,
                          child:ListTile(
                            title: Text('Passport', style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 25,color:  Colors.blueGrey),),),
                            trailing: Icon(Icons.navigate_next_rounded,color: Colors.blueGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BodyCheckUp()),
                    );
                  },
                  child: Container(
                    height: 110,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child:Container(
                              child: Image.asset('assets/images/doctor.PNG'),
                            )
                        ),
                        Expanded(
                          flex: 2,
                          child:ListTile(
                            title: Text('Full Body Health Checkup', style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 25,color:  Colors.blueGrey),),),
                            trailing: Icon(Icons.navigate_next_rounded,color: Colors.blueGrey,),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}