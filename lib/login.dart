import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User user) async {
      if (user != null) await loggedInScreenTransition();
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn(scopes: [
      'email',
    ]).signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user != null) await loggedInScreenTransition();
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 70),
            SizedBox(
              width: 150,
              child: Image.asset('assets/splash.png'),
            ),
            Container(height: 60),
            SignInButton(
              Buttons.Apple,
              onPressed: () {},
            ),
            Container(height: 10),
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                try {
                  await signInWithGoogle();
                  await loggedInScreenTransition();
                } on FirebaseAuthException catch (e) {
                  print('FirebaseAuthException');
                  print('${e.code}');
                } on Exception catch (e) {
                  print('Exception');
                  print('${e.toString()}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loggedInScreenTransition() async {
    final doc = await FirebaseFirestore.instance
        .collection('members')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    if (doc.data() != null)
      Navigator.pushReplacementNamed(context, '/home');
    else
      Navigator.pushReplacementNamed(context, '/register');
  }
}
