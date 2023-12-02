import 'package:NeedZIndia/Class/OrderDetails.dart';
import 'package:NeedZIndia/Screen/OrderedProductDescription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';




class OrderDetails extends StatefulWidget {
  final OrderDetailsData orderDetails;
  final List<OrderedProductVariant> variants;
  final List<OrderItemsData> orderItems;
  final OrderedShippingAddress shippingAddress;
  OrderDetails({Key key, this.orderDetails,this.variants,this.shippingAddress,this.orderItems}) : super(key: key );
  @override
  _OrderDetails createState() => _OrderDetails();
}

class _OrderDetails extends State<OrderDetails> {
  double afterDiscount=0;
  String deliveryCharge ='';
  double totalAmount = 0;
  String date = '';
  double mrp = 0;
  double discountAmount =0;

  @override
  void initState() {
    super.initState();
    final f = new DateFormat('EEE, d MMM yyyy');
    int d = int.parse( widget.orderDetails.expectedDeliveryDate);
    print(d);
    print(f.format(new DateTime.fromMillisecondsSinceEpoch(d*1000)));
    date = f.format(new DateTime.fromMillisecondsSinceEpoch(d*1000)).toString();
    if(mounted){
      setState(() {
        for(int i =0;i<widget.orderItems.length;i++){
          mrp = mrp + widget.orderItems[i].totalPriceAtTheTimeOfOrdering;
          afterDiscount = afterDiscount + widget.orderItems[i].totalDiscountedPriceAtTheTimeOfOrdering;
          widget.orderDetails.deliveryCharge == 0?deliveryCharge = 'Free':deliveryCharge= '+ ₹' + widget.orderDetails.deliveryCharge.toStringAsFixed(2);
        }
        discountAmount= mrp - afterDiscount;
        print(discountAmount);
        print(afterDiscount);
        print(mrp);
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          titleSpacing: 0,
          title: FittedBox(fit: BoxFit.fitWidth,
            child: Text('Order details', style: GoogleFonts.quicksand()),
          ),
          backgroundColor: Colors.cyan[600],
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(height: 8,),
              Container(
                color: Colors.white,
                child:Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20,10,0,10),
                        child:widget.orderDetails.isCancelled? Icon(Icons.cancel,color: Colors.red,size: 30,):widget.orderDetails.isDelivered?Icon(Icons.verified,color: Colors.green,size: 30,):Icon(Icons.delivery_dining,color: Colors.blueGrey,size: 30,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                        alignment: Alignment.topLeft,
                        child:widget.orderDetails.isDelivered?Text('Delivered',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 21,color: Colors.green,fontWeight: FontWeight.w700),),):widget.orderDetails.isCancelled?Text('Cancelled',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 21,color: Colors.red,fontWeight: FontWeight.w700),),):Text('Expected Delivery date',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 21,color: Colors.blueGrey,fontWeight: FontWeight.w700),),),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 6, 0, 10),
                    alignment: Alignment.topLeft,
                    child:widget.orderDetails.isDelivered?Text(DateFormat("EEE, d MMM yyyy").format(DateTime.parse(widget.orderDetails.actualDeliveryDate)),style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.w700),),):widget.orderDetails.isCancelled?Text(date ,style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.w700),),):Text(date ,style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.w700),),),
                  ),
                ],)
              ),
              SizedBox(height: 5,),
              Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 0.5,
                              child: Container(color: Colors.blueGrey[200],),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                              alignment: Alignment.topLeft,
                              child: Text('Order ID - '+ widget.orderDetails.baitOrderId,style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),),
                            ),
                            SizedBox(
                              height: 0.5,
                              child: Container(color: Colors.blueGrey[200],),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 0.5,
                              child: Container(color: Colors.blueGrey[200],),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                              alignment: Alignment.topLeft,
                              child: Text('Ordered Products',style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),),
                            ),
                            SizedBox(
                              height: 0.5,
                              child: Container(color: Colors.blueGrey[200],),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          physics: new BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:  widget.orderItems.isEmpty == true ? 0 : widget.orderItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return  SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () async {
                                      var _prefs = await SharedPreferences.getInstance();
                                      var cart = _prefs.getInt('cartValue');
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderedProductDescription(product: widget.orderItems[index],variant: widget.orderItems[index].variants,cart: cart,),)
                                      );
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                                              height: 140,
                                              width: 100,
                                              child: FadeInImage.assetNetwork(
                                                placeholder: 'assets/images/loading.gif',
                                                image: widget.orderItems[index].imageUrl,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(height:7,),
                                                  Text(widget.orderItems[index].productName,style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(fontSize: 15,),fontWeight: FontWeight.w600),),
                                                  SizedBox(height:7,),
                                                  Text(widget.orderItems[index].variantName,style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey)),),
                                                  SizedBox(height:12,),
                                                  widget.orderItems[index].discountPercentageAtTheTimeOfOrdering!=0?
                                                  Text('₹'+widget.orderItems[index].priceAtTheTimeOfOrdering.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey,decoration: TextDecoration.lineThrough),fontWeight: FontWeight.w600),):Container(),
                                                  SizedBox(height:7,),
                                                  Text('₹'+widget.orderItems[index].discountedPriceAtTheTimeOfOrdering.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(fontSize: 18,color: Colors.blueGrey),fontWeight: FontWeight.w600),),
                                                  SizedBox(height:7,),
                                                  Text('Qty - '+widget.orderItems[index].quantityOrdered.toString(),style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(fontSize: 15,color: Colors.blueGrey),fontWeight: FontWeight.w600),),
                                                  SizedBox(height:10,),
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
                            );
                          }),
                    ],
                  )
              ),
              GestureDetector(
                onTap: () async{
                  String orderId = widget.orderDetails.orderId.toString();
                  String url = 'https://www.needzindia.com/api/generateInvoice.php?orderId=$orderId';
                  if (await canLaunch(url)) {
                  await launch(url, forceSafariVC: true,
                    enableJavaScript: true,);
                  } else {
                  throw 'Could not launch $url';
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(20, 15, 0, 15),
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.description,color: Colors.cyan,)
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 15, 0, 15),
                        alignment: Alignment.centerLeft,
                        child: Text('Download Invoice',style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18,)),),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(20, 15, 15, 15),
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.download_outlined,color: Colors.cyan,)
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6,),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 15, 0, 5),
                      alignment: Alignment.topLeft,
                      child: Text('Delivery Address',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 22,),fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 8, 0, 8),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            alignment: Alignment.topLeft,
                            child:Text(toBeginningOfSentenceCase(
                                widget.shippingAddress.name.toUpperCase() +' , '+widget.shippingAddress.mobileNumber
                            ),
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                              textAlign: TextAlign.left,),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(toBeginningOfSentenceCase(
                                      widget.shippingAddress.street.toUpperCase()+','),
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                  child: Text(toBeginningOfSentenceCase(
                                      widget.shippingAddress.landmark.toUpperCase() + ","),
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                  child: Text(toBeginningOfSentenceCase(
                                      widget.shippingAddress.district.toUpperCase() + ","),
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                  child: Text(toBeginningOfSentenceCase(
                                      widget.shippingAddress.city.toUpperCase() + ","),
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                  child: Text(toBeginningOfSentenceCase(
                                      widget.shippingAddress.pincode + ","),
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                  child: Text(toBeginningOfSentenceCase(
                                      widget.shippingAddress.country.toUpperCase()),
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                  child: widget.shippingAddress.alternateMobileNumber.isEmpty == true?Text(''):Text(toBeginningOfSentenceCase(','+
                                      widget.shippingAddress.alternateMobileNumber),
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                                ),
                              ],
                            ),
                          ),
                        ],

                      ),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      alignment:Alignment.centerLeft,
                      child: Text("Price details ",style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),textAlign: TextAlign.left,),
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
                                    margin: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Total MRP:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 17,color: Colors.blueGrey),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Discount:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 17,color: Colors.blueGrey),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Delivery Charges:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 17,color: Colors.blueGrey),),)
                                ),
                                widget.orderDetails.discountOnCoupon==-1?Container():Container(
                                    margin: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Coupon Discount:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 17,color: Colors.blueGrey),),)
                                ),
                                SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                                SizedBox(height: 4,),
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                    alignment:Alignment.centerLeft,
                                    child: Text("Total Amount:",style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.blueGrey),),)
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                    alignment:Alignment.centerRight,
                                    child: Text("₹" + mrp.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 17,),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                    alignment:Alignment.centerRight,
                                    child: Text("- ₹" + discountAmount.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 17,color: Colors.lightBlueAccent),),)
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                    alignment:Alignment.centerRight,
                                    child: Text(deliveryCharge,style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 17,color: Colors.lightBlue),),)
                                ),
                                widget.orderDetails.discountOnCoupon==-1?Container():Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                    alignment:Alignment.centerRight,
                                    child: Text('- ₹'+widget.orderDetails.discountOnCoupon.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 17,color: Colors.green),),)
                                ),
                                SizedBox(height: 1,child: Container(color: Colors.blueGrey[50],),),
                                SizedBox(height: 4,),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                    alignment:Alignment.centerRight,
                                    child: Text("₹" + widget.orderDetails.totalPayableAmount.toStringAsFixed(2) ?? null,style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.blueGrey),),)
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(25, 15, 0, 20),
                      alignment: Alignment.topLeft,
                      child: Text('Payment mode - '+ widget.orderDetails.paymentMode.toUpperCase(),style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 18,),fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}