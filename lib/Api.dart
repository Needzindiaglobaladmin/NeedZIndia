import 'dart:io';
import 'package:NeedZIndia/Class/AddCartResponse.dart';
import 'package:NeedZIndia/Class/CancelSlotResponse.dart';
import 'package:NeedZIndia/Class/PlaceOrder.dart';
import 'package:NeedZIndia/Class/UserRequestResponse.dart';
import 'package:NeedZIndia/Class/removeCart.dart';
import 'package:NeedZIndia/Class/SlotBookingResponse.dart';
import 'package:NeedZIndia/Class/LoginResponse.dart';
import 'package:NeedZIndia/Class/OtpResponse.dart';
import 'package:NeedZIndia/Class/AddAddressResponse.dart';
import 'package:NeedZIndia/Class/DeleteAddressResponse.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:NeedZIndia/screen/editaddress.dart';
import 'package:NeedZIndia/screen/mydetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


Future<LoginResponse> loginuser(String countryCode ,String mobile, String appSignature ) async {
  String url = Constant.INIT_LOGIN_API;
  print(Uri.https(Constant.URL , url));
  final response = await http.post(Uri.parse(Constant.apiShort_Url + url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'countryCode':countryCode,'mobile':mobile,'appSignature':appSignature}
  );
  var convertedDatatoJson = LoginResponse.fromJson(jsonDecode(response.body)) ;
  return convertedDatatoJson;
}

Future<TokenResponse> verification(String deviceKey , String otp, String firebaseToken) async {
 String url = Constant.LOGIN_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'deviceKey':deviceKey,'otp':otp,'firebaseToken':firebaseToken}
  );
  var convertedDatatoJson = TokenResponse.fromJson(jsonDecode(response.body)) ;
  return convertedDatatoJson;
}

Future<UserResponse> userdata(String firstName , String lastName, String gender, String emailId,String mobile) async {
  var _prefs =await SharedPreferences.getInstance();
  final String token = _prefs.getString('token');
  print(token);
  String url = Constant.UPDATE_USERDATA_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'firstName': firstName,'lastName':lastName,'gender':gender,emailId ==''?'':'emailId':emailId,'mobile': mobile}
  );

  var convertedDatatoJson = UserResponse.fromJson(jsonDecode(response.body)) ;
  return convertedDatatoJson;
}


Future getuserdata(String mobile) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  print(token);
  String url = Constant.GET_USERDATA_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'mobile': mobile}
  );
  print(response.body);
  var convertedDatatoJson =jsonDecode(response.body) ;
  return convertedDatatoJson;
}

Future <AddressResponse>addAddress( String type, String name,String mobileNumber, String alternateMobileNumber, String street, String landmark, String district, String city, String pincode, String state, String country) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  String url = Constant.ADD_ADDRESS_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'type':type,'name':name,'mobileNumber':mobileNumber,'alternateMobileNumber':alternateMobileNumber,'street': street,'landmark': landmark,'district': district,
        'city': city,'pincode': pincode,'state': state,'country': country}
  );
  var convertedDatatoJson = AddressResponse.fromJson(jsonDecode(response.body)) ;
  return convertedDatatoJson;
}

Future <DelAddressResponse>deleteaddresses(String mobile, String addressId) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  String url = Constant.DELETE_ADDRESS_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'mobile': mobile,'addressId': addressId}
  );
  print(response.body);
  var convertedDatatoJson = DelAddressResponse.fromJson(jsonDecode(response.body)) ;
  return convertedDatatoJson;
}

Future <UpdateAddressResponse>updateaddress( String mobile, String id,String type, String name,String mobileNumber, String alternateMobileNumber, String street, String landmark, String district, String city, String pincode, String state, String country) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  print(token);
  String url = Constant.UPDATE_ADDRESS_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'mobile':mobile,'id':id,'type':type,'name':name,'mobileNumber':mobileNumber,'alternateMobileNumber':alternateMobileNumber,'street': street,'landmark': landmark,'district': district,
        'city': city,'pincode': pincode,'state': state,'country': country}
  );
  var convertedDatatoJson = UpdateAddressResponse.fromJson(jsonDecode(response.body))  ;
  return convertedDatatoJson;
}

Future <AddCartResponse>addCart(String mobile, String stockId,String quantityToBeBought) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  print(token);
  String url = Constant.ADDTOCART_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'mobile': mobile,'stockId': stockId,'quantityToBeBought':quantityToBeBought}
  );
  print(response.body);
  var convertedDatatoJson = AddCartResponse.fromJson(jsonDecode(response.body))  ;
  return convertedDatatoJson;
}

Future <RemoveCartResponse>removeCart(String mobile, String cartId,String remove,String newQuantityToBeBought) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  print(token);
  String url = Constant.UPDATE_CART_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'mobile': mobile,'cartId': cartId,'remove':remove,'newQuantityToBeBought':newQuantityToBeBought}
  );
  print(response.body);
  var convertedDatatoJson = RemoveCartResponse.fromJson(jsonDecode(response.body))  ;
  return convertedDatatoJson;
}

Future <PlaceOrderResponse>placeOrder(String mobile, String deliveryAddressId,String paymentMethod, String cartIds, String couponCode) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  print(token);
  String url = Constant.PLACE_ORDER_API ;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'mobile': mobile,'deliveryAddressId': deliveryAddressId,'paymentMethod':paymentMethod,'cartIds':cartIds,'couponCode':couponCode}
  );
  print(response.body);
  var convertedDatatoJson = PlaceOrderResponse.fromJson(jsonDecode(response.body));
  return convertedDatatoJson;
}

Future <RemoveCartResponse>updateCart(String mobile, String cartId,String newQuantityToBeBought) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  print(token);
  String url = Constant.UPDATE_CART_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'mobile': mobile,'cartId': cartId,'newQuantityToBeBought':newQuantityToBeBought}
  );
  print(response.body);
  var convertedDatatoJson = RemoveCartResponse.fromJson(jsonDecode(response.body))  ;
  return convertedDatatoJson;
}

Future <SlotBookingResponse>slotBooking(String mobile,String bookingDate, String timeSlotId, String serviceId,String deliveryAddressId,String paymentMethod,String numOfPersons) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  print(token);
  String url = Constant.BOOK_SLOT_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'mobile': mobile,'bookingDate': bookingDate, 'timeSlotId':timeSlotId,'serviceId':serviceId,'deliveryAddressId':deliveryAddressId,'paymentMethod':paymentMethod,'numOfPersons':numOfPersons}
  );
  print(response.body);
  var convertedDatatoJson = SlotBookingResponse.fromJson(jsonDecode(response.body))  ;
  return convertedDatatoJson;
}


Future <CancelSlotResponse> cancelSlot(String serviceBookingId) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  print(token);
  String url = Constant.CANCEL_SLOT_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'serviceBookingId': serviceBookingId}
  );
  print(response.body);
  var convertedDatatoJson = CancelSlotResponse.fromJson(jsonDecode(response.body))  ;
  return convertedDatatoJson;
}

Future <UserRequestResponse> userRequest(String requestTypeId, String description) async {
  var _prefs =await SharedPreferences.getInstance();
  var token = _prefs.getString('token');
  print(token);
  String url = Constant.STORE_USER_REQUEST_API;
  final response = await http.post(Uri.parse(Constant.apiShort_Url+ url),
      headers: <String, String>{HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },  body: {'requestTypeId': requestTypeId,'description':description}
  );
  print(response.body);
  var convertedDataToJson = UserRequestResponse.fromJson(jsonDecode(response.body))  ;
  return convertedDataToJson;
}