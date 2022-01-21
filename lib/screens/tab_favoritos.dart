import 'package:cryper/api/api_interface.dart';
import 'package:cryper/components/coinList.dart';
import 'package:cryper/constantes_app.dart';
import 'package:cryper/models/coin.dart';
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
  List<String> strArr = ['ethereum', 'bitcoin','tether'];

  @override
  void initState() {
    // TODO: implement initState
    ApiInterface().getCoinsList().then((data) {
      setState(() {
        coinlist = data;
      });
    });


    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < coinlist.length; i++) {
      for(var j=0; j < strArr.length;j++) {
        if (coinlist[i].id == strArr[j]) {
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
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
    for(var j=0; j < strArr.length;j++) {
      if (coinlist[i].id == strArr[j]) {
        favoriteCoins.add(coinlist[i]);
      }
    }
  }
}
}