import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:NeedZIndia/Screen/SearchBar.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NeedZIndia/Categories/Beverages/CarouselproBeverages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';

class BeveragesCat extends StatefulWidget {
  final List<String> searchData;
  BeveragesCat({Key key,this.searchData}) : super(key: key );
  @override
  _BeveragesCat createState() => _BeveragesCat();
}

class _BeveragesCat extends State<BeveragesCat> {

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
          child:Text('Beverages', style: GoogleFonts.quicksand()),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 3,),
                CarouselproBeverages(),
                SizedBox(height: 3,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                ListTile(
                  title: Text('Tea & Coffee',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Tea & Coffee',)),
                  );},
                ),
                ListTile(
                  title: Text('Protein Drinks',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Protein Drinks',)),
                  );
                  },
                ),
                ListTile(
                  title: Text('Refreshments',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Refreshments',)),
                  );
                  },
                ),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
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
                          thumbnail: NetworkImage('https://www.needzindia.com/Carousels_images/refreshments.jpg'),
                          // size: 1.29MB
                          image: NetworkImage('https://www.needzindia.com/Carousels_images/refreshments.jpg'),
                          height: 300,
                          width: 500,
                        ),
                      ],
                      dotSize: 0.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.lightGreenAccent,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.white.withOpacity(0.10),
                    )),
                SizedBox(height: 3,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}