import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryper/home.dart';
import 'package:cryper/screens/login.dart';
import 'package:cryper/screens/tab_pantalla.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  final String text, name, email, password;
  final bool newUser;

  MainButton(
      {Key? key,
      required this.text,
      required this.name,
      required this.email,
      required this.password,
      required this.newUser})
      : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<MainButton> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xFF586AF8),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            textStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        onPressed: () async {
          if (widget.newUser) {
            auth.createUserWithEmailAndPassword(
                email: widget.email, password: widget.password);
            User? user = await auth.currentUser;
            print(user?.uid);
            print(widget.email);
            print(widget.name);

            DocumentReference ref = FirebaseFirestore.instance
                .collection('UserData')
                .doc(user?.uid);
            ref.set({"name": widget.name, "email": widget.email});
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TabScreen()));
          } else {
            auth.signInWithEmailAndPassword(
                email: widget.email, password: widget.password);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TabScreen()));
          }
        },
        child: Text(widget.text),
      ),
    ));
  }
}
