import 'package:NeedZIndia/Categories/BabyCare/VerticalgridBaby.dart';
import 'package:NeedZIndia/Categories/BabyCare/VerticalgridBaby2.dart';
import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:NeedZIndia/Screen/SearchBar.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';

import '../../bloc_cartvalue.dart';

class BabyCare extends StatefulWidget {
  final List<String> searchData;
  BabyCare({Key key,this.searchData}) : super(key: key );
  @override
  _BabyCare createState() => _BabyCare();
}

class _BabyCare extends State<BabyCare> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final CartValue cartValue  = Provider.of<CartValue>(context);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing:0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child:Text('Baby Care', style: GoogleFonts.quicksand()),
        ),
        backgroundColor: Colors.cyan[600],
        actions: [
          IconButton(
            icon:Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchBar(searchQuery:widget.searchData)),
              );
            },
          ),
          new Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: new IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()),
                  );
                }),
              ),
              cartValue.cartValue != 0 ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    cartValue.cartValue.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ) : new Container()
            ],
          ),
        ],
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 3,),
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
                          thumbnail: NetworkImage('https://www.needzindia.com/Carousels_images/baby_car2_uhsobh.jpg'),
                          // size: 1.29MB
                          image: NetworkImage('https://www.needzindia.com/Carousels_images/baby_car2_uhsobh.jpg'),
                          height: 300,
                          width: 500,
                        ),
                        ProgressiveImage(
                          placeholder: AssetImage('assets/images/fade_image.jpg'),
                          // size: 1.87KB
                          thumbnail: NetworkImage('http://needzindia.com/api/carousel_images/1610797740.jpg'),
                          // size: 1.29MB
                          image: NetworkImage('http://needzindia.com/api/carousel_images/1610797740.jpg'),
                          height: 300,
                          width: 500,
                        ),
                      ],
                      dotSize: 4.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.white,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.white.withOpacity(0.0),
                      dotIncreasedColor: Colors.cyan,
                    )),
                SizedBox(height: 3,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
                VerticalgridBaby(),
                SizedBox(height: 5,),
                VerticalgridBaby2(),
                SizedBox(height: 10,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 8,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
