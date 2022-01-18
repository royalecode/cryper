import 'package:cryper/components/mainButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _name = '', _email = '', _password = '', _confirmPassword = '';

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
                                style: TextStyle(color: Colors.white),
                                obscureText: false,
                                decoration: const InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                    filled: true,
                                    fillColor: Color(0xFF2A2F45),
                                    border: OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none,
                                      //borderSide: const BorderSide(),
                                    ),
                                    hintText: 'Name',
                                    hintStyle: TextStyle(color: Colors.white)),
                                onChanged: (value) {
                                  setState(() {
                                    _name = value.trim();
                                  });
                                }),
                            const SizedBox(height: 20),
                            TextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                obscureText: false,
                                decoration: InputDecoration(
                                    errorText: isEmail(_email),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                    filled: true,
                                    fillColor: Color(0xFF2A2F45),
                                    border: const OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none,
                                      //borderSide: const BorderSide(),
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.white)),
                                onChanged: (value) {
                                  setState(() {
                                    _email = value.trim();
                                  });
                                }),
                            const SizedBox(height: 20),
                            TextField(
                                textInputAction: TextInputAction.next,
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: InputDecoration(
                                    errorText: validatePassword(_password),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                    filled: true,
                                    fillColor: Color(0xFF2A2F45),
                                    border: const OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none,
                                      //borderSide: const BorderSide(),
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.white)),
                                onChanged: (value) {
                                  setState(() {
                                    _password = value.trim();
                                  });
                                }),
                            const SizedBox(height: 20),
                            TextField(
                                textInputAction: TextInputAction.done,
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: InputDecoration(
                                    errorText: confirmPassword(_confirmPassword),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                    filled: true,
                                    fillColor: Color(0xFF2A2F45),
                                    border: const OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none,
                                      //borderSide: const BorderSide(),
                                    ),
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.white)),
                                onChanged: (value) {
                                  setState(() {
                                    _confirmPassword = value.trim();
                                  });
                                }),
                            const SizedBox(height: 30),
                            MainButton(
                              text: 'Register',
                              name: _name,
                              email: _email,
                              password: _password,
                              newUser: true,
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "Have an account?",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctxt);
                              },
                              child: const Text(
                                "Login",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF586AF8)),
                              ),
                            )
                          ],
                        ))))));
  }

  String? validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }

  String? confirmPassword(String value) {
    if (_confirmPassword != _password && _confirmPassword.isNotEmpty) {
      return "Confirm password must be the same as previous password";
    }
    return null;
  }

  String? isEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    if (!regExp.hasMatch(em) && em.isNotEmpty) {
      return "Email format is not valid";
    }
    return null;
  }
}
