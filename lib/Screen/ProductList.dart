import 'package:NeedZIndia/Api.dart';
import 'package:NeedZIndia/ProductListNotifier.dart';
import 'package:NeedZIndia/Screen/Login.dart';
import 'package:NeedZIndia/Screen/ProductDescription.dart';
import 'package:NeedZIndia/Screen/SearchBar.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';import 'package:toast/toast.dart';


class ProductList extends StatefulWidget {
  final String categoryname;
  final String brandName;
  final String search;
  ProductList({Key key, this.categoryname,this.brandName,this.search}) : super(key: key );

  @override
  _ProductList createState() => _ProductList();
}

class _ProductList extends State<ProductList> {
  int cartValue = 0;
  bool loading = false;
  bool load = true;
  final scrollController = ScrollController();
  int offset = 0;
  int selectedCard = -1;
  int counter = 1;
  var upperLimit;
  bool productRequest = false;
  bool serviceRequest = false;
  bool otherRequest = false;
  int requestId = 0;
  String hintText = "Select request type";
  final requestController = TextEditingController();
  bool isEnabled = false;
  final _formKey = GlobalKey<FormState>();
  bool requestSubmitted = false;
  bool openRequestSheet = false;

  @override
  void initState() {
    super.initState();
    loadingProducts();
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        offset++;
        if(!loading){
          if(mounted){
            setState(() {
              loading = true;
            });
          }
        }
        loadingOffset(offset);
      }
    });
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  loadingProducts() async {
    try{
      final products = Provider.of<ProductListNotifier>(context, listen: false);
      var response = await products.fetchProductsData(widget.brandName, widget.categoryname, widget.search, offset);
      print(response.success);
      if(response.success == true){
        if(mounted){
          setState(() {
            load = false;
          });
        }
      }
     else{
        Toast.show(response.userFriendlyMessage, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        if(mounted){
          setState(() {
            load = false;
          });
        }
      }
    }on Exception catch (e){
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  loadingOffset(offset) async {
    try{
      final products = Provider.of<ProductListNotifier>(context, listen: false);
          var response = await products.fetchProductsOffset(widget.brandName, widget.categoryname, widget.search, offset);
          if(response.success == true){
            if(mounted){
              setState(() {
                loading = false;
              });
            }
          }
          else{
            Toast.show(response.userFriendlyMessage, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
            if(mounted){
              setState(() {
                loading = false;
              });
            }
          }
    }on Exception catch (e){
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }



  @override
  Widget build(BuildContext context) {
    final CartValue cartValue  = Provider.of<CartValue>(context);
    final ProductListNotifier productsList  = Provider.of<ProductListNotifier>(context);
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          titleSpacing: 0,
          title: FittedBox(fit: BoxFit.fitWidth,
            child: widget.categoryname==null && widget.brandName == null ?new Text(widget.search, style: GoogleFonts.quicksand()):widget.categoryname ==null && widget.search == null? new Text(widget.brandName, style: GoogleFonts.quicksand()):
            widget.brandName ==null && widget.search == null? new Text(widget.categoryname, style: GoogleFonts.quicksand()):
            new Text('', style: GoogleFonts.quicksand()),
          ),
          backgroundColor: Colors.cyan[600],
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchBar(searchQuery:productsList.searchData)),
                );
              },
            ),
            new Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: new IconButton(icon: Icon(Icons.shopping_cart), onPressed: ()  async {
                    var _prefs = await SharedPreferences.getInstance();
                    var token = _prefs.getString('token');
                    if(token == null){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                      );
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()),
                      );
                    }
                  }),
                ),
                cartValue.cartValue!= 0 ? new Positioned(
                  right: 11,
                  top: 11,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      cartValue.cartValue.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ) : new Container()
              ],
            ),
          ],
        ),
        body: load ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),): productsList.data.isEmpty == true?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/noresultsfound.jpg'),
              Text('Sorry!! No Results found',style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 18),color: Colors.blueGrey),textAlign: TextAlign.center,),
            ],
          ),
        ): SafeArea(
          child: SingleChildScrollView(
            controller: scrollController,
            physics: new BouncingScrollPhysics(),
            child: Column(
              children : <Widget>[
                ListView.builder(
                    physics: new BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:  productsList.data.isEmpty == true ? 0 : productsList.data.length+1,
                    itemBuilder: (BuildContext context, int index) {
                      if(index == productsList.data.length){
                        return _buildProgressIndicator();
                      }
                      else{
                        return SafeArea(
                          child:Column(
                            children: <Widget>[
                              SizedBox(height: 5,),
                              productsList.data[index].stocks==0?
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        //color: Colors.blueGrey[500],
                                        width: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[300],
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
                                          foregroundDecoration: BoxDecoration(
                                            color: Colors.grey,
                                            backgroundBlendMode: BlendMode.saturation,
                                          ),
                                          margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
                                          height: 130,
                                          width: 150,
                                          child: Image.network(productsList.data[index].imageUrl),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(productsList.data[index].productName,style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,),fontWeight: FontWeight.bold),),
                                              SizedBox(height:5,),
                                              Text(productsList.data[index].brand,style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,),),),
                                              SizedBox(height: 5,),
                                              Text(productsList.data[index].variantName,style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,)),),
                                              Text("Out of Stock",style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,color: Colors.red)),),
                                              SizedBox(height: 5,),

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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDescription(product :productsList.data[index], variant: productsList.data[index].variants,cartvalue: cartValue.cartValue,categoryName:widget.categoryname,brand: widget.brandName,search :widget.search ,index: index)),
                                  );
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
                                          margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
                                          height: 130,
                                          width: 150,
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/images/loading.gif',
                                            image: productsList.data[index].imageUrl,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin:EdgeInsets.fromLTRB(0, 15, 0, 8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(child: Row(
                                                      children: <Widget>[
                                                        Text("₹" + productsList.data[index].discountedPrice.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                                            textStyle: TextStyle(fontSize: 18),fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                                        SizedBox(width: 8,),
                                                        productsList.data[index].discountPercentage==0?Container():
                                                        Text("₹" + productsList.data[index].price.toStringAsFixed(0),style: GoogleFonts.quicksand(
                                                            textStyle: TextStyle(fontSize: 15,decoration: TextDecoration.lineThrough)),textAlign: TextAlign.left),
                                                        SizedBox(width:8,),
                                                        productsList.data[index].discountPercentage==0?Container():
                                                        Container(
                                                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                          height: 20,
                                                          width:60,
                                                          alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Colors.grey,
                                                              width: 0.5,
                                                            ),
                                                            borderRadius: BorderRadius.circular(2),
                                                            color: Colors.cyan[500],
                                                          ),
                                                          child: Text(productsList.data[index].discountPercentage.round().toString() +
                                                              "% OFF",
                                                            style: GoogleFonts.quicksand(
                                                                textStyle: TextStyle(fontSize: 12),color:Colors.white ),
                                                            textAlign: TextAlign.center,),
                                                        ),
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              Text(productsList.data[index].productName,style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,),fontWeight: FontWeight.bold),),
                                              SizedBox(height:5,),
                                              Text(productsList.data[index].brand,style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 15,),),),
                                              SizedBox(height: 5,),
                                              Text(productsList.data[index].variantName,style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 15,)),),
                                              GestureDetector(
                                                child: Container(
                                                    alignment: Alignment.bottomRight,
                                                    child:  productsList.data[index].addedToCart || productsList.data[index].add == true ? Container(
                                                      color: Colors.white,
                                                      height: 40,
                                                      width: 100,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: IconButton(
                                                              icon: Icon(Icons.remove,color: Colors.cyan[600],),
                                                              onPressed: () async {
                                                                setState(() {
                                                                  selectedCard = productsList.data[index].stockId;
                                                                });
                                                                if(productsList.data[index].addedToCart==true) {
                                                                  if(productsList.data[index].quantityToBeBought>1){
                                                                    productsList.data[index].quantityToBeBought--;
                                                                    var _prefs =await SharedPreferences.getInstance();
                                                                    var mobile = _prefs.getString('mobile');
                                                                    var cartId;
                                                                    cartId=productsList.data[index].cartId.toString();
                                                                    var newQuantityToBeBought;
                                                                    productsList.data[index].addedToCart? newQuantityToBeBought = productsList.data[index].quantityToBeBought.toString():newQuantityToBeBought= productsList.data[index].counter.toString();
                                                                    print("CardId*****"+cartId);
                                                                    print(newQuantityToBeBought);
                                                                    try {
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = true;
                                                                        });
                                                                      }
                                                                      var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = false;
                                                                        });
                                                                      }
                                                                      if(rsp.success==false){
                                                                        print(rsp.userFriendlyMessage);
                                                                      }
                                                                      else{
                                                                        print(rsp.userFriendlyMessage);
                                                                      }
                                                                    }on Exception catch (e){
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                              }
                                                                  }
                                                                  else{
                                                                    var _prefs =await SharedPreferences.getInstance();
                                                                    var mobile = _prefs.getString('mobile');
                                                                    var cartId;
                                                                    cartId= productsList.data[index].cartId.toString();
                                                                    var newQuantityToBeBought;
                                                                    productsList.data[index].addedToCart? newQuantityToBeBought = productsList.data[index].quantityToBeBought.toString():newQuantityToBeBought= productsList.data[index].counter.toString();
                                                                    print("CardId*****"+cartId);
                                                                    var remove = true.toString();
                                                                    print(newQuantityToBeBought);
                                                                    print(remove);
                                                                    print(cartId);
                                                                    try {
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = true;
                                                                        });
                                                                      }
                                                                      var rsp= await removeCart(mobile,cartId,remove,newQuantityToBeBought);
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = false;
                                                                        });
                                                                      }
                                                                      if(rsp.success==false){
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content: Text(rsp.userFriendlyMessage),
                                                                            backgroundColor: Colors.red));
                                                                      }
                                                                      else{
                                                                        if(mounted){
                                                                          setState(() {
                                                                            productsList.data[index].addedToCart = false;
                                                                          });
                                                                        }
                                                                        cartValue.decrement();
                                                                      }
                                                                    }on Exception catch (e){
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                              }
                                                                  }
                                                                }
                                                                else{
                                                                  if(productsList.data[index].counter>1){
                                                                    productsList.data[index].counter--;
                                                                    var _prefs =await SharedPreferences.getInstance();
                                                                    var mobile = _prefs.getString('mobile');
                                                                    var cartId;
                                                                    cartId=productsList.data[index].cartId.toString();
                                                                    var newQuantityToBeBought;
                                                                    productsList.data[index].addedToCart? newQuantityToBeBought = productsList.data[index].quantityToBeBought.toString():newQuantityToBeBought= productsList.data[index].counter.toString();
                                                                    print("CardId*****"+cartId);
                                                                    print(newQuantityToBeBought);
                                                                    try {
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = true;
                                                                        });
                                                                      }
                                                                      var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = false;
                                                                        });
                                                                      }
                                                                      if(rsp.success==false){
                                                                        print(rsp.userFriendlyMessage);
                                                                      }
                                                                      else{
                                                                        print(rsp.userFriendlyMessage);
                                                                      }
                                                                    }on Exception catch (e){
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                              }
                                                                  }
                                                                  else{
                                                                    var _prefs =await SharedPreferences.getInstance();
                                                                    var mobile = _prefs.getString('mobile');
                                                                    var cartId;
                                                                    cartId=productsList.data[index].cartId.toString();
                                                                    var newQuantityToBeBought;
                                                                    productsList.data[index].addedToCart? newQuantityToBeBought = productsList.data[index].quantityToBeBought.toString():newQuantityToBeBought= productsList.data[index].counter.toString();
                                                                    print("CardId*****"+cartId);
                                                                    var remove = true.toString();
                                                                    print(newQuantityToBeBought);
                                                                    try {
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = true;
                                                                        });
                                                                      }
                                                                      var rsp= await removeCart(mobile,cartId,remove,newQuantityToBeBought);
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = false;
                                                                        });
                                                                      }
                                                                      if(rsp.success==false){
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content: Text(rsp.userFriendlyMessage),
                                                                            backgroundColor: Colors.red));
                                                                      }
                                                                      else{
                                                                        if(mounted){
                                                                          setState(() {
                                                                            productsList.data[index].add = false;
                                                                          });
                                                                        }
                                                                        cartValue.decrement();
                                                                      }
                                                                    }on Exception catch (e){
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                              }
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              color: Colors.white,
                                                              margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                                              child: productsList.data[index].cartUpdating?Container(
                                                                margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                                                height:15,
                                                                width:2,
                                                                child: CircularProgressIndicator( strokeWidth: 2.0,valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),
                                                              ):productsList.data[index].addedToCart ? Container(
                                                                  alignment:Alignment.center,
                                                                  width:100,child:Text(productsList.data[index].quantityToBeBought.toString(),style: TextStyle(fontSize: 16,color: Colors.black),)
                                                              ): Container(
                                                                alignment:Alignment.center,
                                                                width: 100,
                                                                child:Text(productsList.data[index].counter.toString(),style: TextStyle(fontSize: 16,color: Colors.black),),),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: IconButton(
                                                              icon: productsList.data[index]
                                                                  .quantityToBeBought == productsList.data[index].stocks || productsList.data[index].counter == productsList.data[index].stocks ?Icon(Icons.add,color: Colors.grey,): Icon(Icons.add,color: Colors.cyan[600],),
                                                              onPressed: () async {
                                                                productsList.data[index].stocks<=10? productsList.upperLimitChange(index, productsList.data[index].stocks): productsList.upperLimitChange(index, 10);
                                                                if(productsList.data[index].addedToCart==true) {
                                                                  if (productsList.data[index]
                                                                      .quantityToBeBought <
                                                                      productsList.data[index].stocks) {
                                                                    productsList.data[index]
                                                                        .quantityToBeBought++;
                                                                    var _prefs =await SharedPreferences.getInstance();
                                                                    var mobile = _prefs.getString('mobile');
                                                                    var cartId;
                                                                    cartId=productsList.data[index].cartId.toString();
                                                                    var newQuantityToBeBought;
                                                                    productsList.data[index].addedToCart? newQuantityToBeBought = productsList.data[index].quantityToBeBought.toString():newQuantityToBeBought= productsList.data[index].counter.toString();
                                                                    print(cartId);
                                                                    print(newQuantityToBeBought);
                                                                    try {
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = true;
                                                                        });
                                                                      }
                                                                      var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = false;
                                                                        });
                                                                      }
                                                                      if(rsp.success==false){
                                                                        print(rsp.userFriendlyMessage);
                                                                      }
                                                                      else{
                                                                        print(rsp.userFriendlyMessage);
                                                                      }
                                                                    }on Exception catch (e){
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                              }
                                                                  }
                                                                  else {
                                                                    Toast
                                                                        .show(
                                                                        'You have reached the limit',
                                                                        context,
                                                                        duration: Toast
                                                                            .LENGTH_LONG,
                                                                        gravity: Toast
                                                                            .BOTTOM);
                                                                  }
                                                                }
                                                                else{
                                                                  if(productsList.data[index].counter<productsList.data[index].stocks){
                                                                    productsList.data[index].counter++;
                                                                    var _prefs =await SharedPreferences.getInstance();
                                                                    var mobile = _prefs.getString('mobile');
                                                                    var cartId;
                                                                    cartId=productsList.data[index].cartId.toString();
                                                                    var newQuantityToBeBought;
                                                                    productsList.data[index].addedToCart? newQuantityToBeBought = productsList.data[index].quantityToBeBought.toString():newQuantityToBeBought= productsList.data[index].counter.toString();
                                                                    print(cartId);
                                                                    print(newQuantityToBeBought);
                                                                    try {
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = true;
                                                                        });
                                                                      }
                                                                      var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                                                      if(mounted){
                                                                        setState(() {
                                                                          productsList.data[index].cartUpdating = false;
                                                                        });
                                                                      }
                                                                      if(rsp.success==false){
                                                                        print(rsp.userFriendlyMessage);
                                                                      }
                                                                      else{
                                                                        print(rsp.userFriendlyMessage);                                                                    }
                                                                    }on Exception catch (e){
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                              }
                                                                  }
                                                                  else {
                                                                    Toast
                                                                        .show(
                                                                        'You have reached the limit',
                                                                        context,
                                                                        duration: Toast
                                                                            .LENGTH_LONG,
                                                                        gravity: Toast
                                                                            .BOTTOM);
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ):GestureDetector(
                                                      onTap: ()async {
                                                        var _prefs =await SharedPreferences.getInstance();
                                                        var mobile = _prefs.getString('mobile');
                                                        var token = _prefs.getString('token');
                                                        if(token==null){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                                                          );
                                                        }
                                                        else{
                                                          var stockId = productsList.data[index].stockId.toString();
                                                          print(stockId);
                                                          var quantityToBeBought = '1';
                                                          try {
                                                            if(mounted){
                                                              setState(() {
                                                                productsList.data[index].addingToCart = true;
                                                              });
                                                            }
                                                            var rsp= await addCart(mobile,stockId,quantityToBeBought);
                                                            if(mounted){
                                                              setState(() {
                                                                productsList.data[index].addingToCart = false;
                                                              });
                                                            }
                                                            if(rsp.success==false){
                                                              print(rsp.userFriendlyMessage);
                                                            }
                                                            else{
                                                              print(rsp.data.cartItems);
                                                              if(mounted){
                                                                setState(() {
                                                                  for(int i = 0;i<rsp.data.cartItems.length;i++){
                                                                    if(rsp.data.cartItems[i].productId == productsList.data[index].productId){
                                                                      productsList.data[index].cartId = rsp.data.cartItems[i].cartId;
                                                                      print(rsp.data.cartItems[i].cartId);
                                                                      print("click");
                                                                    }
                                                                    else{
                                                                      print("Not clicked");
                                                                    }
                                                                  }
                                                                  productsList.data[index].add = true;
                                                                  productsList.data[index].counter =1;
                                                                });
                                                              }
                                                              cartValue.increment();
                                                              print(rsp.userFriendlyMessage);
                                                            }
                                                          }on Exception catch (e){
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));                                                    }
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 32,
                                                        width:85,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.cyan[600],
                                                            width: 0.1,
                                                          ),
                                                          borderRadius: BorderRadius.circular(3),
                                                          color: Colors.cyan[600],
                                                        ),
                                                        child:Padding(
                                                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                          child: productsList.data[index].addingToCart ? Container(height:0.1,width:0.1,margin:EdgeInsets.fromLTRB(26,7,26,7),child: CircularProgressIndicator(strokeWidth: 2.0,valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),) : Container(margin:EdgeInsets.fromLTRB(0, 2, 0, 0),child: FittedBox(child: Text('Add to Cart',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)),),
                                                        ),
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
                            ],
                          ),
                        );
                      }
                    }
                ),
                Container(
                  color: Colors.blueGrey[50],
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        alignment: Alignment.topLeft,
                        child: Text("didn't find \nwhat you were looking for?", style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 25),color:Colors.grey[500] ,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(20, 10, 10, 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text("Request now",style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 16,color: Colors.cyan[600]),),),
                          onPressed: () async {
                            var _prefs =await SharedPreferences.getInstance();
                            var token = _prefs.getString('token');
                            if(token == null){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                              );
                            }else{
                              setState((){
                                openRequestSheet = true;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      bottomSheet: openRequestSheet ? Container(
        child: requestSubmitted ?Form(
          key: _formKey,
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height : 150,
                    width : 150,
                    margin: EdgeInsets.all(5),
                    child: Image.asset("assets/images/requestSuccess.png"),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text("Request Submitted Successfully!",style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 18),),),
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    child: Text("We will notify you shortly.",style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 16),),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          requestSubmitted = false;
                          requestController.text = "";
                          productRequest = false;
                          serviceRequest=false;
                          otherRequest = false;
                          requestId = 0;
                          openRequestSheet = false;
                        });
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ):Form(
          key: _formKey,
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text("Select Request type",style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 18),),),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child:GestureDetector(
                            onTap: (){
                              setState(() {
                                productRequest = true;
                                serviceRequest=false;
                                otherRequest = false;
                                requestId = 1;
                                hintText = "Type product details.......";
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blueGrey,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: productRequest ? Colors.cyan[100] : Colors.blueGrey[100],
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(10),
                                child: Text("Product",style: GoogleFonts.quicksand(),),
                              ),
                            ),
                          )
                      ) ,
                      Expanded(
                          child:GestureDetector(
                            onTap: (){
                              setState(() {
                                productRequest = false;
                                serviceRequest=true;
                                otherRequest = false;
                                requestId = 2;
                                hintText = "Type service details........";
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blueGrey,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: serviceRequest ? Colors.cyan[100] : Colors.blueGrey[100],
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(10),
                                child: Text("Service",style: GoogleFonts.quicksand(),),
                              ),
                            ),
                          )
                      ),
                      Expanded(
                        child:GestureDetector(
                          onTap: (){
                            setState(() {
                              productRequest = false;
                              serviceRequest=false;
                              otherRequest = true;
                              requestId = 3;
                              hintText = "Type details.......";
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: otherRequest ? Colors.cyan[100] : Colors.blueGrey[100],
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              child: Text("Other",style: GoogleFonts.quicksand(),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.grey,// set border color
                          width: 0.8),   // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      enabled: productRequest || serviceRequest || otherRequest,
                      maxLines: 3,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hintText),
                      controller: requestController,
                      onChanged: (value){
                        setState(() {
                          if(value.length>0)
                            isEnabled=true;
                          else
                            isEnabled=false;
                        });
                      },
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            ElevatedButton(
                              onPressed: !isEnabled ? null : () async {
                                if(_formKey.currentState.validate()){
                                  var description = requestController.text;
                                  try{
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Center(child: CircularProgressIndicator(color: Colors.cyan[600]),);
                                        });
                                    var rsp1= await userRequest(requestId.toString(),description);
                                    Navigator.pop(context);
                                    if(rsp1.success==false){
                                      Toast.show(rsp1.userFriendlyMessage, context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
                                    }
                                    else{
                                      setState(() {
                                        requestSubmitted = true;
                                      });
                                    }
                                  }
                                  on Exception catch (e){
                                    Toast.show("Something went wrong", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width:10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  requestController.text = "";
                                  productRequest = false;
                                  serviceRequest=false;
                                  otherRequest = false;
                                  requestId = 0;
                                  openRequestSheet = false;
                                });
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ]
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ):null,
    );
  }
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: loading ? 1.0 : 00,
          child: new CircularProgressIndicator(color: Colors.cyan[600],),
        ),
      ),
    );
  }
}