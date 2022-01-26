import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryper/api/api_interface.dart';
import 'package:cryper/components/coinList.dart';
import 'package:cryper/constantes_app.dart';
import 'package:cryper/models/coin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';


class TabFavoritos extends StatefulWidget {

  const TabFavoritos({Key? key,}) : super(key: key);

  @override
  _TabFavoritos createState() => _TabFavoritos();
}

class _TabFavoritos extends State<TabFavoritos> {

  List<Coin> coinlist = [];

  List<Coin> favoriteCoins = [];

  List<String> _strArr = [];

  @override
  void initState() {
    // TODO: implement initState
    ApiInterface().getCoinsList().then((data) {
      setState(() {
        coinlist = data;
      });
    });

    print('hola aqui la moneda si es favorite o no');
    print(_checkIsFavorite("cardano"));
    _checkIsFavorite("bitcoin").then((value) => print(value));
    _getUserFavoriteCoins();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < coinlist.length; i++) {
      for(var j=0; j < _strArr.length;j++) {
        if (coinlist[i].id == _strArr[j]) {
          favoriteCoins.add(coinlist[i]);
        }
      }
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryColor,
    ));
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: 25,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/logoCryper.svg",width: 35,height: 35,),
                        SizedBox(width: 5,),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Your Coins",
                        style: Theme.of(context).textTheme.headline2,
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: favoriteCoins.length,
                        itemBuilder: (context, index) {
                          return CoinList(
                              coin: favoriteCoins[index],remove: true,);
                        }),
                  ),
                ],
              )
          ),
        )
    );
  }
void compareCoinsAndAddToFavorites(){
  for (var i = 0; i < coinlist.length; i++) {
    for(var j=0; j < _strArr.length;j++) {
      if (coinlist[i].id == _strArr[j]) {
        favoriteCoins.add(coinlist[i]);
      }
    }
  }
}

  Future<void> _getUserFavoriteCoins() async {
    FirebaseFirestore.instance
        .collection('UserData')
        .doc((await FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {
          _strArr = List<String>.from(value.data()!["coins"]);
      });
    });
  }

  Future<bool> _checkIsFavorite(String ?coin) async {
     bool exists = false;
     await FirebaseFirestore.instance
        .collection('UserData')
        .doc((await FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
            if (List<String>.from(value.data()!["coins"]).contains(coin)) {
              exists = true;
            }
    });
    return Future<bool>.value(exists);
  }
}