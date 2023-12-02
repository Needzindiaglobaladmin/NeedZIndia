
import 'package:NeedZIndia/SizeConfig.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';


class CarouselCat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Column(
        children: <Widget>[
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
                      thumbnail: NetworkImage('https://www.needzindia.com/Carousels_images/Home_essentials.jpg'),
                      // size: 1.29MB
                      image: NetworkImage('https://www.needzindia.com/Carousels_images/Home_essentials.jpg'),
                      height: 300,
                      width: 500,
                    ),
                    ProgressiveImage(
                      placeholder: AssetImage('assets/images/fade_image.jpg'),
                      // size: 1.87KB
                      thumbnail: NetworkImage('https://www.needzindia.com/Carousels_images/sbccar.jpg'),
                      // size: 1.29MB
                      image: NetworkImage('https://www.needzindia.com/Carousels_images/sbccar.jpg'),
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
        ],
      ),
    );
  }
}


