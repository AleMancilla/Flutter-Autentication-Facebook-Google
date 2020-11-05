import 'package:firebase_messaging/firebase_messaging.dart';
class PushNotificationProvider{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initNotification(){
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((value) {
      print("=========== FCM Token ============");
      print(value);
    });


    _firebaseMessaging.configure(
      onMessage: (info){
        print("========= on mesage ========");
        print(info);
      },
      onLaunch: (info){
        print("========= on onLaunch ========");
        print(info);
      },
      onResume: (info){
        print("========= on onResume ========");
        print(info);
      }
    );
  }

}

//dc98Su96R12xiY5WzMXr_S:APA91bE7-VBW8W1JblsbF5ER5ZMV6iNjt4HOTa1yheoQEX7GPDWUHcD_M6sPCoDkVeq5Qhnb3f7vlICljE5Me7Zo7SeDHFSdZewmbURKyE-NEog7TAfuIN0csDxkA-sAhpLKNufVkTSh