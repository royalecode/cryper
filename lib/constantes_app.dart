// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryper/CustomColorScheme.dart';

var primaryColor = const Color(0xFF191D2D);
var accentColor = const Color(0xFFF77C3F);
var lightColor = const Color(0xFF2A2F45);
var lightBlueColor = const Color(0xFF586AF8);
var greyColor = const Color(0xFF747E98);

TextStyle getHintStyle(BuildContext context) {
  return TextStyle(
      color: Theme.of(context).colorScheme.hint,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      fontFamily: "Inter");
}

TextStyle getFieldStyle(BuildContext context) {
  return TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      fontFamily: "Inter");
}
var hintColor = const Color(0xFFA4A8BD);
var whiteColor = const Color(0xFFffffff);

var apiKey = "04ff1915-d61a-4194-ba40-54013bc63d8a";
String apiUrl =
    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
