import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryper/models/coin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constantes_app.dart';


class CoinList extends StatelessWidget {

  final Coin coin;

  bool remove;

  CoinList({Key? key, required this.coin,required this.remove}) : super(key: key);

  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      showBottomSheetMenu(coin, context);
    }, child: Card(color: primaryColor, child: Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
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
                      coin.name ?? "N/A",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$" + coin.currentPrice.toString(),
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
                      coin.symbol ?? "N/A",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      coin.priceChangePercentage24h.toString() + "%",
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
        ],
      ),
    ),
    ),
    );
  }


  showBottomSheetMenu(Coin coin, context) {
    showModalBottomSheet<void>(context: context, backgroundColor:  Colors.transparent, builder: (BuildContext context){
      return Container(
        padding:EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        height: 150,
        color: Colors.transparent,
        child: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              SizedBox(height: 10,),
              if (remove == false)
                InkWell(
                  onTap: (){
                    appendToArray(coin.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      color: primaryColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 17),
                    width: double.infinity,
                    child: Center(
                      child: Text("Add to favorite",style: TextStyle(color: whiteColor,fontSize: 14,fontWeight: FontWeight.bold),),
                    ),
                  ),
                )
               else
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      color: primaryColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 17),
                    width: double.infinity,
                    child: Center(
                      child: Text("Remove from favorite",style: TextStyle(color: whiteColor,fontSize: 14,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),


              InkWell(
                onTap: (){
                  appendToArray("cardano");
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                    color: primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 17),
                  width: double.infinity,
                  child: Center(
                    child: Text("Close",style: TextStyle(color: whiteColor,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              SizedBox(height: 10,),
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

 /* save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }*/

  }


