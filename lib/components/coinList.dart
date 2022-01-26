import 'package:intl/intl.dart';
import 'package:cryper/coin_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryper/models/coin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constantes_app.dart';

class MyRoute extends MaterialPageRoute {
  MyRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => Duration(seconds: 3);
}

class CoinList extends StatelessWidget {

  final Coin coin;

  bool remove;

  var formatter = NumberFormat('#,###,###.####');

  CoinList({Key? key, required this.coin, required this.remove})
      : super(key: key);

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // showBottomSheetMenu(coin, context);
        Navigator.push(context, _createRoute(CoinDetail(coin: coin)));
        // Navigator.push(context, _createRoute(ChartTest()));
        // Navigator.of(context).push(_createRoute());
        print("coin_name_${coin.id}");
      },
      child: Card(
        elevation: 0,
        color: primaryColor,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(17.5)),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: 32,
                    height: 32,
                    child: Center(child: Image.network(coin.image.toString()))),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Hero(
                              tag: "coin_name_${coin.id}",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  child: Text(
                                    coin.name ?? "N/A",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Hero(
                              tag: "coin_price_${coin.id}",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  "${formatter.format(coin.currentPrice)} \$",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Hero(
                              tag: "coin_symbol_${coin.id}",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  coin.symbol?.toUpperCase() ?? "N/A",
                                  style: Theme.of(context).textTheme.subtitle2,

                              ),
                              ),
                            ),
                          ),
                          Text(
                            "${coin.priceChangePercentage24h! >= 0 ? "+" : ""}${coin.priceChangePercentage24h!.toStringAsFixed(2)}%",
                            style: TextStyle(
                              color: coin.priceChangePercentage24h! > 0
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  showBottomSheetMenu(Coin coin, context) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            height: 150,
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  if (remove == false)
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: primaryColor,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 17),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Add to favorite",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: primaryColor,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 17),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Remove from favorite",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: primaryColor,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 17),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Close",
                          style: TextStyle(
                              color: whiteColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }


  Future<void> appendToArray(String ?coin) async {
    FirebaseFirestore.instance
        .collection('UserData')
        .doc((await FirebaseAuth.instance.currentUser!).uid)
        .update({
            'coins': FieldValue.arrayUnion([coin]),
    });
  }

  Future<void> removeFromArray(String ?coin) async {
    FirebaseFirestore.instance
        .collection('UserData')
        .doc((await FirebaseAuth.instance.currentUser!).uid)
        .update({
      'coins': FieldValue.arrayRemove([coin]),
    });
  }

 /* save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }*/

  }


