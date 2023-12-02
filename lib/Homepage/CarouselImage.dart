import 'dart:io';

import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:NeedZIndia/Class/CarouselImages.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class CarouselImage extends StatefulWidget {
  @override
  _CarouselImage createState() => _CarouselImage();
}

class _CarouselImage extends State<CarouselImage> {
  bool loading = true;
  List<CarouselData> carouselImages = [];
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
        setState(() {
          carouselImages = response1.data.carouselData;
          loading=false;
        });
        carouselImages.removeWhere((carouselName) => carouselName.carouselName != "carousel1");
        return response1;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response1.userFriendlyMessage),
            backgroundColor: Colors.red));      }
    }on Exception catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical * 24,
            child: loading ? CarouselSlider(
              options: CarouselOptions(
                height: 350,
                aspectRatio: 16/9,
                viewportFraction: 0.95,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.linear,
              ),
              items: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: GestureDetector(
                    child: ProgressiveImage(
                      placeholder: AssetImage('assets/images/fade_image.jpg'),
                      // size: 1.87KB
                      thumbnail: AssetImage('assets/images/fade_image.jpg'),
                      // size: 1.29MB
                      image: AssetImage('assets/images/fade_image.jpg'),
                      height: 300,
                      width: 500,
                    ),
                  ),
                )
              ]
            ):CarouselSlider(
              options: CarouselOptions(
                height: 350,
                aspectRatio: 16/9,
                viewportFraction: 0.95,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items:  carouselImages.map(
                    (i) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: GestureDetector(
                      child: ProgressiveImage(
                        placeholder: AssetImage('assets/images/fade_image.jpg'),
                        // size: 1.87KB
                        thumbnail: NetworkImage(i.imageUrl),
                        // size: 1.29MB
                        image: NetworkImage(i.imageUrl),
                        height: 300,
                        width: 500,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName : i.redirectAppPageName)),);
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
