import 'package:firebase_messaging/firebase_messaging.dart';
class PushNotificationProvider{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initNotification(){
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((value) {
      print("=========== FCM Token ============");
      print(value);
    });
  }

}