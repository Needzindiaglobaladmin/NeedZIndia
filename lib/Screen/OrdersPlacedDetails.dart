
import 'package:NeedZIndia/Class/PlaceOrder.dart';
import 'package:NeedZIndia/Homepage/Homepage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class OrderPlacedDetails extends StatefulWidget {
  final List<PlacedOrderItems> orderItems;
  final PlaceOrderDetailsData orderDetails;
  final PlaceOrderedShippingAddress shippingAddress;
  OrderPlacedDetails({Key key, this.orderItems,this.orderDetails,this.shippingAddress}) : super(key: key );
  @override
  _OrderPlacedDetails createState() => _OrderPlacedDetails();
}

class _OrderPlacedDetails extends State<OrderPlacedDetails> {
  bool loading = true;
  double mrp=0;
  double discount =0;
  double discountPrice =0;
  String delivery ='';
  String pay = '';
  String expectedDate = '';
  String date='';
  @override
  void initState() {
    super.initState();
    setState(() {
      for(int i=0;i<widget.orderItems.length;i++){
        mrp = mrp + widget.orderItems[i].totalPriceAtTheTimeOfOrdering;
        discount = discount + widget.orderItems[i].totalDiscountedPriceAtTheTimeOfOrdering;
        expectedDate = widget.orderDetails.expectedDeliveryDate;
        if(widget.orderDetails.deliveryCharge==0){
          delivery = 'Free';
        }
        else{
          delivery = "₹"+widget.orderDetails.deliveryCharge.toString();
        }
      }
      final f = new DateFormat('EEE, d MMM yyyy');
      int d = int.parse(expectedDate);
      print(d);
      print(f.format(new DateTime.fromMillisecondsSinceEpoch(d*1000)));
      date = f.format(new DateTime.fromMillisecondsSinceEpoch(d*1000)).toString();
      discountPrice = mrp - discount;
    });
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
      body: WillPopScope(
        onWillPop: () async =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Homepage()), (e) => false),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Center(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/images/success.png'),
                        ),
                        Text('Order Placed Successfully!!',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 20,color: Colors.blueGrey,fontWeight: FontWeight.w700),),),
                        SizedBox(height: 2,),
                        Container(
                          child: Text('Thank you for shopping with us. We\'ll send a confirmation when your item is out for delivery.',style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),textAlign: TextAlign.center,),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
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
                        child: Text('Order ID - '+ widget.orderDetails.orderId.toString(),style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),),
                      ),
                      SizedBox(
                        height: 0.5,
                        child: Container(color: Colors.blueGrey[200],),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                            physics: new BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:  widget.orderItems.isEmpty == true ? 0 : widget.orderItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return  SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
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
                                                child: Image.network(widget.orderItems[index].imageUrl),
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
                                                    SizedBox(height:7,),
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
                SizedBox(height: 5,),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20,10,0,10),
                        child: Icon(Icons.delivery_dining,color: Colors.blueGrey,size: 30,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                        alignment: Alignment.topLeft,
                        child:widget.orderDetails.isDelivered?Text('Delivered',style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),):Text('Delivery Estimated: '+ date ,style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 16,color: Colors.blueGrey),),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
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
                                        widget.shippingAddress.street.toUpperCase() + ','),
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
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                            physics: new BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:  widget.orderItems.isEmpty == true ? 0 : 1,
                            itemBuilder: (BuildContext context, int j) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
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
                                                          child: Text("- ₹" + discountPrice.toStringAsFixed(2),style: GoogleFonts.quicksand(
                                                            textStyle: TextStyle(fontSize: 17,color: Colors.lightBlueAccent),),)
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                                          alignment:Alignment.centerRight,
                                                          child: Text(delivery,style: GoogleFonts.quicksand(
                                                            textStyle: TextStyle(fontSize: 17,color: Colors.lightBlue),),)
                                                      ),
                                                      widget.orderDetails.discountOnCoupon==-1?Container():Container(
                                                          margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                                          alignment:Alignment.centerRight,
                                                          child: Text('-'+widget.orderDetails.discountOnCoupon.toStringAsFixed(2),style: GoogleFonts.quicksand(
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
                              );
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}