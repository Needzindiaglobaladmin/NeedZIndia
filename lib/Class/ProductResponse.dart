import 'package:NeedZIndia/Class/ProductData.dart';


class ProductResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  //final dynamic data;
  final List<ProductData> data;

  ProductResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var productList = json['data'] as List;
    //print('ProductList<>'+ ProductList.toString());
    //for(int i=0;i<ProductList.length;i++){
     // print('Productitem='+ ProductList[i].toString());
   // }
    return ProductResponse(
        status: json['status'],
        success: json['success'],
        message: json['message'],
        userFriendlyMessage: json['userFriendlyMessage'],
        data: productList.map((e) => ProductData.fromJson(e)).toList()
    );
  }
}