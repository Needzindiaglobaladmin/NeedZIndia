import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:NeedZIndia/Api.dart';
import 'package:NeedZIndia/Class/GetAddress.dart';
import 'package:NeedZIndia/Class/GetCart.dart';
import 'package:NeedZIndia/ProductListNotifier.dart';
import 'package:NeedZIndia/Screen/ApplyCoupons.dart';
import 'package:NeedZIndia/Screen/SelectAddress.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Cart extends StatefulWidget {
  final String coupon;
  Cart({Key key, this.coupon}) : super(key: key );
  @override
  _Cart createState() => _Cart();
}

class _Cart extends State<Cart> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  final dataKey = new GlobalKey();
  double price = 0;
  double discount = 0;
  double afterDiscount = 0;
  double after = 0;
  var delivery;
  double totalAmount = 0;
  String deliverycharges = '';
  int quantity = 0;
  bool loading = true;
  List <GetAddressData>address = [];
  int cartId;
  List id = [];
  List cartProductId =[];
  List cartIds =[];
  String addressId ;
  List<CartItems> cart =[];
  List selectQuantity = [1,2,3,4,5];
  String street ='';
  String fullName='';
  String landmark='';
  String district='';
  String city='';
  String state='';
  String country='';
  String mobileNum='';
  String pin='';
  String type='';
  String specialDiscount ='';
  String coupon = '';
  bool firstClick = true;
  bool freeDelivery = false;
  double amountForFreeDelivery;
  @override
  void initState() {
    super.initState();
    this.fetchCartData();
  }


  Future<GetCartResponse> fetchCartData() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try{
      var queryParameters;
      if(widget.coupon == null )
      {
        queryParameters = {
          'couponCode' :'',
        };
      }
      else{
        queryParameters = {
          'couponCode' :widget.coupon,
        };
      }
      var uri =
      Uri.https( Constant.URL,'/api/getCart.php',queryParameters);
      final response = await http.get(uri,
        headers: <String, String>{HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      var response1 = GetCartResponse.fromJson(json.decode(response.body));
      if (response1.success == true) {
        if(mounted){
          setState(()  {
            quantity = response1.data.cartItems.length;
            cart = response1.data.cartItems;
            print(cart);
            price = response1.data.cartPrice;
            specialDiscount = response1.data.specialDiscount.toString();
            coupon = response1.data.couponApplied;
            amountForFreeDelivery =  699 - response1.data.cartPayableTotal;
            if(response1.data.deliveryCharge==0){
              deliverycharges = 'Free';
              totalAmount = response1.data.cartPayableTotal;
            }
            else{
              totalAmount = response1.data.cartPayableTotal;
              deliverycharges= '₹' + response1.data.deliveryCharge.toString();
            }
            afterDiscount = response1.data.cartPrice - response1.data.cartDiscountedPrice;
            if(cartIds.isEmpty == true){
              for(int i=0;i<response1.data.cartItems.length;i++){
                if(response1.data.cartItems[i].stocks != 0){
                  var orderitem = (response1.data.cartItems[i].cartId);
                  cartProductId.add(orderitem);
                }
              }
              cartIds = cartProductId;
            }
            else{
              cartIds = cartProductId;
            }
            if(response1.data.cartPayableTotal>=699){
              if(mounted){
                setState(() {
                  freeDelivery = true;
                });
              }
              else{
                setState(() {
                  freeDelivery = false;
                });
              }
            }

            loading = false;
          });
        }
        print(cartIds);
        return response1;
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(response1.userFriendlyMessage.toUpperCase(),style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18),fontWeight: FontWeight.bold,color: Colors.redAccent),textAlign: TextAlign.center,),
                        SizedBox(height: 5,),
                        Text('Click OK to continue',style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 14)),textAlign: TextAlign.center,),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          alignment: Alignment.centerRight,
                          width: 60.0,
                          child: RaisedButton(
                            onPressed: ()  {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Cart()));
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }
    }on Exception catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }


  @override
  Widget build(BuildContext context) {
    final CartValue cartValue  = Provider.of<CartValue>(context);
    final ProductListNotifier productsList  = Provider.of<ProductListNotifier>(context);
    return Scaffold(
      key: globalScaffoldKey,
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('My Cart',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body:loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) : cart.isEmpty == true ? SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Flexible(child:SizedBox(
                height: 70,
                child: Container(
                  color: Color(0xFFFFFFFF),
                ),
              ), ),
              Container(
                width: double.infinity,
                height: 250,
                margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: Image.asset(
                  "assets/images/empty_shopping_cart.png",
                  height: 250,
                  width: double.infinity,
                ),
              ),
              Flexible(child:SizedBox(
                height: 40,
                child: Container(
                  color: Color(0xFFFFFFFF),
                ),
              ), ),
              Flexible(
                  child:Container(
                    width: double.infinity,
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(
                        color: Color(0xFF67778E),
                        fontFamily: 'Roboto-Light.ttf',
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ) ),
            ],
          ),
        ),
      ) : loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) : SafeArea(
        child: SingleChildScrollView(
          physics: new BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      //color: Colors.blueGrey[500],
                      width: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey[100],
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 4.0,
                        spreadRadius: 0.0,
                      ),
                    ]),
                margin: EdgeInsets.fromLTRB(6,4,6,0),
                width: MediaQuery.of(context).size.width ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                              child:  Icon(
                                Icons.delivery_dining,size: 25,color: Colors.cyan,
                              ),
                            ),
                          ),
                          freeDelivery?FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Yay! You got free delivery",style: GoogleFonts.quicksand(
                                textStyle: TextStyle(),color:Colors.blueGrey,fontWeight: FontWeight.bold),
                            ),
                          ):FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "₹"+amountForFreeDelivery.toStringAsFixed(0)+" away from free delivery",style: GoogleFonts.quicksand(
                                textStyle: TextStyle(),color:Colors.blueGrey,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              ListView.builder(
                  physics: new BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:  cart.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              cart[index].stocks==0?
                              GestureDetector(
                                child: Container(
                                  color: Colors.grey[300],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          foregroundDecoration: BoxDecoration(
                                            color: Colors.grey,
                                            backgroundBlendMode: BlendMode.saturation,
                                          ),
                                          margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
                                          height: 130,
                                          width: 150,
                                          child: Image.network(cart[index].imageUrl),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(cart[index].productName,style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,),fontWeight: FontWeight.bold),),
                                              SizedBox(height:5,),
                                              Text(cart[index].brand,style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,),),),
                                              SizedBox(height: 5,),
                                              Text(cart[index].variantName,style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,)),),
                                              Text("Out of Stock",style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,color: Colors.red)),),
                                              SizedBox(height: 5,),
                                              GestureDetector(
                                                child: Container(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                      foregroundDecoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        backgroundBlendMode: BlendMode.saturation,
                                                      ),
                                                      height: 35,
                                                      width: 90,
                                                      child: Row(
                                                        children: <Widget>[
                                                          cart[index].cartUpdating ? SizedBox(height:15,width:20,child: CircularProgressIndicator( strokeWidth: 2.0,valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),):IconButton(
                                                            icon: Icon(Icons.delete_outline_sharp,color: Colors.red,),
                                                            onPressed: ()  async {
                                                              var _prefs =await SharedPreferences.getInstance();
                                                              var mobile = _prefs.getString('mobile');
                                                              var cartId = cart[index].cartId.toString();
                                                              var newQuantityToBeBought = cart[index].quantityToBeBought.toString();
                                                              var remove = true.toString();
                                                              print(cartId);
                                                              print(newQuantityToBeBought);
                                                              print(remove);
                                                              try {
                                                                if (mounted) {
                                                                  setState(() {
                                                                    cart[index].cartUpdating = true;
                                                                  });
                                                                }
                                                                var rsp= await removeCart(mobile,cartId,remove,newQuantityToBeBought);
                                                                if (mounted) {
                                                                  setState(() {
                                                                    cart[index].cartUpdating = false;
                                                                  });
                                                                }
                                                                fetchCartData();
                                                                for(int i=0;i<productsList.data.length;i++){
                                                                  if(productsList.data[i].productId == cart[index].productId){
                                                                    if(mounted){
                                                                      setState(() {
                                                                        productsList.data[i].add = false;
                                                                        productsList.data[i].addedToCart = false;
                                                                      });
                                                                    }
                                                                  }
                                                                }
                                                                if(rsp.success==false){
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                      content: Text(rsp.userFriendlyMessage),
                                                                      backgroundColor: Colors.red));
                                                                }
                                                                else{
                                                                  print("clicked");
                                                                  cartValue.decrement();
                                                                  print(rsp.userFriendlyMessage);
                                                                  for(int i = 0; i<cartIds.length;i++){
                                                                    if(cartIds[i]==cart[index].cartId){
                                                                      cartIds.removeAt(i);
                                                                      print(cartIds);
                                                                    }
                                                                  }
                                                                }
                                                              }on Exception catch (e){
                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ):
                              GestureDetector(
                                onTap: (){

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        //color: Colors.blueGrey[500],
                                        width: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blueGrey[100],
                                          offset: const Offset(
                                            0.0,
                                            0.0,
                                          ),
                                          blurRadius: 4.0,
                                          spreadRadius: 0.0,
                                        ),
                                      ]),
                                  margin: EdgeInsets.fromLTRB(6,0,6,0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                          height: 130,
                                          width: 150,
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/images/loading.gif',
                                            image: cart[index].imageUrl,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin:EdgeInsets.fromLTRB(0, 15, 0, 8),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex:2,
                                                      child: Text("₹" + cart[index].discountedPrice.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                                          textStyle: TextStyle(fontSize: 18),fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                                    ),
                                                    SizedBox(width: 2,),
                                                    cart[index].discountPercentage==0?Container():
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("₹" + cart[index].price.toStringAsFixed(0),style: GoogleFonts.quicksand(
                                                          textStyle: TextStyle(fontSize: 15,decoration: TextDecoration.lineThrough)),),
                                                    ),
                                                    SizedBox(width: 2,),
                                                    cart[index].discountPercentage==0?Container():
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                        height: 20,
                                                        width: 40,
                                                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                            width: 0.5,
                                                          ),
                                                          borderRadius: BorderRadius.circular(2),
                                                          color: Colors.cyan[500],
                                                        ),
                                                        child: Text(
                                                          cart[index].discountPercentage.round().toString() +"%",
                                                          style: GoogleFonts.quicksand(
                                                              textStyle: TextStyle(fontSize: 15),color:Colors.white ),
                                                          textAlign: TextAlign.center,),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Text(cart[index].productName,style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,),fontWeight: FontWeight.bold),),
                                              SizedBox(height:5,),
                                              Text(cart[index].brand,style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,),),),
                                              SizedBox(height: 5,),
                                              Text(cart[index].variantName,style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,)),),
                                              SizedBox(height: 5,),
                                              Text(cart[index].stocks.toString()+" left in stock",style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 12,color: Colors.red)),),
                                              SizedBox(height: 5,),
                                              GestureDetector(
                                                child: Container(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                      color: Colors.white,
                                                      height: 35,
                                                      width: 90,
                                                      child: Row(
                                                        children: <Widget>[
                                                          cart[index].quantityToBeBought == 1?
                                                          Expanded(
                                                            child:Container(
                                                              child:IconButton(
                                                                icon: Icon(Icons.delete_outline_sharp,color: Colors.red,),
                                                                onPressed: ()  async {
                                                                  var _prefs =await SharedPreferences.getInstance();
                                                                  var mobile = _prefs.getString('mobile');
                                                                  var cartId = cart[index].cartId.toString();
                                                                  var newQuantityToBeBought = cart[index].quantityToBeBought.toString();
                                                                  var remove = true.toString();
                                                                  print(cartId);
                                                                  print(newQuantityToBeBought);
                                                                  print(remove);
                                                                  try {
                                                                    if (mounted) {
                                                                      setState(() {
                                                                        cart[index].cartUpdating = true;
                                                                      });
                                                                    }
                                                                    var rsp= await removeCart(mobile,cartId,remove,newQuantityToBeBought);
                                                                    if (mounted) {
                                                                      setState(() {
                                                                        cart[index].cartUpdating = false;
                                                                      });
                                                                    }
                                                                    if(rsp.success==false){
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                          content: Text(rsp.userFriendlyMessage),
                                                                          backgroundColor: Colors.red));
                                                                    }
                                                                    else{
                                                                      fetchCartData();
                                                                      for(int i=0;i<productsList.data.length;i++){
                                                                        if(productsList.data[i].productId == cart[index].productId){
                                                                          if(mounted){
                                                                            setState(() {
                                                                              productsList.data[i].add = false;
                                                                              productsList.data[i].addedToCart = false;
                                                                            });
                                                                          }
                                                                        }
                                                                      }
                                                                      print("clicked");
                                                                      cartValue.decrement();
                                                                      print(rsp.userFriendlyMessage);
                                                                      for(int i = 0; i<cartIds.length;i++){
                                                                        if(cartIds[i]==cart[index].cartId){
                                                                          cartIds.removeAt(i);
                                                                          print(cartIds);
                                                                        }
                                                                      }
                                                                    }
                                                                  }on Exception catch (e){
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ): Expanded(
                                                            child:Container(
                                                              child:IconButton(
                                                                icon: Icon(Icons.remove,color: Colors.cyan[600],),
                                                                onPressed: () async {
                                                                  if(cart[index].quantityToBeBought>1){
                                                                    cart[index].quantityToBeBought--;
                                                                    var _prefs =await SharedPreferences.getInstance();
                                                                    var mobile = _prefs.getString('mobile');
                                                                    var cartId = cart[index].cartId.toString();
                                                                    var newQuantityToBeBought = cart[index].quantityToBeBought.toString();
                                                                    try {
                                                                      if (mounted) {
                                                                        setState(() {
                                                                          cart[index].cartUpdating = true;
                                                                        });
                                                                      }
                                                                      var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                                                      if (mounted) {
                                                                        setState(() {
                                                                          cart[index].cartUpdating = false;
                                                                        });
                                                                      }
                                                                      if(rsp.success==false){
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content: Text(rsp.userFriendlyMessage),
                                                                            backgroundColor: Colors.red));
                                                                      }
                                                                      else{
                                                                        fetchCartData();
                                                                        print(rsp.userFriendlyMessage);
                                                                        for(int i=0;i<productsList.data.length;i++){
                                                                          if(productsList.data[i].cartId == cart[index].cartId){
                                                                            productsList.decrement(i);
                                                                          }
                                                                        }
                                                                      }
                                                                    }on Exception catch (e){
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              color: Colors.white,
                                                              margin: EdgeInsets.fromLTRB(5, 4, 0, 0),
                                                              child: cart[index].cartUpdating ? Container(
                                                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                height:15,
                                                                width:2,
                                                                child: CircularProgressIndicator( strokeWidth: 2.0,valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),
                                                              ):Container(
                                                                  alignment:Alignment.center,
                                                                  width:100,
                                                                  child:Text(cart[index].quantityToBeBought.toString(),style: TextStyle(fontSize: 16,color: Colors.black),)),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              child: IconButton(
                                                                icon: Icon(Icons.add,color: Colors.cyan[600],),
                                                                onPressed: () async {
                                                                  var upperLimit;
                                                                  cart[index].stocks<=10? upperLimit=cart[index].stocks: upperLimit=10;
                                                                  if(cart[index].quantityToBeBought<upperLimit){
                                                                    cart[index].quantityToBeBought++;
                                                                    var _prefs =await SharedPreferences.getInstance();
                                                                    var mobile = _prefs.getString('mobile');
                                                                    var cartId = cart[index].cartId.toString();
                                                                    var newQuantityToBeBought = cart[index].quantityToBeBought.toString();
                                                                    try {
                                                                      if (mounted) {
                                                                        setState(() {
                                                                          cart[index].cartUpdating = true;
                                                                        });
                                                                      }
                                                                      var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                                                      if (mounted) {
                                                                        setState(() {
                                                                          cart[index].cartUpdating = false;
                                                                        });
                                                                      }
                                                                      if(rsp.success==false){
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content: Text(rsp.userFriendlyMessage),
                                                                            backgroundColor: Colors.red));
                                                                      }
                                                                      else{
                                                                        fetchCartData();
                                                                        print(rsp.userFriendlyMessage);
                                                                        for(int i=0;i<productsList.data.length;i++){
                                                                          if(productsList.data[i].cartId == cart[index].cartId){
                                                                            productsList.increment(i);
                                                                          }
                                                                        }
                                                                      }
                                                                    }on Exception catch (e){
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                                    }
                                                                  }
                                                                  else{
                                                                    Toast.show('You have reached the limit', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                                                  }

                                                                },
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ApplyCoupons(totalAmount: totalAmount)),);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 2, 5,3),
                          height: 25,
                          width:25,
                          child: Image.asset('assets/images/coupon.png')
                      ),
                      coupon == "" ? Expanded(
                          flex: 2,
                          child:Container(
                            margin: EdgeInsets.fromLTRB(5, 6, 0, 6),
                            child: Text('Apply Coupons',style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 15,color: Colors.cyan,fontWeight: FontWeight.w500),),),
                          )
                      ):Expanded(
                          flex: 2,
                          child:Container(
                            margin: EdgeInsets.fromLTRB(5, 6, 0, 6),
                            child: Text('Coupon Applied($coupon)',style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 15,color: Colors.cyan,fontWeight: FontWeight.w500),),),
                          )
                      ),
                      coupon == ""? Expanded(
                          flex: 2,
                          child:Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 4, 6),
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.navigate_next,size: 20, ),
                          )
                      ):Container(
                        margin: EdgeInsets.fromLTRB(0, 6, 4, 6),
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.cancel_outlined,size: 20, ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 0.2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      key: dataKey,
                      margin: EdgeInsets.all(8),
                      alignment:Alignment.centerLeft,
                      child: Text("Price details " + "($quantity items)",style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),textAlign: TextAlign.left,),
                    ),
                    SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                    SizedBox(height: 5,),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Total MRP:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Discount:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 8),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Delivery Charges:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ),
                                specialDiscount != '-1'?
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Coupon discount:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ):Container(),
                                SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                                SizedBox(height: 6,),
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Total Amount:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),)
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                                    alignment:Alignment.centerRight,
                                    child: Text("₹" + price.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                                    alignment:Alignment.centerRight,
                                    child: Text("- ₹" + afterDiscount.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,color: Colors.cyan),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 8),
                                    alignment:Alignment.centerRight,
                                    child: Text('+'+deliverycharges ?? null,style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,color: Colors.cyan),),)
                                ),
                                specialDiscount != '-1'?
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                                    alignment:Alignment.centerRight,
                                    child: Text('-₹'+specialDiscount.toString(),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,color: Colors.green),),)
                                ):Container(),
                                SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                                SizedBox(height: 6,),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                                    alignment:Alignment.centerRight,
                                    child: Text("₹" + totalAmount.toStringAsFixed(2) ?? null,style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),)
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
      bottomSheet: cart.isEmpty== true ? Container(
        color: Colors.white,
        height:10,):Container(
          color: Colors.white,
          height: 60,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Row(
            children: <Widget>[
              Expanded(child:  InkWell(
                onTap: (){
                  Scrollable.ensureVisible(dataKey.currentContext);
                },
                child: Container(
                  //height: 40,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      children: <Widget>[
                        Text("₹" + totalAmount.toStringAsFixed(2) ?? null,style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),),
                        Text("View price details",style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 12,color: Colors.blue,fontWeight: FontWeight.w600),),),
                      ],
                    )
                ),
              )),
              Expanded(child: Container(
                height: 40,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 200,
                child: RaisedButton(
                  color: Colors.cyan[600],
                  textColor: Colors.white,
                  child: Text("Proceed to Checkout",style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 15,),),),
                  onPressed: cartIds.length == 0 ? null : (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectAddress(mrp:price,cartIds: cartIds,
                        quantity:quantity,discount:afterDiscount,deliveryCharges:deliverycharges,totalAmount:totalAmount,coupon: widget.coupon,specialDiscount: specialDiscount,previousPage:'cart')),
                    );
                  },
                ),
              ),),
            ],
          )
      ),
    );
  }
}


