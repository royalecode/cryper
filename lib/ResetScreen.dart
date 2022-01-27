import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constantes_app.dart';

class ResetScreen extends StatelessWidget {
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF191D2D),
        body: Container(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 80, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.arrow_back),
                              padding: EdgeInsets.fromLTRB(0,0,15,0),
                              constraints: BoxConstraints(),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          const Text(
                            'Password reset',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ]),
                        const SizedBox(height: 15),
                        const Text(
                          'If you have forgotten your password you can reset it here.',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          style: fieldStyle,
                          obscureText: false,
                          decoration: InputDecoration(
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
                            _email = value;
                          },
                        ),
                        const SizedBox(height: 25),
                        Container(
                            child: SizedBox(
                              height: 44,
                              width: double.maxFinite,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF586AF8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0),
                                    ),
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  if (_email != '') {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(email: _email);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text('Send email'),
                              ),
                            )),
                      ],
                    )))));
  }
}
