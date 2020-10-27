
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  LoginResult result ;
  try {
    result = await FacebookAuth.instance.login();
    print("################### $result");
  } catch (e) {
    print("""
    login
    $e
    """);
  }
  // Create a credential from the access token
  FacebookAuthCredential facebookAuthCredential ;
  try {
    facebookAuthCredential =
    FacebookAuthProvider.credential(result.accessToken.token);
    print("################### $facebookAuthCredential");

    } catch (e) {
      print("""
      credential
      $e
      """);
    }

  // Once signed in, return the UserCredential
  UserCredential userFinal ;
    try {
      userFinal = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      print("################### $userFinal");

    } catch (e) {
      print("""
      signInWithCredential
      $e
      """);
    }
  return userFinal;
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  //variables de registro
  FirebaseAuth auth = FirebaseAuth.instance;
  // GoogleSignIn googleAuth = new GoogleSignIn();
  // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
  // FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);
  
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             RaisedButton(
               onPressed: () {
                 signInWithGoogle();
               },
               child: Text("Sign in with Google"),
             ),
             RaisedButton(
               onPressed: () {
                 signInWithFacebook();
               },
               child: Text("Sign in with Facebook"),
             ),
           ],
         ),
       ),
    );
  }
}