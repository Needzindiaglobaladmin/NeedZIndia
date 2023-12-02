import 'package:NeedZIndia/Api.dart';
import 'package:NeedZIndia/Class/ProductData.dart';
import 'package:NeedZIndia/Class/ProductVariant.dart';
import 'package:NeedZIndia/ProductListNotifier.dart';
import 'package:NeedZIndia/Screen/Login.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class ProductDescription extends StatefulWidget {
  final List<ProductVariant> variant;
  final ProductData product;
  final int cartvalue;
  final String categoryName;
  final String brand;
  final String search;
  final int index;
  ProductDescription({Key key, this.variant,this.product,this.cartvalue,this.categoryName,this.brand,this.search,this.index}) : super(key: key );

  @override
  _ProductDescription createState() => _ProductDescription();
}

class _ProductDescription extends State<ProductDescription> {
  var price;
  var discountedPrice;
  var discountPercentage;
  var imageUrl;
  var variantName;
  var stockid;
  int cartValue = 0;
  int selectedCard = -1;
  bool _loading = true;
  int counter = 0;
  bool addedToCart = false;
  int stocks = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      if(mounted){
        setState(() {
          _loading = false;
          price = widget.product.price;
          discountedPrice =widget.product.discountedPrice;
          discountPercentage = widget.product.discountPercentage;
          imageUrl = widget.product.imageUrl;
          variantName = widget.product.variantName;
          stockid = widget.product.stockId;
          cartValue = widget.cartvalue;
          stocks = widget.product.stocks;
        });
      }
    });
    print(widget.product.discountPercentage);
  }

  @override
  Widget build(BuildContext context) {
    final CartValue cartValue  = Provider.of<CartValue>(context);
    final ProductListNotifier productsList  = Provider.of<ProductListNotifier>(context);
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.cyan[600],
          actions: [
            new Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: new IconButton(icon: Icon(Icons.shopping_cart), onPressed: () async {
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
                cartValue.cartValue != 0 ? new Positioned(
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
                          fontSize: 10,fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ) : new Container()
              ],
            ),
          ],
        ),
        body: _loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) :  new ListView.builder(
            shrinkWrap: true,
            itemCount: widget.variant == null ? 0 :1,
            itemBuilder: (BuildContext context, int index) {
              return SafeArea(
                child:Form(
                  child: SingleChildScrollView(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 40,),
                        Container(
                          height: SizeConfig.blockSizeVertical * 30,
                          width: MediaQuery.of(context).size.width,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.gif',
                            image: imageUrl,
                          ),
                        ),
                        SizedBox(height: 40,),
                        SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Text(widget.product.productName,style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 18,),fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 0, 10),
                                child: Text("Quantity:",style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 15,)),),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 0, 10),
                                child: Text(variantName,style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),),
                              ),
                            ],
                          ),
                        ),
                        widget.product.discountPercentage!=0?Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Text("Product MRP:",style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 15,)),),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Text("₹"+ price.toStringAsFixed(2) ,style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 15,decoration: TextDecoration.lineThrough)),),
                              ),
                            ],
                          ),
                        ):Container(),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 6, 0, 0),
                                child: Text("Selling Price:",style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 17,)),),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 6, 0, 0),
                                child: Text("₹"+ discountedPrice.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 17),fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                              ),
                              widget.product.discountPercentage!=0 ?Container(
                                margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                height: 20,
                                width: 70,
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
                                  discountPercentage.round().toString() + "% OFF",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 15),color:Colors.white ),
                                  textAlign: TextAlign.center,),
                              ):Container()
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 6, 0, 0),
                          child: Text("(Inclusive of all taxes)",style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 12,)),),
                        ),
                        stocks == 0?Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                          alignment: Alignment.bottomRight,
                          child: Text("Out of Stock",style: TextStyle(color: Colors.red),),
                        ):
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          alignment: Alignment.bottomRight,
                          child: widget.product.add || widget.product.addedToCart ?
                          Container(
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
                                        selectedCard =widget.product.stockId;
                                      });
                                      if(widget.product.addedToCart==true) {
                                        if(widget.product.quantityToBeBought>1){
                                          widget.product.quantityToBeBought--;
                                          var _prefs =await SharedPreferences.getInstance();
                                          var mobile = _prefs.getString('mobile');
                                          var cartId;
                                          cartId=widget.product.cartId.toString();
                                          var newQuantityToBeBought;
                                          widget.product.addedToCart? newQuantityToBeBought = widget.product.quantityToBeBought.toString():newQuantityToBeBought= widget.product.counter.toString();
                                          try {
                                            if(mounted){
                                              setState(() {
                                                widget.product.cartUpdating = true;
                                              });
                                            }
                                            var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                            if(mounted){
                                              setState(() {
                                                widget.product.cartUpdating = false;
                                              });
                                            }
                                            if(rsp.success==false){
                                              print(rsp.userFriendlyMessage);
                                            }
                                            else{
                                              productsList.changeCaught(widget.index, productsList.data[widget.index].quantityToBeBought);
                                              print(rsp.userFriendlyMessage);
                                            }
                                          }on Exception catch (e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                                          }
                                        }
                                        else{
                                          var _prefs =await SharedPreferences.getInstance();
                                          var mobile = _prefs.getString('mobile');
                                          var cartId;
                                          cartId= widget.product.cartId.toString();
                                          var newQuantityToBeBought;
                                          widget.product.addedToCart? newQuantityToBeBought = widget.product.quantityToBeBought.toString():newQuantityToBeBought= widget.product.counter.toString();
                                          var remove = true.toString();
                                          try {
                                            if(mounted){
                                              setState(() {
                                                widget.product.cartUpdating = true;
                                              });
                                            }
                                            var rsp= await removeCart(mobile,cartId,remove,newQuantityToBeBought);
                                            if(mounted){
                                              setState(() {
                                                widget.product.cartUpdating = false;
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
                                                  widget.product.addedToCart = false;
                                                });
                                              }
                                              cartValue.decrement();
                                            }
                                          }on Exception catch (e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                                          }
                                        }
                                      }
                                      else{
                                        if(widget.product.counter>1){
                                          widget.product.counter--;
                                          var _prefs =await SharedPreferences.getInstance();
                                          var mobile = _prefs.getString('mobile');
                                          var cartId;
                                          cartId=widget.product.cartId.toString();
                                          var newQuantityToBeBought;
                                          widget.product.addedToCart? newQuantityToBeBought = widget.product.quantityToBeBought.toString():newQuantityToBeBought= widget.product.counter.toString();
                                          try {
                                            if(mounted){
                                              setState(() {
                                                widget.product.cartUpdating = true;
                                              });
                                            }
                                            var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                            if(mounted){
                                              setState(() {
                                                widget.product.cartUpdating = false;
                                              });
                                            }
                                            if(rsp.success==false){
                                              print(rsp.userFriendlyMessage);
                                            }
                                            else{
                                              productsList.changeCaught(widget.index, productsList.data[widget.index].counter);
                                              print(rsp.userFriendlyMessage);
                                            }
                                          }on Exception catch (e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                                          }
                                        }
                                        else{
                                          var _prefs =await SharedPreferences.getInstance();
                                          var mobile = _prefs.getString('mobile');
                                          var cartId;
                                          cartId=widget.product.cartId.toString();
                                          var newQuantityToBeBought;
                                          widget.product.addedToCart? newQuantityToBeBought = widget.product.quantityToBeBought.toString():newQuantityToBeBought= widget.product.counter.toString();
                                          print("CardId*****"+cartId);
                                          var remove = true.toString();
                                          print("qty "+newQuantityToBeBought);
                                          try {
                                            if(mounted){
                                              setState(() {
                                                widget.product.cartUpdating = true;
                                              });
                                            }
                                            var rsp= await removeCart(mobile,cartId,remove,newQuantityToBeBought);
                                            if(mounted){
                                              setState(() {
                                                widget.product.cartUpdating = false;
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
                                                  widget.product.add = false;
                                                });
                                              }
                                              cartValue.decrement();
                                            }
                                          }on Exception catch (e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.fromLTRB(8, 0, 5, 0),
                                    child: widget.product.cartUpdating?SizedBox(height:15,width:20,child: CircularProgressIndicator( strokeWidth: 2.0,valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),):widget.product.addedToCart ? Container(alignment:Alignment.center,width:100,child:Text(widget.product.quantityToBeBought.toString(),style: TextStyle(fontSize: 16,color: Colors.black),)): Container(alignment:Alignment.center,width:100,child:Text(widget.product.counter.toString(),style: TextStyle(fontSize: 16,color: Colors.black),),),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: IconButton(
                                      icon: widget.product.quantityToBeBought == widget.product.stocks || widget.product.counter == widget.product.stocks?Icon(Icons.add,color: Colors.grey,): Icon(Icons.add,color: Colors.cyan[600],),
                                      onPressed: () async {
                                        widget.product.stocks<=10? productsList.upperLimitChange(widget.index, widget.product.stocks): productsList.upperLimitChange(widget.index, 10);
                                        if(widget.product.addedToCart==true) {
                                          if (widget.product.quantityToBeBought <
                                              widget.product.stocks) {
                                            widget.product.quantityToBeBought++;
                                            var _prefs =await SharedPreferences.getInstance();
                                            var mobile = _prefs.getString('mobile');
                                            var cartId;
                                            cartId=widget.product.cartId.toString();
                                            var newQuantityToBeBought;
                                            widget.product.addedToCart? newQuantityToBeBought = widget.product.quantityToBeBought.toString():newQuantityToBeBought= widget.product.counter.toString();
                                            print(cartId);
                                            print("qty "+newQuantityToBeBought);
                                            try {
                                              if(mounted){
                                                setState(() {
                                                  widget.product.cartUpdating = true;
                                                });
                                              }
                                              var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                              if(mounted){
                                                setState(() {
                                                  widget.product.cartUpdating = false;
                                                });
                                              }
                                              if(rsp.success==false){
                                                print(rsp.userFriendlyMessage);
                                              }
                                              else{
                                                productsList.changeCaught(widget.index, productsList.data[widget.index].quantityToBeBought);
                                                print(rsp.userFriendlyMessage);
                                              }
                                            }on Exception catch (e){
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                                            }
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
                                          if(widget.product.counter< widget.product.stocks){
                                            widget.product.counter++;
                                            var _prefs =await SharedPreferences.getInstance();
                                            var mobile = _prefs.getString('mobile');
                                            var cartId;
                                            cartId=widget.product.cartId.toString();
                                            var newQuantityToBeBought;
                                            widget.product.addedToCart? newQuantityToBeBought = widget.product.quantityToBeBought.toString():newQuantityToBeBought= widget.product.counter.toString();
                                            print(cartId);
                                            print("qty "+newQuantityToBeBought);
                                            try {
                                              if(mounted){
                                                setState(() {
                                                  widget.product.cartUpdating = true;
                                                });
                                              }
                                              var rsp= await updateCart(mobile,cartId,newQuantityToBeBought);
                                              if(mounted){
                                                setState(() {
                                                  widget.product.cartUpdating = false;
                                                });
                                              }
                                              if(rsp.success==false){
                                                print(rsp.userFriendlyMessage);
                                              }
                                              else{
                                                productsList.changeCaught(widget.index, productsList.data[widget.index].counter);
                                                print(rsp.userFriendlyMessage);                                                                    }
                                            }on Exception catch (e){
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                                            }
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
                                  ),
                                ),
                                Container(width: 5,),
                              ],
                            ),
                          ): Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                            alignment: Alignment.bottomRight,
                            height: 40,
                            width: 110,
                            child: FlatButton(
                              color: Colors.cyan[600],
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
                                child: widget.product.addingToCart ? Container(height:15,width:15,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),) : Container(margin:EdgeInsets.fromLTRB(0, 2, 0, 0),child: FittedBox(child: Text('Add to Cart',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),)),
                              ),
                              onPressed: () async {
                                print(stockid);
                                var _prefs =await SharedPreferences.getInstance();
                                var mobile = _prefs.getString('mobile');
                                var token = _prefs.getString('token');
                                if(token==null){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                                  );
                                }
                                else{
                                  var stockId = stockid.toString();
                                  var quantityToBeBought = '1';
                                  try {
                                    if(mounted){
                                      setState(() {
                                        widget.product.addingToCart = true;
                                      });
                                    }
                                    var rsp= await addCart(mobile,stockId,quantityToBeBought);
                                    if(mounted){
                                      setState(() {
                                        widget.product.addingToCart = false;
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
                                          widget.product.add = true;
                                          addedToCart = true;
                                          for(int i = 0;i<rsp.data.cartItems.length;i++){
                                            if(rsp.data.cartItems[i].productId == widget.product.productId){
                                              widget.product.cartId = rsp.data.cartItems[i].cartId;
                                              print(rsp.data.cartItems[i].cartId);
                                              print("click");
                                            }
                                            else{
                                              print("Not clicked");
                                            }
                                          }
                                        });
                                      }
                                      cartValue.increment();
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(rsp.userFriendlyMessage),
                                          backgroundColor: Colors.green));
                                    }
                                  }on Exception catch (e){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 8, 0, 0),
                          child: Text("Quantity",style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 15,)),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 8, 0, 20),
                          height: 50,
                          child: GridView.builder(
                              physics: new BouncingScrollPhysics(),
                              itemCount:  widget.variant.isEmpty == true ? 0 :widget.variant.length,
                              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 8,mainAxisSpacing: 15,crossAxisSpacing: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return  GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCard = index;
                                      price = widget.variant[index].price;
                                      discountedPrice = widget.variant[index]
                                          .discountedPrice;
                                      discountPercentage =
                                          widget.variant[index]
                                              .discountPercentage;
                                      imageUrl =
                                          widget.variant[index].imageUrl;
                                      variantName =
                                          widget.variant[index].variantName;
                                      stockid = widget.variant[index].stockId;
                                      stocks = widget.variant[index].stocks;
                                    });
                                  },
                                  child: Container(
                                    width: 90,
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: selectedCard == index ? Colors.cyan[600] : Colors.black,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                      color:Colors.white,
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(widget.variant[index].variantName,style:TextStyle(fontWeight: FontWeight.bold,color: selectedCard == index ? Colors.cyan[400] : Colors.black),textAlign: TextAlign.center),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(height: 4,child: Container(color: Colors.blueGrey[50],),),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 10, 0, 15),
                                child: Text("Brand:",style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 10, 0, 15),
                                child: Text(widget.product.brand,style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(fontSize: 15,)),),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height:1,child: Container(color: Colors.blueGrey[50],),),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 0, 15),
                          child: Text("Description",style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),),
                        ),
                        SizedBox(height:1,child: Container(color: Colors.blueGrey[50],),),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 15,15, 15),
                          child: Text( widget.product.description,style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 14),),textAlign: TextAlign.left,),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
    );
  }
}


