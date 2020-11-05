import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_autentication_facebook_google/Login/LoginPage.dart';
import 'package:flutter_autentication_facebook_google/Pages/HomePage.dart';
import 'package:page_transition/page_transition.dart';

// enum SplashTransition {
//   slideTransition,
//   scaleTransition,
//   rotationTransition,
//   sizeTransition,
//   fadeTransition,
//   decoratedBoxTransition
// }

class SplashScreen extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: 'assets/images/starlab.jpg',
      duration: 2500,
      screenFunction: () async{
        print("###############");
        print(auth);
        print(auth.currentUser);
        print("#############33");
        if(auth.currentUser!=null){
          return HomePage(user: auth.currentUser,);
        }else{
          return LoginPage();
        }
      },
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.scale,
    );
  }
}