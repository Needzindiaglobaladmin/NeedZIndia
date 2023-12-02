import 'dart:convert';
import 'dart:io';
import 'package:NeedZIndia/Categories/AllCategories/Categories.dart';
import 'package:NeedZIndia/Categories/Services/BodyCheckUp.dart';
import 'package:NeedZIndia/Categories/Services/PanCard.dart';
import 'package:NeedZIndia/Categories/Services/Passport.dart';
import 'package:NeedZIndia/Class/CheckPinCodeResponse.dart';
import 'package:NeedZIndia/Class/ProductResponse.dart';
import 'package:NeedZIndia/Homepage/CarouselImage.dart';
import 'package:NeedZIndia/Homepage/Carouselpro.dart';
import 'package:NeedZIndia/Homepage/Carouselpro2.dart';
import 'package:NeedZIndia/Homepage/Carouselpro3.dart';
import 'package:NeedZIndia/Homepage/Carouselpro4.dart';
import 'package:NeedZIndia/Homepage/Slide.dart';
import 'package:NeedZIndia/Homepage/VerticalGrid.dart';
import 'package:NeedZIndia/Homepage/VerticalGrid2.dart';
import 'package:NeedZIndia/Homepage/VerticalGrid3.dart';
import 'package:NeedZIndia/Homepage/VerticalGrid4.dart';
import 'package:NeedZIndia/Homepage/VerticalGrid5.dart';
import 'package:NeedZIndia/Homepage/VerticalGrid6.dart';
import 'package:NeedZIndia/Homepage/VerticalGrid7.dart';
import 'package:NeedZIndia/Homepage/VerticalGrid8.dart';
import 'package:NeedZIndia/UserDataNotifier.dart';
import 'package:NeedZIndia/Screen/Cart.dart';
import 'package:NeedZIndia/Screen/HelpCenter.dart';
import 'package:NeedZIndia/Screen/AboutUs.dart';
import 'package:NeedZIndia/Screen/Login.dart';
import 'package:NeedZIndia/Screen/MyAccount.dart';
import 'package:NeedZIndia/Screen/MyBookings.dart';
import 'package:NeedZIndia/Screen/MyOrders.dart';
import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:NeedZIndia/Screen/SearchBar.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:NeedZIndia/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';



class Homepage extends StatefulWidget {

  @override
  _Homepage createState() => _Homepage();

}
class _Homepage extends State<Homepage> with WidgetsBindingObserver{

  int cart=0;
  final _formkey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  bool isInternetOn = true;
  Map data;
  var list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Position _currentPosition;
  bool loading = true;
  List<String> searchData =[];
  bool isDeliverable;
  var queryParameters;
  String pinCode ="";
  bool authorized = false;
  String deliveryImage = "";
  final newVersion = NewVersion(
    androidId: 'com.needzindia.fresh_mart',
  );
  static const simpleBehavior = true;



  @override
  void initState(){
    super.initState();
    print(newVersion.androidId);
    if (simpleBehavior) {
      basicStatusCheck(newVersion);
    } else {
      advancedStatusCheck(newVersion);
    }
    getConnect();
    try{
      _getCurrentLocation();
    }on Exception catch(e){
      print(e);
    }
    authorizationGranted();
    loadingCartValue();
    this.fetchProductsData();
    WidgetsBinding.instance.addObserver(this);
  }

  authorizationGranted() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    if(token == null){
      print("token null");
    }
    else{
      final userDetails = Provider.of<UserDataNotifier>(context, listen: false);
      userDetails.getJsonData();
      if(mounted){
        setState(() {
          authorized = true;
        });
      }
    }
  }
  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    print( newVersion.getVersionStatus());
    if (status != null) {
      newVersion.showUpdateDialog(
        allowDismissal: false,
        context: context,
        versionStatus: status,
        dialogTitle: 'Update available',
        dialogText: 'Update your app to explore new features',
        dismissButtonText: 'Download Now',
        dismissAction: () => appLink(),
      );
    }
  }

  appLink() async{
    String url = 'https://play.google.com/store/apps/details?id=com.needzindia.fresh_mart';
    if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true,
    enableJavaScript: true,);
    } else {
    throw 'Could not launch $url';
    }
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    pinController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      print(state);
      if(mounted){
        setState(() {
          this.fetchProductsData();
          loadingCartValue();
        });
      }
    }
    if(state == AppLifecycleState.paused){
      print(state);
    }
  }

  loadingCartValue() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    if(token == null){
      print("token null");
    }
    else{
      print("loading");
      try{
        final cartValue = Provider.of<CartValue>(context, listen: false);
        var rsp = await cartValue.fetchCartData();
        if(rsp.success == true){
          print("Cart Response"+rsp.toString());
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(rsp.userFriendlyMessage),
              backgroundColor: Colors.red));
        }
      }on Exception catch (e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));      }
    }
  }

  void getConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if(mounted){
        setState(() {
          isInternetOn = false;
        });
      }
    } else if (connectivityResult == ConnectivityResult.mobile) {
      if(mounted){
        setState(() {
          isInternetOn = true;
        });
      }
    }
  }




  Future<ProductResponse> fetchProductsData() async {
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try{
      final url = Constant.GET_PRODUCTS_API;
      final response = await http.get(Uri.parse(Constant.apiShort_Url+url),
        headers: <String, String>{HttpHeaders.authorizationHeader: token==null?"":token,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      var response1 = ProductResponse.fromJson(json.decode(response.body));
      if (response1.success == true) {
       if(mounted){
         setState(() {
           for(int i =0;i<response1.data.length;i++){
             searchData.add(response1.data[i].productName);
             searchData.add(response1.data[i].brand);
           }
           print(searchData);
           loading = false;
         });
       }
        return response1;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response1.userFriendlyMessage),
            backgroundColor: Colors.red));
      }
    }on Exception catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));    }
  }


  _getCurrentLocation() async {
   try{
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
     Placemark place = placemarks[0];
     setState(() {
       setState(() {
         pinCode =place.postalCode;
         pinController.text=place.postalCode;
       });
     });
   }on Exception catch(e){
     print(e);
   }
  }

  Future<CheckPinCodeResponse> checkPinCode() async {
    try{
      var uri =
      Uri.https(Constant.URL,'/api/isPincodeDeliverable.php',queryParameters);
      final response = await http.get((uri),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      var response1 = CheckPinCodeResponse.fromJson(json.decode(response.body));
      if (response1.success == true) {
        if(mounted){
          setState(() {
            isDeliverable = response1.data;
          });
        }
        return response1;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response1.userFriendlyMessage),
            backgroundColor: Colors.red));
      }
    }on Exception catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong")));    }
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final CartValue cartValue  = Provider.of<CartValue>(context);
    final userDetails = Provider.of<UserDataNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Transform(
            transform: new Matrix4.translationValues(-45.0, 0.0, 0.0),
            child:  FittedBox(fit:BoxFit.fitWidth,
              child:Container(
                height: 50,
                width:110,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
                child: Image.asset("assets/images/logo.ico",fit: BoxFit.contain
                ),
              ),
            ),
          ),
          backgroundColor: Colors.cyan[600],
          actions: [
            IconButton(
              icon:Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchBar(searchQuery:searchData)),
                );
              },
            ),
            new Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: new IconButton(icon: Icon(Icons.shopping_cart),
                      onPressed: () async {
                        var _prefs = await SharedPreferences.getInstance();
                        var token = _prefs.getString('token');
                        if(token == null){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Do you want to login?",style: GoogleFonts.quicksand(
                                textStyle: TextStyle(color: Colors.grey[850],fontWeight: FontWeight.w600),)),
                                content: Text('Login to see the items you added previously',style: GoogleFonts.quicksand(
                              textStyle: TextStyle(color: Colors.grey[850],fontWeight: FontWeight.w500),)),
                                actions: <Widget>[
                                  FlatButton(child: Text('Cancel',style: GoogleFonts.quicksand(
                              textStyle: TextStyle(color: Colors.blueGrey[700]),)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(child: Text('Proceed to Log in'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
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
                        fontSize: 8,fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ) : new Container()
              ],
            ),
          ],

        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/drawerpic.jpg"),
                        fit: BoxFit.cover)
                ),
                child: loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                ): authorized ? Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children:<Widget> [
                          SizedBox(height: 5,),
                          Container(
                            child:CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage:userDetails.imageUrl == '' || userDetails.imageUrl == null ? AssetImage('assets/images/avatar.png')
                                  :CachedNetworkImageProvider( userDetails.imageUrl + "?a="+ DateTime.now().millisecondsSinceEpoch.toString()),
                            ) ,
                          ),
                          Container(
                              alignment: Alignment.center,
                              child:Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(95, 0, 0, 0),
                                    child: Text('Hey,',style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child:userDetails.userName == '' || userDetails.userName == null ? Text(toBeginningOfSentenceCase('Dear' ),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
                                    ),textAlign: TextAlign.center,): Text(toBeginningOfSentenceCase(userDetails.userName),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
                                    ),textAlign: TextAlign.center,),
                                  ),
                                ],
                              ) ),
                        ],
                      ),
                    ),
                  ],
                ):Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children:<Widget> [
                          SizedBox(height: 5,),
                          Container(
                            child:CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage('assets/images/avatar.png')
                            ) ,
                          ),
                          Container(
                              alignment: Alignment.center,
                              child:Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(95, 0, 0, 0),
                                    child: Text('Hey,',style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child:Text(toBeginningOfSentenceCase('Dear' ),style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
                                    ),textAlign: TextAlign.center,)
                                  ),
                                ],
                              ) ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                leading: Icon(Icons.home,color: Colors.blueGrey,),
                title: Transform.translate(
                  offset: Offset(-14, 0),
                  child: Text('Home',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                leading: Icon(Icons.border_all,color: Colors.blueGrey),
                title: Transform.translate(
                  offset: Offset(-14, 0),
                  child: Text('Categories',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Categories()),
                );
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                leading: Icon(Icons.business_center,color: Colors.blueGrey),
                title:Transform.translate(
                  offset: Offset(-14, 0),
                  child:Text('My Orders',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),),
                ),
                onTap: () async {
                  var _prefs = await SharedPreferences.getInstance();
                  var token = _prefs.getString('token');
                  if(token == null){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                    );
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyOrders()),
                    );
                  }
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                leading: Icon(Icons.check_box,color: Colors.blueGrey,),
                title:Transform.translate(
                  offset: Offset(-14, 0),
                  child:Text('My Bookings',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),),
                ),
                onTap: () async {
                  var _prefs = await SharedPreferences.getInstance();
                  var token = _prefs.getString('token');
                  if(token == null){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                    );
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyBookings()),
                    );
                  }
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                leading: Icon(Icons.shopping_cart,color: Colors.blueGrey),
                title: Transform.translate(
                  offset: Offset(-14, 0),
                  child: Text('My Cart',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),),
                ),
                onTap: () async {
                  var _prefs = await SharedPreferences.getInstance();
                  var token = _prefs.getString('token');
                  if(token == null){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                    );
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()),
                    );
                  }
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                leading: Icon(Icons.account_circle,color: Colors.blueGrey),
                title: Transform.translate(
                  offset: Offset(-14, 0),
                  child: Text('My Account',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),),
                ),
                onTap: () async {
                  var _prefs = await SharedPreferences.getInstance();
                  var token = _prefs.getString('token');
                  if(token == null){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                    );
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyAccount()),
                    );
                  }
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                leading: Icon(Icons.support,color: Colors.blueGrey),
                title: Transform.translate(
                  offset: Offset(-14, 0),
                  child: Text('Customer Support',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpCenter()),
                );
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                leading: Icon(Icons.description,color: Colors.blueGrey),
                title: Transform.translate(
                  offset: Offset(-14, 0),
                  child: Text('About us',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUs()),
                );
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                leading: authorized?Icon(Icons.logout,color: Colors.blueGrey):Icon(Icons.login,color: Colors.blueGrey),
                title: Transform.translate(
                  offset: Offset(-14, 0),
                  child: authorized?Text('Log Out',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),):Text('Log In',style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18),
                  ),)
                ),
                onTap: ()  async {
                  var _prefs = await SharedPreferences.getInstance();
                  var token = _prefs.getString('token');
                  if(token == null){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
                    );
                  }
                  else{
                    return showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(title: Text('Are you sure you want to Log out?',style: GoogleFonts.quicksand(
                              textStyle: TextStyle(color: Colors.blueGrey),)), actions: <Widget>[
                              GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child:  Text('No',style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(color: Colors.blueGrey,fontSize: 18),)),
                                  ),
                                  onTap: () => Navigator.of(context).pop(false)),
                              GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text('Yes',style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(color: Colors.cyan[600],fontSize: 18),)),
                                  ),
                                  onTap: () async {
                                    var _prefs =await SharedPreferences.getInstance();
                                    var token = _prefs.remove('token');
                                    var mobile = _prefs.remove('mobile');
                                    var firstName = _prefs.remove('firstName');
                                    var lastName = _prefs.remove('lastName');
                                    var emailId =  _prefs.remove('emailId');
                                    var genderVar =  _prefs.remove('gender');
                                    var imageUrl =  _prefs.remove('imageUrl');
                                    print(token);
                                    cartValue.clear();
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                        Homepage()), (Route<dynamic> route) => false);
                                  }
                              ),
                            ]));
                  }
                },
              ),
            ],
          ),
        ),
        body: isInternetOn ? SafeArea(
          child: loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[600]),),) :SingleChildScrollView(
            child: Center(child: Column(
              children: <Widget>[
                if (pinCode != "")
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                      color: Colors.cyan[600],
                    ),
                    width: MediaQuery.of(context).size.width ,
                    child: Column(
                      children: <Widget>[
                        Container(
                            child:Form(key: _formkey,
                              child: Row(
                                children: <Widget>[
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Icon(Icons.room,color: Colors.white,),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      "Check your delivery location ",style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(),color:Colors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: GestureDetector(
                                      child:Container(
                                        margin: EdgeInsets.fromLTRB(10, 15, 0, 15),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.edit_outlined,size: 20,color: Colors.white,
                                            ),
                                            FittedBox(
                                              child: Text('(Change)',style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(),color:Colors.white,),
                                              ),
                                            )
                                          ],
                                        )
                                      ),
                                      onTap: (){
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
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        TextField(
                                                          decoration: InputDecoration(
                                                              icon: Icon(Icons.my_location,color: Colors.black,),
                                                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                              hintText: 'Enter your Pincode'),
                                                          keyboardType: TextInputType.phone,maxLength: 6,
                                                          controller: pinController,
                                                        ),
                                                        Container(
                                                          alignment: Alignment.center,
                                                          width: MediaQuery.of(context).size.width,
                                                          child: RaisedButton(
                                                            onPressed: () async {
                                                              if (_formkey.currentState.validate()){
                                                                queryParameters = {
                                                                  'pincode' : pinController.text,
                                                                };
                                                                try{
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return Center(child: CircularProgressIndicator(),);
                                                                      });
                                                                  var rsp = await checkPinCode();
                                                                  print(rsp);
                                                                  Navigator.pop(context);
                                                                  if(rsp.data==false){
                                                                    Navigator.pop(context);
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return Dialog(
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                BorderRadius.circular(20.0)), //this right here
                                                                            child: Container(
                                                                              height: 200,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(12.0),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Container(
                                                                                      child: Row(
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            margin:EdgeInsets.fromLTRB(10,0,2,0),
                                                                                            child: Icon(Icons.warning_amber_rounded,color: Colors.red,size: 35,),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Text("Sorry!! Currently we are not delivering at your location",softWrap: true,style: GoogleFonts.quicksand(
                                                                                                textStyle: TextStyle(fontSize: 18),fontWeight: FontWeight.bold,color: Colors.redAccent),textAlign: TextAlign.center,),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(height: 5,),
                                                                                    Container(
                                                                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                                                      alignment: Alignment.center,
                                                                                      width: MediaQuery.of(context).size.width,
                                                                                      child: RaisedButton(
                                                                                        onPressed: ()  {
                                                                                          Navigator.pop(context);
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
                                                                  else{
                                                                    Navigator.pop(context);
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return Dialog(
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                BorderRadius.circular(20.0)), //this right here
                                                                            child: Container(
                                                                              height: 140,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(12.0),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Container(
                                                                                      child: Row(
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            margin:EdgeInsets.fromLTRB(20,0,4,0),
                                                                                            child: Icon(Icons.delivery_dining,color: Colors.blueGrey,size: 35,),
                                                                                          ),
                                                                                         Expanded(
                                                                                           child:  Text("Hurray!! we are at your city",style: GoogleFonts.quicksand(
                                                                                               textStyle: TextStyle(fontSize: 18),fontWeight: FontWeight.bold,color: Colors.blueGrey),textAlign: TextAlign.center,),
                                                                                         )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(height: 2,),
                                                                                    Container(
                                                                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                                                      alignment: Alignment.center,
                                                                                      width: 120.0,
                                                                                      child: RaisedButton(
                                                                                        onPressed: ()  {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Text(
                                                                                          "Shop now",
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
                                                                }
                                                                on Exception catch (e){
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                      content: Text("Something went wrong")));                                                                }
                                                              }
                                                            },
                                                            child: Text(
                                                              "Sumbit",
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
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                      ],
                    ),

                  ),
                SizedBox(height: 3,),
                Carouselpro(),
                SizedBox(height: 2,),
                Container(
                  height: SizeConfig.blockSizeVertical * 6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Next_day_delivery.JPG'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 3,),
                SizedBox(height: 3,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 23,
                  child: Container(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Shop by Category', style: GoogleFonts.dosis(
                        textStyle: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,),
                      ),
                      ),
                    )
                  ),
                ),
                Slide(searchQuery: searchData,),
                SizedBox(height: 3,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
                CarouselImage(),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
               Container(
                 child: Column(
                   children: <Widget>[
                     SizedBox(height: 5,),
                     SizedBox(height: 22,
                       child: Container(
                         alignment: Alignment.center,
                         height: 30.0,
                         child:FittedBox(
                           child:  Text(
                             'Home Essentials', style: GoogleFonts.quicksand(
                             textStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight:FontWeight.bold),
                           ),
                           ),
                         )
                       ),
                     ),
                     SizedBox(height: 10,),
                     VerticalGrid(),
                     SizedBox(height: 5,),
                     VerticalGrid2(),
                     SizedBox(height: 5,),
                     VerticalGrid3(),
                     SizedBox(height: 10,),
                     SizedBox(height: 2,
                       child: Container(
                         color: Colors.cyan[600],
                         alignment: Alignment.center,
                       ),
                     ),
                   ],
                 ),
               ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Slider.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),

                    child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        margin:EdgeInsets.all(10),
                        child:  Container(
                          margin:EdgeInsets.fromLTRB(5, 2, 5, 2),
                          child: Text(
                            'Services', style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18,color: Colors.black87,fontWeight:FontWeight.bold),
                          ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PanCard()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                height: 165,
                                width: 280,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue[300],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                              child:  FittedBox(
                                                child: Text(
                                                  '₹159/- Only', style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(fontSize: 18,color: Colors.white,fontWeight:FontWeight.bold),
                                                ),
                                                ),
                                              )
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                              child:  Text(
                                                'Apply for your PAN card from your door step', style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 14,color: Colors.blueGrey[50],fontWeight:FontWeight.bold),
                                              ),textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 0.2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(2),
                                                  color: Colors.white,
                                                ),
                                                margin: EdgeInsets.fromLTRB(0, 27, 0, 0),
                                                child:  Container(
                                                  margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                                  child: Text(
                                                    'Book now', style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight:FontWeight.bold),
                                                  ),textAlign: TextAlign.center,
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                        child: Image.asset("assets/images/pan.png"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Passport()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                height: 165,
                                width: 280,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue[300],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                              child:  Text(
                                                '₹1799/- Only', style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 18,color: Colors.white,fontWeight:FontWeight.bold),
                                              ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                              child:  Text(
                                                'Apply for your Passport from your door step', style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 14,color: Colors.blueGrey[50],fontWeight:FontWeight.bold),
                                              ),textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 0.2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(2),
                                                  color: Colors.white,
                                                ),
                                                margin: EdgeInsets.fromLTRB(0, 27, 0, 0),
                                                child:  Container(
                                                  margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                                  child: Text(
                                                    'Book now', style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight:FontWeight.bold),
                                                  ),textAlign: TextAlign.center,
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                        child: Image.asset("assets/images/passportimg.jpg"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BodyCheckUp()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                height: 165,
                                width: 280,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue[300],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                              child:  Text(
                                                '₹499/- Only', style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 16,color: Colors.white,fontWeight:FontWeight.bold),
                                              ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                              child:  Text(
                                                'Get you full body checkup done from your door step', style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(fontSize: 14,color: Colors.blueGrey[50],fontWeight:FontWeight.bold),
                                              ),textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 0.2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(2),
                                                  color: Colors.white,
                                                ),
                                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                child:  Container(
                                                  margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                                  child: Text(
                                                    'Book now', style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight:FontWeight.bold),
                                                  ),textAlign: TextAlign.center,
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                        child: Image.asset("assets/images/doctor.PNG"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  )
                ),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
                Carouselpro2(),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage("assets/images/Personal_care.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height:25,),
                      SizedBox(height: 22,
                        child: Container(
                          alignment: Alignment.center,
                          height: 30.0,
                          child: FittedBox(
                            child: Text(
                              'Personal Care', style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight:FontWeight.bold),
                            ),
                            ),
                          )
                        ),
                      ),
                      SizedBox(height: 10,),
                      VerticalGrid4(),
                      SizedBox(height: 5,),
                      VerticalGrid5(),
                      SizedBox(height:10,),
                      SizedBox(height: 2,
                        child: Container(
                          color: Colors.cyan[600],
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  height: 480,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Popular_brands.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        margin:EdgeInsets.all(10),
                        child:  Container(
                          margin:EdgeInsets.fromLTRB(5, 2, 5, 2),
                          child: Text(
                            'Popular Brands', style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18,color: Colors.black87,fontWeight:FontWeight.bold),
                          ),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: "Aashirvaad",)),
                                );
                              },
                              child:Container(
                                margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Container(
                                    margin:EdgeInsets.fromLTRB(5,0,5,0),
                                    child:Image.asset("assets/images/aashirvaad_brand.jpg"),
                                  ),
                                ),
                              )
                          ),),
                          Expanded(child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: "Maggi",)),
                                );
                              },
                              child:Container(
                                margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Container(
                                    margin:EdgeInsets.fromLTRB(5,0,10,0),
                                    child:Image.asset("assets/images/maggi_brand.png"),
                                  ),
                                ),
                              )
                          ),),
                          Expanded(child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: "Britannia",)),
                                );
                              },
                              child:Container(
                                margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Container(
                                    margin:EdgeInsets.fromLTRB(5,0,5,0),
                                    child:Image.asset("assets/images/britania_brand.png"),
                                  ),
                                ),
                              )
                          ),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: "Dabur",)),
                                );
                              },
                              child:Container(
                                margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Container(
                                    margin:EdgeInsets.fromLTRB(5,0,5,0),
                                    child:Image.asset("assets/images/dabur_brand.png"),
                                  ),
                                ),
                              )
                          ),),
                          Expanded(child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: "Himalaya",)),
                                );
                              },
                              child:Container(
                                margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Container(
                                    margin:EdgeInsets.fromLTRB(5,0,5,0),
                                    child:Image.asset("assets/images/himalaya_brand.png"),
                                  ),
                                ),
                              )
                          ),),
                          Expanded(child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: "Dove",)),
                                );
                              },
                              child:Container(
                                margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Container(
                                    margin:EdgeInsets.fromLTRB(5,0,5,0),
                                    child:Image.asset("assets/images/dove_brand.png"),
                                  ),
                                ),
                              )
                          ),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: "Nestle",)),
                                );
                              },
                              child:Container(
                                margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Container(
                                    margin:EdgeInsets.fromLTRB(5,0,5,0),
                                    child:Image.asset("assets/images/nestle_brand.png"),
                                  ),
                                ),
                              )
                          ),),
                          Expanded(child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: "Emami",)),
                                );
                              },
                              child:Container(
                                margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Container(
                                    margin:EdgeInsets.fromLTRB(5,0,5,0),
                                    child:Image.asset("assets/images/emami_brand.png"),
                                  ),
                                ),
                              )
                          ),),
                          Expanded(child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList(brandName: "Cadbury",)),
                                );
                              },
                              child:Container(
                                margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Container(
                                    margin:EdgeInsets.fromLTRB(5,0,5,0),
                                    child:Image.asset("assets/images/cadbury_brand.png"),
                                  ),
                                ),
                              )
                          ),),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
                Carouselpro3(),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    //image: DecorationImage(
                      //image: AssetImage("assets/images/Household_supplies.jpg"),
                      //fit: BoxFit.fill,
                    //),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height:15,),
                      SizedBox(height: 22,
                        child: Container(
                          alignment: Alignment.center,
                          height: 30.0,
                          child: FittedBox(
                            child: Text(
                              'Household Supplies', style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight:FontWeight.bold),
                            ),
                            ),
                          )
                        ),
                      ),
                      SizedBox(height: 10,),
                      VerticalGrid6(),
                      SizedBox(height:10,),
                    ],
                  ),
                ),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
                Carouselpro4(),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
                SizedBox(height: 22,
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.0,
                    child: FittedBox(
                      child: Text(
                        'Biscuits, Snacks & Beverages', style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight:FontWeight.bold),
                      ),
                      ),
                    )
                  ),
                ),
                SizedBox(height: 10,),
                VerticalGrid7(),
                SizedBox(height: 5,),
                VerticalGrid8(),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                    margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    height: SizeConfig.blockSizeVertical * 25,
                    width: MediaQuery.of(context).size.width,
                    child: Carousel(
                      boxFit: BoxFit.fill,
                      images: [
                        ProgressiveImage(
                          placeholder: AssetImage('assets/images/fade_image.jpg'),
                          // size: 1.87KB
                          thumbnail: NetworkImage('https://www.needzindia.com/Carousels_images/refreshments.jpg'),
                          // size: 1.29MB
                          image: NetworkImage('https://www.needzindia.com/Carousels_images/refreshments.jpg'),
                          height: 300,
                          width: 500,
                        ),
                      ],
                      dotSize: 0.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.lightGreenAccent,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.white.withOpacity(0.10),
                    )),
                SizedBox(height: 5,),
                SizedBox(height: 2,
                  child: Container(
                    color: Colors.cyan[600],
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
            ),)
          ,): Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                    //margin: EdgeInsets.all(10),
                    child: Image.asset('assets/images/Somethingwentwrong.jpeg'),
                  ),
                  Text("Oops you are not connected to internet", style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 20,color: Colors.black,fontWeight:FontWeight.bold),
                  ),textAlign: TextAlign.center,),
                  Container(
                    //color: Colors.cyan[600],
                    margin: EdgeInsets.all(20),
                    height: SizeConfig.blockSizeVertical * 7,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.cyan[600],
                      child: Text('Back to home',style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight:FontWeight.bold),
                      ),),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Homepage()),);
                      },
                    ),
                  )
                ],
              ),
            ),
        ),
    );
  }
}



