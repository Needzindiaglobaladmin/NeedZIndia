import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;

  PushNotificationService(this._fcm);

  Future initialise() async {
    String token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firebaseToken', token);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.instance.subscribeToTopic("NEEDZ_INDIA_NEWS_LETTER")
        .whenComplete(() => print("success"));
    FirebaseMessaging.instance.subscribeToTopic("NEEDZ_INDIA_Testing")
        .whenComplete(() => print("success"));
  }
}