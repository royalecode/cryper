import 'dart:convert';
import 'package:cryper/models/coin.dart';
import '../constantes_app.dart';
import 'package:http/http.dart' as http;
import 'package:cryper/coin_detail.dart';

class ApiInterface {
  Future<List<Coin>> getCoinsList() async {
    final response = await http.get(Uri.parse(apiUrl));
    final jsonData = json.decode(response.body);
    List<Coin> coinList =
        List<Coin>.from(jsonData.map((x) => Coin.fromJson(x)));
    return coinList;
  }

  Future<String> getCoinsDescription(String id) async {
    print("https://api.coingecko.com/api/v3/coins/$id");
    final response =
        await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/$id"));
    final jsonData = json.decode(response.body);
    return jsonData["description"]["en"];
  }

  Future<List> getCoinsChart(String id, int selectedTime,
      [String currency = "USD"]) async {
    String days = _getDays(selectedTime);
    String request = "";
    request = "https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=$currency&days=$days";
    // request = "https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=$currency&days=$days&interval=daily";
    final response =
        await http.get(Uri.parse(request));
    final jsonData = json.decode(response.body);
    return jsonData["prices"];
  }

  String _getDays(int selectedTime) {
    if (selectedTime == TIME_1H) {
      return "1";
    }
    if (selectedTime == TIME_1D) {
      return "1";
    }
    if (selectedTime == TIME_1W) {
      return "7";
    }
    if (selectedTime == TIME_1M) {
      return "30";
    }
    if (selectedTime == TIME_1Y) {
      return "365";
    }
    return "max";
  }
}
