// ignore_for_file: prefer_const_constructors

import 'package:cryper/ResetScreen.dart';
import 'package:cryper/CustomColorScheme.dart';
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
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              Theme.of(context).brightness == Brightness.light
                                  ? "assets/images/logoCryperLight.svg"
                                  : "assets/images/logoCryper.svg",
                            ),
                            const SizedBox(height: 50),
                            TextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                style: getFieldStyle(context),
                                obscureText: false,
                                decoration: InputDecoration(
                                  errorText: isEmail(_email),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  filled: true,
                                  fillColor: Theme.of(context).colorScheme.fieldBackground,
                                  border: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide.none,
                                    //borderSide: const BorderSide(),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: getHintStyle(context),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _email = value.trim();
                                  });
                                }),
                            const SizedBox(height: 20),
                            TextField(
                                textInputAction: TextInputAction.done,
                                style: getFieldStyle(context),
                                obscureText: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    filled: true,
                                    fillColor: Theme.of(context).colorScheme.fieldBackground,
                                    border: OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none,
                                      //borderSide: const BorderSide(),
                                    ),
                                    hintText: "Password",
                                    hintStyle: getHintStyle(context)),
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
                                    primary:
                                        Theme.of(context).colorScheme.primary,
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
                            const SizedBox(height: 20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        ctxt,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()),
                                      );
                                    },
                                    child: Text(
                                      "Register now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        ctxt,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetScreen()),
                                      );
                                    },
                                    child: Text(
                                      "Forgot password?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.onBackground),
                                    ),
                                  ),
                                ])
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
