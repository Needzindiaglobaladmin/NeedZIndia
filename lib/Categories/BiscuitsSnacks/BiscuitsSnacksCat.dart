import 'package:NeedZIndia/Categories/BiscuitsSnacks/BisSnackGrid.dart';
import 'package:NeedZIndia/Categories/BiscuitsSnacks/CarouselproBisSnacks.dart';
import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:NeedZIndia/Screen/SearchBar.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class BiscuitsSnacksCat extends StatefulWidget {
  final List<String> searchData;
  BiscuitsSnacksCat({Key key,this.searchData}) : super(key: key );
  @override
  _BiscuitsSnacksCat createState() => _BiscuitsSnacksCat();
}

class _BiscuitsSnacksCat extends State<BiscuitsSnacksCat> {

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
          child:Text('Snacks', style: GoogleFonts.quicksand()),
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
                CarouselproBisSnacks(),
                SizedBox(height: 3,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                ListTile(
                  title: Text('Biscuits',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Biscuits' ,)),
                  );},
                ),
                ListTile(
                  title: Text('Namkeen & Snacks',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname:'Namkeen & Snacks' ,)),
                  );
                  },
                ),
                ListTile(
                  title: Text('Chocolates',style: GoogleFonts.quicksand(
                  ),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Chocolates',)),
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
                SizedBox(height: 5,),
                BisSnackGrid(),
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