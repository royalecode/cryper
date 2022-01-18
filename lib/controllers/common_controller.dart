import 'package:cryper/models/coins_list_response.dart';
import 'package:get/get.dart';

class CommonController extends GetxController{


  Rx<CoinListResponse> coinsListResponse = CoinListResponse().obs;
  Rx<List<CoinData>> favCoinsList = RxList<CoinData>().obs;
  Rx<List<int?>> favCoinsId = RxList<int?>().obs;
}