import 'package:cryper/login.dart';
import 'package:cryper/screens/tab_pantalla.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Instance to know the authentication state.
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      //Means that the user is logged in already and hence navigate to HomePage
      return TabScreen();
    }
    //The user isn't logged in and hence navigate to SignInPage.
    return LoginScreen();
  }
}