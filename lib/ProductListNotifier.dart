import 'dart:convert';
import 'dart:io';
import 'package:NeedZIndia/Class/ProductData.dart';
import 'package:NeedZIndia/Class/ProductResponse.dart';
import 'package:http/http.dart' as http;
import 'package:NeedZIndia/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListNotifier extends ChangeNotifier {
  List<ProductData> _data =[];
  List<String> _searchData =[];
  bool _load;
  int _quantityToBought;
  List<ProductData> get data => _data;
  List get searchData => _searchData;
  bool get load => _load;
  int  get quantityToBought => _quantityToBought;


  Future<ProductResponse> fetchProductsData (String brandName,String categoryName,String search,int offset) async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    Map<String, dynamic> queryParameters;
    if(brandName == null && categoryName == null){
      queryParameters = {
        'searchKeyword' : search,
        'offset':  offset.toString(),
      };
    }
    else if(brandName==null && search ==null){
      queryParameters = {
        'categoryName' : categoryName,
        'offset':  offset.toString(),
      };
    }
    else if(categoryName == null && search == null){
      queryParameters = {
        'brand' : brandName,
        'offset':  offset.toString(),
      };
    }
    var uri =
    Uri.https(Constant.URL, '/api/getProducts.php',queryParameters);
    print(uri.toString());
    final response = await http.get((uri),
      headers: <String, String>{HttpHeaders.authorizationHeader: token==null?"":token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
    );
    var response1 = ProductResponse.fromJson(json.decode(response.body));
    if (response1.success == true) {
      for(int i =0;i<response1.data.length;i++){
        _searchData.add(response1.data[i].productName);
        _searchData.add(response1.data[i].brand);
      }
      _data=response1.data;
      return response1;
    } else {
      return response1;
    }
  }

  Future<ProductResponse> fetchProductsOffset(String brandName,String categoryName,String search,int offset) async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    Map<String, dynamic> queryParameters;
      if(brandName == null && categoryName == null){
        queryParameters = {
          'searchKeyword' : search,
          'offset':  offset.toString(),
        };
      }
      else if(brandName==null && search ==null){
        queryParameters = {
          'categoryName' : categoryName,
          'offset':  offset.toString(),
        };
      }
      else if(categoryName == null && search == null){
        queryParameters = {
          'brand' : brandName,
          'offset':  offset.toString(),
        };
      }
      var uri =
      Uri.https(Constant.URL, '/api/getProducts.php',queryParameters);
      print(uri.toString());
      final response = await http.get((uri),
        headers: <String, String>{HttpHeaders.authorizationHeader: token==null?"":token,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      var response1 = ProductResponse.fromJson(json.decode(response.body));
      if (response1.success == true) {
        _data.addAll(response1.data);
        return response1;
      } else {
        return response1;
      }
  }


  set data(List productList){
    _data = productList;
    notifyListeners();
  }

  set searchData(List searchData){
    _searchData = searchData;
    notifyListeners();
  }

  set quantityToBought(int quantityToBought){
    _quantityToBought = quantityToBought;
    notifyListeners();
  }

  increment(index){
    _data[index].quantityToBeBought++;
    _data[index].counter++;
    notifyListeners();
  }

  decrement(index){
    _data[index].quantityToBeBought--;
    _data[index].counter--;
    notifyListeners();
  }

  changeCaught(index,value){
    _data[index].quantityToBeBought = value;
    _data[index].counter = value;
    notifyListeners();
  }

  upperLimitChange(index,value){
    _data[index].stocks = value;
    notifyListeners();
  }

}