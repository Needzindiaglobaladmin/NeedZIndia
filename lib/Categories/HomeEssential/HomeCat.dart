import 'package:NeedZIndia/Categories/HomeEssential/HomeGrid.dart';
import 'package:NeedZIndia/Categories/HomeEssential/CarouselproHome.dart';
import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:NeedZIndia/Screen/SearchBar.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeCat extends StatefulWidget {
  final List<String> searchData;
  HomeCat({Key key,this.searchData}) : super(key: key );
  @override
  _HomeCat createState() => _HomeCat();
}

class _HomeCat extends State<HomeCat> {


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
          child:Text('Home Essentials', style: GoogleFonts.quicksand()),
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
                CarouselproHome(),
                SizedBox(height: 3,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                ListTile(
                  title: Text('Atta & Rice',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Atta & Rice')),
                  );},
                ),
                ListTile(
                  title: Text('Flours',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Flours')),
                  );},
                ),
                ListTile(
                  title: Text('Oil & Ghee',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Oil & Ghee')),
                  );
                  },
                ),
                ListTile(
                  title: Text('Pulses',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Pulses')),
                  );
                  },
                ),
                ListTile(
                  title: Text('Salt & Sugar',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Salt & Sugar')),
                  );},
                ),
                ListTile(
                  title: Text('Spices & Masala',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Spices & Masala' ,)),
                  );},
                ),
                ListTile(
                  title: Text('Fast Food & Sauces',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Fast Food & Sauces' ,)),
                  );},
                ),
                ListTile(
                  title: Text('Dry Fruits',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Dry Fruits' ,)),
                  );},
                ),
                ListTile(
                  title: Text('Detergent & Soap',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Detergent & Soap' ,)),
                  );},
                ),
                ListTile(
                  title: Text('Home Care',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Home Cleaning' ,)),
                  );},
                ),
                ListTile(
                  title: Text('Health Care',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Health Care' ,)),
                  );},
                ),
                ListTile(
                  title: Text('Pooja Needs',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Pooja Needs' ,)),
                  );},
                ),
                ListTile(
                  title: Text('Electronics',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Electronics' ,)),
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
                HomeGrid(),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}