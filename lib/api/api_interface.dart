import 'dart:convert';

import 'package:cryper/models/coin.dart';
import 'package:cryper/models/coins_list_response.dart';
import 'package:get/get.dart';

import '../constantes_app.dart';

import 'package:http/http.dart' as http;

class ApiInterface extends GetConnect{



  Future<List<Coin>> getCoinsList() async {

    final response = await http.get(Uri.parse(apiUrl));


    final jsonData = json.decode(response.body);
    List<Coin> coinList = List<Coin>.from(jsonData.map((x) => Coin.fromJson(x)));

    return coinList;
  }


}