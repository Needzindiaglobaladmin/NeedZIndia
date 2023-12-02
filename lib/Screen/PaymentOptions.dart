
import 'package:NeedZIndia/Api.dart';
import 'package:NeedZIndia/Screen/OrdersPlacedDetails.dart';
import 'package:NeedZIndia/Screen/SlotBookedDetails.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';



class PaymentOptions extends StatefulWidget {
  final String addressId;
  final List cartIds;
  final double totalAmount;
  final String coupon;
  final String previousPage;
  final String bookingDate;
  final String timeSlotId;
  final int serviceId;
  final String bookingAmount;
  final int persons;
  PaymentOptions({Key key, this.addressId,this.cartIds,this.totalAmount,this.coupon,
  this.previousPage,this.serviceId,this.bookingDate,this.timeSlotId,this.bookingAmount,this.persons}) : super(key: key );
  @override
  _PaymentOptions createState() => _PaymentOptions();
}

class _PaymentOptions extends State<PaymentOptions> {
  bool loading = true;
  String radioItem = '';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      if(mounted){
        setState(() {
          loading = false;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final CartValue cartValue  = Provider.of<CartValue>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan[600],
        titleSpacing: 0.0,
        title: FittedBox(fit: BoxFit.fitWidth,
          child: Text('Payment Options', style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
      ),
      body: loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) :
      Column(
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: Text('Select Payment Method',style: GoogleFonts.quicksand(
                textStyle: TextStyle(fontSize:18,color: Colors.cyan[600],fontWeight: FontWeight.bold),),textAlign: TextAlign.center,),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 0.2,
                ),
                borderRadius: BorderRadius.circular(0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RadioListTile(
                    activeColor: Colors.cyan[600],
                    groupValue: radioItem,
                    title: Text('POD',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize:18,fontWeight: FontWeight.w600),)) ,
                    subtitle: Text('(Pay Online at you door)',style: GoogleFonts.quicksand(
                      textStyle: TextStyle(fontSize:12,fontWeight: FontWeight.bold),)),
                    value: "POD",
                    onChanged: (val) {
                      setState(() {
                        radioItem = val;
                        print(radioItem);
                      });
                    },
                  ),
                  RadioListTile(
                    activeColor: Colors.cyan[600],
                    groupValue: radioItem,
                    title: Text('COD',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize:18,fontWeight: FontWeight.w600),)) ,
                    subtitle: Text('(Cash on delivery)',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize:12,fontWeight: FontWeight.bold),)),
                    value: "COD",
                    onChanged: (val) {
                      setState(() {
                        radioItem = val;
                        print(radioItem);
                      });
                    },
                  ),
                ],
              )
          ),
          widget.previousPage == 'cart'?
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
              alignment: Alignment.center,
              child:Text('Total Amount to pay : ₹ ' + widget.totalAmount.toStringAsFixed(2),style: GoogleFonts.quicksand(
                textStyle: TextStyle(fontSize:18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),textAlign: TextAlign.left,),
            ),
          ): Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
              alignment: Alignment.center,
              child: Text('Total Amount to pay : ₹ ' + widget.bookingAmount,style: GoogleFonts.quicksand(
                textStyle: TextStyle(fontSize:18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),textAlign: TextAlign.left,),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 40,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          color: Colors.cyan[600],
          child: widget.previousPage=='cart'?Text('Place Order',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 20,color: Colors.white),),):Text('Confirm Booking',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 20,color: Colors.white),),),
          onPressed: () async {
            var paymentMethod;
            if(widget.previousPage=='cart'){
              if(radioItem == ''){
                Toast.show('Select Payment method', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              }
              else{
                var _prefs =await SharedPreferences.getInstance();
                var mobile = _prefs.getString('mobile');
                var deliveryAddressId = widget.addressId;
                paymentMethod = radioItem;
                List cartIds = widget.cartIds;
                print(radioItem);
                var couponCode;
                print(deliveryAddressId);
                print(cartIds);
                try{
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator(),);
                      });
                  if(widget.coupon==null){
                    couponCode = "";
                  }
                  else{
                    couponCode= widget.coupon;
                  }
                  var rsp = await placeOrder(mobile, deliveryAddressId, paymentMethod, cartIds.toString(),couponCode);
                  print(rsp);
                  Navigator.pop(context);
                  if(rsp.success==false){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(rsp.userFriendlyMessage),
                        backgroundColor: Colors.red));
                  }
                  else{
                    cartValue.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => OrderPlacedDetails(
                        orderItems: rsp.data.orderItems, orderDetails:rsp.data,shippingAddress: rsp.data.shippingAddress)));
                  }
                }
                on Exception catch (e){
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));
                }
              }
            }
            else{
              if(radioItem == ''){
                Toast.show('Select Payment method', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              }
              else{
                var _prefs =await SharedPreferences.getInstance();
                var mobile = _prefs.getString('mobile');
                var deliveryAddressId = widget.addressId;
                paymentMethod = radioItem.toLowerCase();
                var serviceId = widget.serviceId.toString();
                var timeSlotId =  widget.timeSlotId;
                var bookingDate = widget.bookingDate;
                var numberOfPersons = widget.persons.toString();
                print(radioItem);
                try{
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator(),);
                      });
                  var rsp = await slotBooking(mobile, bookingDate,  timeSlotId,  serviceId, deliveryAddressId, paymentMethod,numberOfPersons);
                  print(rsp);
                  Navigator.pop(context);
                  if(rsp.success==false){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(rsp.userFriendlyMessage),
                        backgroundColor: Colors.green));
                  }
                  else{
                    print(rsp);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SlotBookedDetails(
                       bookingDetails: rsp.data,)));
                  }
                }
                on Exception catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));
                }
              }
            }
          },
        ),
      ),
    );
  }
}
