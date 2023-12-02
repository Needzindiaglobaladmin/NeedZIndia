import 'dart:convert';
import 'dart:io';
import 'package:NeedZIndia/Class/updateUserClass.dart';
import 'package:http/http.dart' as http;
import 'package:NeedZIndia/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataNotifier extends ChangeNotifier {
  String _userName;
  String _imageUrl;
  String get userName => _userName;
  String get imageUrl => _imageUrl;



  Future<UpdateUserResponse> getJsonData() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var mobile = _prefs.getString('mobile');
    var firstName = _prefs.getString('firstName');
    var imageUrl =  _prefs.getString('imageUrl');
    print(mobile);
    if(firstName == null){
      try{
        final response = await http.post(Uri.parse(Constant.apiShort_Url+ Constant.GET_USERDATA_API),
            headers: <String, String>{HttpHeaders.authorizationHeader: token==null?"":token,
              'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            },  body: {'mobile': mobile}
        );
        print(response.body);
        var responseUser = UpdateUserResponse.fromJson(json.decode(response.body));
        if (responseUser.success == true) {
          print('response body : ${response.body}');
          _userName = responseUser.data.firstName;
          print(responseUser.data.imageUrl);
          if(responseUser.data.imageUrl == null){
            _imageUrl = 'https://www.needzindia.com/images/pp.png';
          }
          else{
            _imageUrl = responseUser.data.imageUrl;
            print(_imageUrl);
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('firstName', responseUser.data.firstName );
          prefs.setString('lastName', responseUser.data.lastName );
          prefs.setString('gender', responseUser.data.gender );
          prefs.setString('emailId', responseUser.data.emailId );
          prefs.setString('imageUrl', responseUser.data.imageUrl);
          return responseUser;

        } else {
          print(responseUser.userFriendlyMessage);
        }
      }on Exception catch (e){
        print("Something went wrong");
      }
    }
    else{
      _userName = firstName;
      if(imageUrl==null){
        _imageUrl ='https://www.needzindia.com/images/pp.png';
      }
      else{
        _imageUrl = imageUrl;
      }
    }
  }


  set userName(String userName){
    _userName = userName;
    notifyListeners();
  }
  set imageUrl(String imageUrl){
    _imageUrl = imageUrl;
    notifyListeners();
  }

  nameChanged(userName){
    _userName = userName;
    print(_userName);
    notifyListeners();
  }

  imageChanged(imageUrl){
     _imageUrl = imageUrl;
    notifyListeners();
  }
}