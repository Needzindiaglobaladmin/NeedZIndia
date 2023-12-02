import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NeedZIndia/SizeConfig.dart';

class BisSnackGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child:Row(
          children: <Widget>[
            SizedBox(height: 10,),
            Expanded(
              child:GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: 'Haldiram',)),);
                },
                child: Container(
                  height: SizeConfig.blockSizeVertical * 30,
                  margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/haldiram.JPG"),
                        fit: BoxFit.fill,),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ), ),
            SizedBox(height: 10,),
            Expanded(
              child:GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: 'Britannia',)),);
                },
                child: Container(
                  height: SizeConfig.blockSizeVertical * 30,
                  margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/britania_grid.PNG"),
                        fit: BoxFit.fill,),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ), ),
          ],
        )
    );
  }
}