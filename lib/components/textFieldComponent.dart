import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  String textHint;
  bool obscureText, nextOrDone;
  final Function callback, checkInput;

  TextFieldComponent(
      {Key? key,
      required this.textHint,
      required this.obscureText,
      required this.nextOrDone,
      required this.callback,
      required this.checkInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (nextOrDone) {
      return TextField(
          textInputAction: TextInputAction.next,
          style: TextStyle(color: Colors.white),
          obscureText: obscureText,
          decoration: InputDecoration(
            //errorText: isEmail(_email),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Color(0xFF2A2F45),
            border: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none,
              //borderSide: const BorderSide(),
            ),
            hintText: textHint,
            hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (value) {
          },
          );
    } else {
      return TextField(
          textInputAction: TextInputAction.done,
          style: TextStyle(color: Colors.white),
          obscureText: obscureText,
          decoration: InputDecoration(
            //errorText: isEmail(_email),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Color(0xFF2A2F45),
            border: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none,
              //borderSide: const BorderSide(),
            ),
            hintText: textHint,
            hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (value) {
          },
      );
    }
  }
}
