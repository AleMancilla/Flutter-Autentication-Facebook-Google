
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_autentication_facebook_google/Pages/HomePage.dart';
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
    ${e.toString()}
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
    ${e.toString()}
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
    ${e.toString()}
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
// FirebaseApp defaultApp = await Firebase.initializeApp();
// FirebaseAuth user = FirebaseAuth.instanceFor(app: defaultApp);
// checkIfUserIsSignedIn();

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
         color: Colors.grey[100],
         width: double.infinity,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             FlatButton(
               color: Colors.white,

               shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
               onPressed: () async {
                 UserCredential userCred = await signInWithGoogle();
                 User user = userCred.user;
                 Navigator.pushAndRemoveUntil(
                   context,MaterialPageRoute(
                     builder: (BuildContext context) => HomePage(user: user,)),
                      ModalRoute.withName('/home'),);
               },
               child: Text("Sign in with Google"),
             ),
             FlatButton(
               color: Colors.blue,
               textColor: Colors.white,
               shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
               onPressed: () async {
                 UserCredential userCred = await signInWithFacebook();
                 User user = userCred.user;
                 Navigator.pushAndRemoveUntil(
                   context,MaterialPageRoute(
                     builder: (BuildContext context) => HomePage(user: user,)),
                      ModalRoute.withName('/home'),);
               },
               child: Text("Sign in with Facebook"),
             ),
           ],
         ),
       ),
    );
  }
}