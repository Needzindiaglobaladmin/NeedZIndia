import 'package:NeedZIndia/Api.dart';
import 'package:NeedZIndia/Class/OrderDetails.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class OrderedProductDescription extends StatefulWidget {
  final List<OrderedProductVariant> variant;
  final OrderItemsData product;
  final int cart;
  OrderedProductDescription({Key key, this.variant,this.product,this.cart}) : super(key: key );

  @override
  _OrderedProductDescription createState() => _OrderedProductDescription();
}

class _OrderedProductDescription extends State<OrderedProductDescription> {
  var price;
  var discountedPrice;
  var discountPercentage;
  var imageUrl;
  var variantName;
  var stockid;
  var cartValue = 0;
  var stocks;
  int selectedCard = -1;
  bool _loading = true;
  int counter = 0;
  bool addedToCart = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      if(mounted){
        setState(() {
          imageUrl = widget.product.imageUrl;
          variantName = widget.product.variantName;
          cartValue = widget.cart;
          for(int i=0;i<widget.variant.length;i++){
            if(widget.product.stockId == widget.variant[i].stockId){
              stockid = widget.variant[i].stockId;
              price = widget.variant[i].price;
              discountedPrice =widget.variant[i].discountedPrice;
              discountPercentage = widget.variant[i].discountPercentage;
              stocks = widget.variant[i].stocks;
            }
          }
          _loading = false;
        });
      }
    });
    print(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    final CartValue cartValue  = Provider.of<CartValue>(context);
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
                  child: new IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()),
                    );
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
                        Container(
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
                        ),
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
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 6, 0, 0),
                          child: Text("(Inclusive of all taxes)",style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 12,)),),
                        ),
                        stocks==0?Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                            alignment: Alignment.bottomRight,
                            child: Text("Out of Stock",style: TextStyle(color: Colors.red),),
                        ):
                        Container(
                          alignment: Alignment.bottomRight,
                          child: addedToCart ?
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                            alignment: Alignment.bottomRight,
                            height: 40,
                            child: FlatButton(
                              color: Colors.grey,
                              child: FittedBox(child: Text("Added to cart",style: TextStyle(color: Colors.white),),),
                              onPressed: ()  {
                                Toast.show("Product already added to cart", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                              },
                            ),
                          ): Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                            alignment: Alignment.bottomRight,
                            height: 40,
                            width: 100,
                            child: FlatButton(
                              color: Colors.cyan[600],
                              child: FittedBox(child: Text('Add to Cart',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),),
                              onPressed: () async {
                                print(stockid);
                                var _prefs =await SharedPreferences.getInstance();
                                var mobile = _prefs.getString('mobile');
                                var stockId = stockid.toString();
                                var quantityToBeBought = '1';
                                try {
                                  showDialog(
                                      barrierDismissible : false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(child: CircularProgressIndicator(),);
                                      });
                                  var rsp= await addCart(mobile,stockId,quantityToBeBought);
                                  Navigator.pop(context);
                                  if(rsp.success==false){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(rsp.userFriendlyMessage),
                                        backgroundColor: Colors.red));
                                  }
                                  else{
                                    if(mounted){
                                      setState(() {
                                        addedToCart = true;
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
                              itemCount:  widget.variant == null ? 0 :widget.variant.length,
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


