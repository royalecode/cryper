import 'package:cryper/constantes_app.dart';
import 'package:cryper/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TabPerfil extends StatefulWidget {
  const TabPerfil({Key? key}) : super(key: key);

  @override
  _TabPerfil createState() => _TabPerfil();
}

class _TabPerfil extends State<TabPerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: const Text('Sign out'),
            onPressed: () {
              _signOut();
            },
          ),
      ),

      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    //print(FirebaseAuth.instance.currentUser?.email);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}