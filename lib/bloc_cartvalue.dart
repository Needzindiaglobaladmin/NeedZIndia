import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:NeedZIndia/Class/GetCart.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartValue extends ChangeNotifier{
  int _cartValue =0;
  int get cartValue => _cartValue;


  Future<GetCartResponse> fetchCartData() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    final url = Constant.GET_CART_API;
    final response = await http.get(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
    );
    print("${response.body}");
    var response1 = GetCartResponse.fromJson(json.decode(response.body));
    if (response1.success == true) {
      _cartValue = response1.data.cartItems.length;
      print(_cartValue);
      return response1;
    } else {
      return response1;
    }
  }

  set cartValue(int cartValue){
    _cartValue = cartValue;
    notifyListeners();
  }

  increment(){
    _cartValue++;
    notifyListeners();
  }

  decrement(){
    if(_cartValue>0){
      _cartValue--;
    }
    notifyListeners();
  }

  clear(){
    _cartValue = 0;
    notifyListeners();
  }

}