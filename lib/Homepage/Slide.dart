
import 'dart:ui';

import 'package:NeedZIndia/Categories/BabyCare/BabycareCat.dart';
import 'package:NeedZIndia/Categories/Beautycare/BeautycareCat.dart';
import 'package:NeedZIndia/Categories/Beverages/BeveragesCat.dart';
import 'package:NeedZIndia/Categories/BiscuitsSnacks/BiscuitsSnacksCat.dart';
import 'package:NeedZIndia/Categories/HomeEssential/HomeCat.dart';
import 'package:NeedZIndia/Categories/Services/ServicesCat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';



class Slide extends StatefulWidget {
  final List<String> searchQuery;
  Slide({Key key, this.searchQuery}) : super(key: key );

  @override
  _Slide createState() => _Slide();
}
class _Slide extends State<Slide> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Container(
                height: 100,
                width: 70,
                margin: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeCat(searchData: widget.searchQuery)),
                    );
                  },
                  child:Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/circle_he.PNG'),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        child: Text("Home Essentials",style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 11),fontWeight: FontWeight.bold
                        ),textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 70,
                margin: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BeautycareCat(searchData: widget.searchQuery)),
                    );
                  },
                  child:Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/circle_pcd.PNG'),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        child: Text("Personal care",style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 11),fontWeight: FontWeight.bold
                        ),textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 70,
                margin: EdgeInsets.all(10),
                child: InkWell(
                  onTap: ()  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BabyCare(searchData: widget.searchQuery)),
                    );
                  },
                  child:Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/baby.jpg'),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        child:  Text("Baby Care",style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 11),fontWeight: FontWeight.bold
                        ),),
                      )
                    ],
                  ),
                  ),
                ),
              Container(
                height: 100,
                width: 70,
                margin: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BiscuitsSnacksCat(searchData: widget.searchQuery)),
                    );
                  },
                  child:Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/circle_bsc.PNG'),
                      ),
                      SizedBox(height: 8,),
                      Container(
                          child: Text("Snacks",style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 11),fontWeight: FontWeight.bold
                          ),),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 70,
                margin: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BeveragesCat(searchData: widget.searchQuery)),
                    );
                  },
                  child:Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/circle_bv.PNG'),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        child: Text("Beverages",style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 11),fontWeight: FontWeight.bold
                        ),),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 70,
                margin: EdgeInsets.all(10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ServicesCat()),
                    );
                  },
                  child:Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/circle_sv.PNG'),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        child: Text("Services",style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 11),fontWeight: FontWeight.bold
                        ),),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
