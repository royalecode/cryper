import 'package:cryper/constantes_app.dart';
import 'package:cryper/controllers/common_controller.dart';
import 'package:cryper/models/coins_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';


class TabLista extends StatefulWidget {
  const TabLista({Key? key}) : super(key: key);

  @override
  _TabLista createState() => _TabLista();
}

class _TabLista extends State<TabLista> {
  
  var searchController = TextEditingController();
  CommonController commonController = Get.find<CommonController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryColor,
    ));
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                          Text(
                            "Cryper",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Top Coins",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: searchController,
                      autofocus: false,
                      style:TextStyle(
                        color: whiteColor.withOpacity(0.5),
                      ),
                      decoration: InputDecoration(
                        suffix: Container(
                          child: Icon(CupertinoIcons.search,color: whiteColor.withOpacity(0.5),),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 12),
                        fillColor: lightColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (val){
                        setState(() {});
                      },
                    ),
                SizedBox(height: 20,),
                    Expanded(
                      child: Obx((){
                        if(commonController.coinsListResponse.value.data == null ) {
                          return Center(child: CircularProgressIndicator(color: whiteColor.withOpacity(0.5),));
                        }

                        if(commonController.coinsListResponse.value.data!.isEmpty ) {
                          return Text("No data found!",style: TextStyle(color: whiteColor.withOpacity(0.5)),);
                        }

                        // return coinList(commonController.coinsListResponse.value.data);
                        return coinList(
                            searchController.text.isEmpty?
                            commonController.coinsListResponse.value.data
                                :commonController.coinsListResponse.value.data!
                                .where((e) => e.name!.toLowerCase().contains(searchController.text.toLowerCase())
                                ||e.symbol!.toLowerCase().contains(searchController.text.toLowerCase()))
                                .toList()
                        );
                      }),
                    )

                  ],
                )
            ),
          )
      ),
    );
  }

  coinList(List<CoinData>? data){

    return ListView(
      children: [
        for(var i=0; i<data!.length;i++)
          InkWell(
            onTap: (){

            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 7),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    child: Text(
                      "${i+1}",
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data[i].name??"N/A",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${data[i].quote!.uSD!.price!.toStringAsFixed(2)}",
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
                              data[i].symbol??"N/A",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "${data[i].quote!.uSD!.percentChange24h!.toStringAsFixed(2)} %",
                              style: TextStyle(
                                color: data[i].quote!.uSD!.percentChange24h!>=0?Colors.green:Colors.red,
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

      ],
    );
  }
}