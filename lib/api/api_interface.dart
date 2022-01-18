import 'dart:convert';

import 'package:cryper/controllers/common_controller.dart';
import 'package:cryper/models/coin.dart';
import 'package:cryper/models/coins_list_response.dart';
import 'package:get/get.dart';

import '../constantes_app.dart';

import 'package:http/http.dart' as http;

class ApiInterface extends GetConnect{



  Future<int> getCoinsList() async {

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {


      final jsonData = json.decode(response.body);
      List<Coin> conList = List<Coin>.from(jsonData.map((x) => Coin.fromJson(x)));
      print(conList[1].name);


     return 200;
    } else {
      print("MAL");
      Get.back();
      return 400;
    }
  }


}