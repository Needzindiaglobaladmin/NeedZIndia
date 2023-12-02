import 'dart:async';
import 'package:NeedZIndia/Categories/Services/PanCard.dart';
import 'package:NeedZIndia/Categories/Services/Passport.dart';
import 'package:NeedZIndia/ProductListNotifier.dart';
import 'package:NeedZIndia/UserDataNotifier.dart';
import 'package:NeedZIndia/Screen/AddAddress.dart';
import 'package:NeedZIndia/Screen/MyAddress.dart';
import 'package:NeedZIndia/Screen/MyAccount.dart';
import 'package:NeedZIndia/bloc_cartvalue.dart';
import 'package:NeedZIndia/PushNotificationsManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NeedZIndia/Homepage/Homepage.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:NeedZIndia/screen/Login.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_){
    runApp(MyApp());
  }
  );
}

class MyApp extends StatelessWidget {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig();
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => CartValue()),
                ChangeNotifierProvider(create: (context) => ProductListNotifier()),
                ChangeNotifierProvider(create: (context) => UserDataNotifier()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(accentColor:  Colors.cyan[600],),
                title: 'NeedZ India',
                home: SplashScreen(),
                routes: {
                  '/main': (context) => Homepage(),
                  '/other': (context) => Login(),
                  '/showaddress':(context) => MyAddress(),
                  '/add_address':(context) => AddAddress(),
                  'pancard':(context) => PanCard(),
                  'passport':(context) => Passport(),
                  'account':(context) => MyAccount(),
                },
                builder: (BuildContext context, Widget widget) {
                  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                    return buildError(context, errorDetails);
                  };

                  return widget;
                },
              ),
            );
          },
        );
      },
    );
  }
}
Widget buildError(BuildContext context, FlutterErrorDetails error) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100,),
              Flexible(
                  child: Container(
                    //margin: EdgeInsets.all(10),
                    child: Image.asset('assets/images/No_internet.png'),
                  ),
              ),
              Text("Something Went Wrong", style: GoogleFonts.quicksand(
                textStyle: TextStyle(fontSize: 20,color: Colors.black,fontWeight:FontWeight.bold),
              ),),
            ],
          ),
        )
    )
  );
}

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.cyan[600],
      body: Container(
        child: Center(
          child: new Column(children: <Widget>[
            Flexible(child: SizedBox(height: 200),),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 120,),
                  new Image.asset(
                    'assets/images/logo.ico',
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                    width: 170.0,
                  ),
                  SizedBox(height: 10,),
                ],
              )
            ),
            Flexible(child: SizedBox(height: 230),),
            Flexible(
              child: Container(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
              ),),
          ]),),
      ),
    );
  }
}















