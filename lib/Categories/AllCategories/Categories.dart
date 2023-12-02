import 'package:NeedZIndia/Categories/Services/BodyCheckUp.dart';
import 'package:NeedZIndia/Categories/Services/PanCard.dart';
import 'package:NeedZIndia/Categories/Services/Passport.dart';
import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:NeedZIndia/Categories/AllCategories/CarouselCat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  @override
  _Categories createState() => _Categories();
}

class _Categories extends State<Categories> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:  FittedBox(fit:BoxFit.fitWidth,
          child: Text('Categories',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CarouselCat(),
              SizedBox(height: 5.0),
              SizedBox(height: 2,
                child: Container(
                  color: Colors.teal[500],
                  alignment: Alignment.center,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin:  EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: Text('Categories',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),),
              ),
              Container(
                  margin:  EdgeInsets.fromLTRB(10, 12, 5, 5),
                  child: Row(
                    children: <Widget>[
                      Text('Home Essentials',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),),
                      Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,)
                    ],
                  )
              ),
              SingleChildScrollView(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Atta & Rice')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/Atta_Rice_cat.jpg"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Flours')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/icon_flour.png"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Oil & Ghee')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/icon_oil.png"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Pulses')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/icon_pulses.png"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Salt & Sugar')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/icon_salt.png"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Spices & Masala')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/icon_spices.png"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Fast Food & Sauces')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/fastfood.PNG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Dry Fruits')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/Dry_Fruits_cat.JPG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Detergent & Soap')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/icon_detergent.jpg"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Home Cleaning')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/icon_home.jpg"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Health Care')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/icon_healthcare.JPG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Pooja Needs')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/Pooja_Needs_cat.JPG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Electronics')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/Electronics_cat.JPG"),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Row(
                    children: <Widget>[
                      Text('Personal Care',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),),
                      Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,)
                    ],
                  )
              ),
              SingleChildScrollView(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin:EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Soap & Skin Care')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/soap_skin.png"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Hair care')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/hair_care.png"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Oral Care')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/oralcare.jpg"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Deo & Perfumes')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/icon_deo&perfumes.jpg"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Men Hygiene')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/men_cat.jpg"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Women Hygiene')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/womens_cat.jpg"),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Row(
                    children: <Widget>[
                      Text('Baby Care',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),),
                      Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,)
                    ],
                  )
              ),
              SingleChildScrollView(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Baby Food')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/babyfood_cat.JPG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Baby Skin & Hair care')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/babyskin_cat.JPG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Diapers & Wipes')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/diapers_cat.JPG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Baby Utensils')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/babyutensil_cat.JPG"),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Row(
                    children: <Widget>[
                      Text('Biscuits, Snacks & Chocolates',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),),
                      Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,)
                    ],
                  )
              ),
              SingleChildScrollView(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Biscuits')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/biscuits_cat.jpg"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Namkeen & Snacks')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/snacks.PNG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Chocolates')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/chocolates.jpg"),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Row(
                    children: <Widget>[
                      Text('Beverages',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),),
                      Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,)
                    ],
                  )
              ),
              SingleChildScrollView(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Tea & Coffee')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/t&c.PNG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Protein Drinks')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/pdrinks.PNG"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Refreshments')),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/real.PNG"),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Row(
                    children: <Widget>[
                      Text('Services',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),),
                      Icon(Icons.navigate_next_sharp,color: Colors.blueGrey,)
                    ],
                  )
              ),
              SingleChildScrollView(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PanCard()),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/pan_cat.png"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Passport()),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/passport.jpg"),
                          )
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BodyCheckUp()),);
                          },
                          child:Container(
                            child: Image.asset("assets/images/checkup_cat.jpg"),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}