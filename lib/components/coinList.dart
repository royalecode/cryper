
import 'package:cryper/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constantes_app.dart';


class CoinList extends StatelessWidget {

  final Coin coin;

  CoinList({Key? key, required this.coin}) : super(key: key);

  Widget build(BuildContext context) {

    return GestureDetector(onTap: (){
      print(coin.name);
    }, child: Card ( color: primaryColor,child: Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 7),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.network(coin.image.toString())
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              coin.name??"N/A",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$"+coin.currentPrice.toString(),
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              coin.symbol??"N/A",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              coin.priceChangePercentage24h.toString()+"%",
                              style: TextStyle(
                                color:  coin.priceChangePercentage24h!>0?Colors.green:Colors.red,
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
    ),
    ),
    );
  }
}
