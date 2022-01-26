import 'package:cryper/api/api_interface.dart';
import 'package:cryper/components/coinList.dart';
import 'package:cryper/constantes_app.dart';
import 'package:cryper/models/coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';


class TabLista extends StatefulWidget {




  const TabLista({Key? key}) : super(key: key);

  @override
  _TabLista createState() => _TabLista();
}

class _TabLista extends State<TabLista> {
  
  var searchController = TextEditingController();
  List<Coin> coinsSearchList = [];
  List<Coin> coinlist = [];

  void updateCoinList(String val) {
    coinsSearchList.clear();

    coinlist.forEach((coin) {
      if (coin.name!.toLowerCase().contains(val.toLowerCase())) {
        coinsSearchList.add(coin);
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    ApiInterface().getCoinsList().then((data) {
      setState(() {
        coinlist = data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

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
                          Hero(
                            tag: "logo",
                            child: SvgPicture.asset(
                              "assets/images/logoCryper.svg",
                              width: 35,
                              height: 35,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Top Coins",
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: searchController,
                      autofocus: false,
                      textAlignVertical: TextAlignVertical.center,
                      style:TextStyle(
                        color: whiteColor.withOpacity(0.5),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search by name',
                        hintStyle: TextStyle(color: whiteColor.withOpacity(0.5)),
                        suffixIcon: Icon(CupertinoIcons.search,color: whiteColor.withOpacity(0.5)),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 12),
                        fillColor: lightColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (val){
                        updateCoinList(val);
                      },
                    ),
                SizedBox(height: 15,),
                        Expanded(
                          child:
                          coinsSearchList.length != 0 ||
                              searchController.text.isNotEmpty
                              ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: coinsSearchList.length,
                              itemBuilder: (context, index) {
                                return CoinList(
                                  coin: coinsSearchList[index], remove: false,);
                              })
                              : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: coinlist.length,
                              itemBuilder: (context, index) {
                                return CoinList(
                                  coin: coinlist[index], remove: false,);
                              }),
                        ),

                  ],
                )
            ),
          )
      );
  }


}