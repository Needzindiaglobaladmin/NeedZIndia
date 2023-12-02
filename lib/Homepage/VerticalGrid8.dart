
import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NeedZIndia/SizeConfig.dart';

class VerticalGrid8 extends StatelessWidget {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Tea & Coffee')),);
                },
                child: Container(
                  height: SizeConfig.blockSizeVertical * 20,
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/TeaTile.jpg"),
                        fit: BoxFit.fill,),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ), ),
            SizedBox(height: 10,),
            Expanded(
              child:GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Protein Drinks')),);
                },
                child: Container(
                  height: SizeConfig.blockSizeVertical * 20,
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/ProteinDrinksTile.jpg"),
                        fit: BoxFit.fill,),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ), ),
            SizedBox(height: 10,),
            Expanded(
              child:GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(categoryname: 'Refreshments')),);
                },
                child: Container(
                  height: SizeConfig.blockSizeVertical * 20,
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/RefreshmentsTile.jpg"),
                        fit: BoxFit.fill,),
                      borderRadius: BorderRadius.all(Radius.circular(10.0),)),
                ),
              ), ),
          ],
        )
    );
  }
}