import 'dart:io';
import 'package:NeedZIndia/Categories/AllCategories/Categories.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:NeedZIndia/Class/CarouselImages.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Carouselpro extends StatefulWidget {
  @override
  _Carouselpro createState() => _Carouselpro();
}

class _Carouselpro extends State<Carouselpro> {
  bool loading = true;
  String carouselImages="";

  @override
  void initState(){
    super.initState();
    fetchCarouselData();
  }
  Future<CarouselImagesResponse> fetchCarouselData() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try{
      //showAlertDialog(context);
      final url = Constant.GET_CAROUSEL_API;
      final response = await http.get(Uri.parse(Constant.apiShort_Url+ url),
        headers: <String, String>{HttpHeaders.authorizationHeader: token==null?"":token,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      print("${response.body}");
      var response1 = CarouselImagesResponse.fromJson(json.decode(response.body));
      if (response1.success == true) {
        for(int i =0;i<response1.data.carouselData.length;i++){
          if(response1.data.carouselData[i].carouselName == "TopCarousel"){
            setState(() {
              carouselImages = response1.data.carouselData[i].imageUrl;
              print(carouselImages);
            });
          }
        }
        setState(() {
          loading=false;
        });
        return response1;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response1.userFriendlyMessage),
            backgroundColor: Colors.red));
      }
    }on Exception catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
              height: SizeConfig.blockSizeVertical * 25,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                autoplayDuration: Duration(seconds: 5),
                boxFit: BoxFit.fill,
                images:[
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Categories()),);
                    },
                    child: ProgressiveImage(
                      placeholder: AssetImage('assets/images/fade_image.jpg'),
                      // size: 1.87KB
                      thumbnail: carouselImages.isEmpty?AssetImage('assets/images/fade_image.jpg'):NetworkImage(carouselImages),
                      // size: 1.29MB
                      image: carouselImages.isEmpty?AssetImage('assets/images/fade_image.jpg'):NetworkImage(carouselImages),
                      height: 300,
                      width: 500,
                    ),
                  )
                ],
                dotSize:0.0,
                dotSpacing: 15.0,
                dotColor: Colors.white,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.white.withOpacity(0.0),
                dotIncreasedColor: Colors.cyan,
              )),
        ],
      ),
    );
  }
}
