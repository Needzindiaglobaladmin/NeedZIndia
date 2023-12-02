import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:NeedZIndia/Screen/SearchBar.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NeedZIndia/Categories/Beautycare/BeautycareGrid.dart';
import 'package:NeedZIndia/Categories/Beautycare/CarouselproBeauty.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BeautycareCat extends StatefulWidget {
  final List<String> searchData;
  BeautycareCat({Key key,this.searchData}) : super(key: key );
  @override
  _BeautycareCat createState() => _BeautycareCat();
}

class _BeautycareCat extends State<BeautycareCat> {
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
          child:Text('Personal Care', style: GoogleFonts.quicksand()),
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
                CarouselproBeauty(),
                SizedBox(height: 3,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                ListTile(
                  title: Text('Soap & Skin Care',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Soap & Skin Care')),
                  );},
                ),
                ListTile(
                  title: Text('Hair care',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Hair care',)),
                  );
                  },
                ),
                ListTile(
                  title: Text('Oral Care',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Oral Care')),
                  );
                  },
                ),
                ListTile(
                  title: Text('Deo & Perfumes',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Deo & Perfumes')),
                  );
                  },
                ),
                ListTile(
                  title: Text('Men\'s Hygiene',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Men Hygiene')),
                  );},
                ),
                ListTile(
                  title: Text('Women\'s Hygiene',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Women Hygiene')),
                  );},
                ),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
                BeautycareGrid(),
                SizedBox(height: 5,),
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
