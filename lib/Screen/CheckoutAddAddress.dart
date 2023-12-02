import 'package:NeedZIndia/Api.dart';
import 'package:NeedZIndia/Screen/SelectAddress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class AddressData {
  final String type;
  final String name;
  final String alternateMobileNumber;
  final String street;
  final String landmark;
  final String district;
  final String city;
  final String pincode;
  final String state;
  final String country;
  final String id;


  AddressData({this.type,this.name,this.alternateMobileNumber,this.street,this.landmark,this.district,this.city,this.pincode, this.state,this.country,this.id});

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      type: json['type'],
      name: json['name'],
      alternateMobileNumber: json['alternateMobileNumber'],
      street: json['street'],
      landmark: json['landmark'],
      district: json['district'],
      city: json['city'],
      pincode: json['pincode'],
      state: json['state'],
      country: json['country'],
      id: json['id'],
    );
  }
}
class AddressResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final AddressData data;

  AddressResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: AddressData.fromJson(json['data']),
    );
  }
}

class CheckoutAddAddress extends StatefulWidget {
  final double mrp;
  final int quantity;
  final double discount;
  final double totalAmount;
  final String deliveryCharges;
  final List cartIds;
  final String coupon;
  final String specialDiscount;
  final String previousPage;
  final String bookingDate;
  final String timeSlotId;
  final int serviceId;
  final int bookingAmount;
  final int persons;
  CheckoutAddAddress({Key key, this.mrp,this.quantity,this.discount,this.totalAmount,
    this.deliveryCharges,this.cartIds,this.coupon,this.specialDiscount,this.timeSlotId,
    this.previousPage,this.bookingDate,this.serviceId,this.bookingAmount,this.persons}) : super(key: key );
  @override
  _CheckoutAddAddress createState() => _CheckoutAddAddress();
}

class _CheckoutAddAddress extends State<CheckoutAddAddress> {
  final Geolocator geolocator = Geolocator();
  Position _currentPosition;

  final _formkey = GlobalKey<FormState>();
  final typeController  = TextEditingController();
  final nameController  = TextEditingController();
  final alternateMobileNumberController  = TextEditingController();
  final streetController = TextEditingController();
  final landmarkController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final mobileNumberController = TextEditingController();
  String radioItem = '';

  @override
  void dispose(){
    typeController.dispose();
    nameController.dispose();
    mobileNumberController.dispose();
    alternateMobileNumberController.dispose();
    streetController.dispose();
    landmarkController.dispose();
    districtController.dispose();
    cityController.dispose();
    pinCodeController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      setState(() {
        streetController.text =place.name + " " + place.locality + " "  +place.subLocality;
        districtController.text=place.subAdministrativeArea;
        pinCodeController.text=place.postalCode;
        stateController.text=place.administrativeArea;
        countryController.text=place.country;
      });
    });
  }


  @override
  void initState(){
    super.initState();
    print(widget.cartIds);
    fillData();
  }

  fillData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var firstName = prefs.getString('firstName');
    var lastName=prefs.getString('lastName');
    var mobile =prefs.getString('mobile');
    mobileNumberController.text = mobile;
    nameController.text = firstName + " "+lastName;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('Add address',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(key: _formkey,
            child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      try{
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Center(child: CircularProgressIndicator(),);
                            });
                        await _getCurrentLocation();
                        Navigator.pop(context);
                      }on Exception catch (e){
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.cyan[200],
                      ),
                      alignment: Alignment.center,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add_location_outlined,color: Colors.blueGrey,),
                              Text('Use your current location',style: GoogleFonts.quicksand(
                                textStyle: TextStyle(fontSize:18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),textAlign: TextAlign.left,),
                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 16.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child:Text(
                      'Street',style:  TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child:TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: streetController,
                      validator: (value){
                        if(value.isEmpty || value==' '){
                          return 'All fields are mandatory';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 25,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 16.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'Landmark',style:  TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: landmarkController,
                      validator: (value){
                        if(value.isEmpty || value==' '){
                          return 'All fields are mandatory';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 25,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 19.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'City',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: cityController,
                      validator: (value){
                        if(value.isEmpty || value==' '){
                          return 'All fields are mandatory';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height:25,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 16.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'District',style:  TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: districtController,
                      validator: (value){
                        if(value.isEmpty || value==' '){
                          return 'All fields are mandatory';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height:25,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 16.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'Pin Code',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: pinCodeController,
                      keyboardType: TextInputType.phone,maxLength: 6,
                      validator: (value){
                        if(value.isEmpty || value==' '){
                          return 'All fields are mandatory';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height:15),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 16.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'State',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: stateController,
                      validator: (value){
                        if(value.isEmpty || value==' '){
                          return 'All fields are mandatory';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height:25,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 19.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'Country',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: countryController,
                      validator: (value){
                        if(value.isEmpty || value==' '){
                          return 'All fields are mandatory';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height:80,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 18.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'Name',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: nameController,
                      validator: (value){
                        if(value.isEmpty || value==' '){
                          return 'All fields are mandatory';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height:25,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 18.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'Mobile Number',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        prefixText: '+91 ',
                        prefixStyle: TextStyle(fontSize: 17,color: Colors.black),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: mobileNumberController,
                      keyboardType: TextInputType.phone,maxLength: 10,
                      validator: (value){
                        if(value.isEmpty || value==' '){
                          return 'All fields are mandatory';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height:15,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 18.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'Alternative Mobile Number',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        prefixText: '+91 ',
                        prefixStyle: TextStyle(fontSize: 17,color: Colors.black),
                        hintText: "(Optional)",
                        hintStyle: TextStyle(color: Colors.black),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                      controller: alternateMobileNumberController,
                      keyboardType: TextInputType.phone,maxLength: 10,
                    ),
                  ),
                  SizedBox(height:15,),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 18.0,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'Address type',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    ),
                  ),
                  Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: RadioListTile(
                            activeColor: Colors.black,
                            groupValue: radioItem,
                            title: Text('Home'),
                            value: 'Home',
                            onChanged: (val) {
                              setState(() {
                                radioItem = val;
                              });
                            },
                          ),),
                          Expanded(child: RadioListTile(
                            activeColor: Colors.black,
                            groupValue: radioItem,
                            title: Text('Work/Office'),
                            value: 'work',
                            onChanged: (val) {
                              setState(() {
                                radioItem = val;
                              });
                            },
                          ),),
                        ],
                      )
                  ),
                  SizedBox(height: 55,),
                ]
            ),
          ),
        )
      ),
      bottomSheet: Container(
        height: 40,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.cyan[600],
          child: Text('Save'),
          onPressed: ()  async {
            if (_formkey.currentState.validate()) {
              var street = streetController.text;
              var landmark = landmarkController.text;
              var district = districtController.text;
              var city = cityController.text;
              var pincode = pinCodeController.text;
              var state = stateController.text;
              var country = countryController.text;
              var name = nameController.text;
              var alternateMobileNumber = alternateMobileNumberController.text;
              var mobileNumber = mobileNumberController.text;
              var type;
              if(radioItem.isEmpty==true){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Select Address Type")));
              }
              else{
                type =radioItem;
              }
              try{
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return Center(child: CircularProgressIndicator(),);
                    });
                var rsp = await addAddress(
                    type,name,mobileNumber,alternateMobileNumber,street, landmark, district, city,pincode,state,country);
                print(rsp);
                Navigator.pop(context);
                if(rsp.success==false){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(rsp.userFriendlyMessage),
                      backgroundColor: Colors.red));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(rsp.userFriendlyMessage),
                      backgroundColor: Colors.green));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SelectAddress(
                      mrp:widget.mrp,
                      quantity:widget.quantity,discount:widget.discount,
                      deliveryCharges:widget.deliveryCharges,totalAmount:widget.totalAmount,cartIds: widget.cartIds,specialDiscount: widget.specialDiscount,coupon: widget.coupon,
                    bookingDate: widget.bookingDate, serviceId: widget.serviceId,timeSlotId: widget.timeSlotId,pricePerPerson: widget.bookingAmount, previousPage: widget.previousPage, numberOfPerson :widget.persons
                  )));
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  //prefs.setString('add_id', add_id);
                }
              }
              on Exception catch (e){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));
                Navigator.pop(context);
              }
            }
          },
        ),
      ),
    );
  }
}

