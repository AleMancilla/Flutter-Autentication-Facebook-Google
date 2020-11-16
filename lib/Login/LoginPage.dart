
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_autentication_facebook_google/Pages/HomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_autentication_facebook_google/global.dart';

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
  
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: PreferredSize(
      //   child: AppBarWidget(), 
      //   preferredSize: Size(size.width, size.height*0.3)
      // ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.grey[100],
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height *0.3,
                  child: AppBarWidget(),
                ),
                _botonesLogin(),
                _divisor(),
                _inputField(keybo: TextInputType.emailAddress,label: "Introduzca su correo",icono: Icons.person_outline_outlined,controller: _email),
                _inputField(keybo: TextInputType.visiblePassword,label: "Introduzca su contraseñas",icono: Icons.security,controller: _pass),
                _botonesLoginCorreo(),

              ],
            ),
          )
        ),
      ),
    );
  }
  _divisor(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
      child: Row(
        children: [
          Expanded(child: Container(width: double.infinity, height: 2,color: Colors.grey.withOpacity(0.5),)),
          Text("   OR   ",style: TextStyle(color: Colors.grey.withOpacity(0.6),fontWeight: FontWeight.bold),),
          Expanded(child: Container(width: double.infinity, height: 2,color: Colors.grey.withOpacity(0.5),)),
        ],
      ),
    );
  }

  _botonesLogin(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 15),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                // padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    color: Color.fromRGBO(201,65,48, 1.0),
                    borderRadius: BorderRadius.circular(100),
                    onPressed: () async {
                      UserCredential userCred = await signInWithGoogle();
                      User user = userCred.user;
                      Navigator.pushAndRemoveUntil(
                        context,MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(user: user,)),
                            ModalRoute.withName('/home'),);
                    },
                    child: Text("Google"),
                  ),
                ),
              ),
              Expanded(
                // padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(100),
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      UserCredential userCred = await signInWithFacebook();
                      User user = userCred.user;
                      Navigator.pushAndRemoveUntil(
                        context,MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(user: user,)),
                            ModalRoute.withName('/home'),);
                    },
                    child: Text("Facebook"),
                  ),
                ),
              ),
            ],
          ),
    );
  }


   _botonesLoginCorreo(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 15),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                // padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    padding: EdgeInsets.all(20),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100),
                    onPressed: () async {
                      UserCredential userCred = await signInWithGoogle();
                      User user = userCred.user;
                      Navigator.pushAndRemoveUntil(
                        context,MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(user: user,)),
                            ModalRoute.withName('/home'),);
                    },
                    child: Text("INICIAR SESION"),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  _inputField({String label,TextInputType keybo, IconData icono, TextEditingController controller} ){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Theme(
          data: new ThemeData(
            primaryColor: Colors.orangeAccent,
            primaryColorDark: Colors.orangeAccent,
          ),
        child: TextFormField(
          controller: controller,
                obscureText: keybo != TextInputType.visiblePassword? false:true,
                decoration: new InputDecoration(
                  labelText: "$label",
                  // focusColor: Colors.green,
                  
                  fillColor: Colors.white,
                  prefixIcon: Icon(icono),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Colors.orange
                    ),

                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if(val.length==0) {
                    return "Date cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: keybo,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              workersPrimary,
              workersSecondary,
            ],
            begin: const FractionalOffset(0.0, 0.8),
            end: const FractionalOffset(0.0, -0.3),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight:  Radius.circular(60))
      ),
    );
  }
}