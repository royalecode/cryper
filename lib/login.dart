// ignore_for_file: prefer_const_constructors

import 'package:cryper/components/mainButton.dart';
import 'package:cryper/constantes_app.dart';
import 'package:cryper/register.dart';
import 'package:cryper/screens/tab_pantalla.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;
  String _email = '', _password = '', errorMessage = '';
  bool checkEmail = false, _errorBool = false;

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
        backgroundColor: Color(0xFF191D2D),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset("assets/images/logoCryper.svg"),
                            const SizedBox(height: 50),
                            TextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                style: fieldStyle,
                                obscureText: false,
                                decoration: InputDecoration(
                                  errorText: isEmail(_email),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  filled: true,
                                  fillColor: Color(0xFF2A2F45),
                                  border: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide.none,
                                    //borderSide: const BorderSide(),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: hintStyle,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _email = value.trim();
                                  });
                                }),
                            const SizedBox(height: 20),
                            TextField(
                                textInputAction: TextInputAction.done,
                                style: fieldStyle,
                                obscureText: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    filled: true,
                                    fillColor: Color(0xFF2A2F45),
                                    border: OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none,
                                      //borderSide: const BorderSide(),
                                    ),
                                    hintText: "Password",
                                    hintStyle: hintStyle),
                                onChanged: (value) {
                                  setState(() {
                                    _password = value.trim();
                                  });
                                }),
                            const SizedBox(height: 20),
                            Visibility(
                              visible: _errorBool,
                              child: Text(
                                errorMessage,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.red),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                                child: SizedBox(
                                  height: 44,
                              width: double.maxFinite,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF586AF8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  loginAction();
                                },
                                child: Text('Login'),
                              ),
                            )),
                            const SizedBox(height: 30),
                            const Text(
                              "Don't have an account?",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  ctxt,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: const Text(
                                "Register",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF586AF8)),
                              ),
                            )
                          ],
                        ))))));
  }

  String? isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    if (!regExp.hasMatch(em) && em.isNotEmpty) {
      checkEmail = false;
      return "Email format is not valid";
    } else {
      checkEmail = true;
    }
    return null;
  }

  void loginAction() async {
    if (checkEmail) {
      try {
        await auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        setState(() {
          _errorBool = true;
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => TabScreen()));
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "wrong-password":
            print('hey hey pwd incorrect');
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            print('user not found hey hey');
            errorMessage = "User with this email doesn't exist.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        setState(() {
          _errorBool = true;
        });
      }
    } else {
      setState(() {
        errorMessage = "Email format is not valid";
        _errorBool = true;
      });
    }
  }
}
