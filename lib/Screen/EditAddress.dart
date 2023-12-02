import 'package:NeedZIndia/Api.dart';
import 'package:NeedZIndia/Class/GetAddress.dart';
import 'package:NeedZIndia/screen/myaddress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class UpdateAddressResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final String data;

  UpdateAddressResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory UpdateAddressResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAddressResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: json['data'],
    );
  }
}

class EditAddress extends StatefulWidget {
  //n final String id;
  final GetAddressData data;
  EditAddress({Key key, this.data}) : super(key: key);

  @override
  _EditAddress createState() => _EditAddress();
}

class _EditAddress extends State<EditAddress> {
  final _formkey = GlobalKey<FormState>();
  final  typeController  = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    streetController.text =widget.data.street;
    landmarkController.text= widget.data.landmark;
    districtController.text =widget.data.district;
    cityController.text= widget.data.street;
    pinCodeController.text= widget.data.pincode;
    stateController.text =widget.data.state;
    countryController.text = widget.data.country;
    nameController.text= widget.data.name;
    alternateMobileNumberController.text = widget.data.alternateMobileNumber;
    mobileNumberController.text = widget.data.mobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('Edit address',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
      body: WillPopScope(
        onWillPop: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyAddress())),
        child: SafeArea(
            child: SingleChildScrollView(
              child: Form(key: _formkey,
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 16.0,
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Text(
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
                            if(value.isEmpty){
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
                            if(value.isEmpty){
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
                            if(value.isEmpty){
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
                            if(value.isEmpty){
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
                            if(value.isEmpty){
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
                            if(value.isEmpty){
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
                            if(value.isEmpty){
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
                            if(value.isEmpty){
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
                            if(value.isEmpty){
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
                              Expanded(child:  RadioListTile(
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
                    content: Text("Select Address type")));
              }
              else{
                type =radioItem;
                var _prefs = await SharedPreferences.getInstance();
                var mobile = _prefs.getString('mobile');
                var data= widget.data;
                print("address"+ data.toString());
                try{
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator(),);
                      });
                  var rsp = await updateaddress(mobile,
                      data.id,type,name,mobileNumber,alternateMobileNumber,street, landmark, district, city,pincode,state,country);
                  print(rsp);
                  Navigator.pop(context);
                  if(rsp.success==false){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(rsp.userFriendlyMessage),
                        backgroundColor: Colors.red));                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(rsp.userFriendlyMessage),
                        backgroundColor: Colors.green));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyAddress()));
                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                    //prefs.setString('add_id', add_id);
                  }
                }
                on Exception catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));                }
              }
            }
          },
        ),
      ),
    );
  }
}

