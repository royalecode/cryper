import 'package:cryper/api/api_interface.dart';
import 'package:cryper/components/PriceChart.dart';
import 'package:cryper/components/mainButton.dart';
import 'package:cryper/constantes_app.dart';
import 'package:cryper/models/coin.dart';
import 'package:cryper/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:html/parser.dart';

const int TIME_1H = 1;
const int TIME_1D = 2;
const int TIME_1W = 3;
const int TIME_1M = 4;
const int TIME_1Y = 5;
const int TIME_ALL = 6;

class CoinDetail extends StatefulWidget {
  final Coin coin;

  CoinDetail({required this.coin});

  @override
  _CoinDetail createState() => _CoinDetail(coin: this.coin);
}

class _CoinDetail extends State<CoinDetail> {
  String coinName = "hola";
  String coinDesc = "";
  int selectedTime = TIME_1D;
  bool loadedAbout = false;
  bool loadedChart = false;
  late TrackballBehavior _trackballBehavior;
  final Coin coin;
  var formatter = NumberFormat('#,###,###.####');
  List dataDay = [];
  List dataWeek = [];
  List dataMonth = [];
  List dataYear = [];
  List dataAll = [];
  List<_PriceData> data = [];

  void updateData(List data, int time) {
    setState(() {
      selectedTime = time;
      this.data = data
          .map((e) =>
              _PriceData(DateTime.fromMicrosecondsSinceEpoch(e[0]), e[1]))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    ApiInterface().getCoinsDescription(coin.id!).then((data) {
      setState(() {
        coinDesc = _parseHtmlString(data);
        loadedAbout = true;
      });
    });

    ApiInterface().getCoinsChart(coin.id!, TIME_1D).then((data) {
      setState(() {
        dataDay = data;
        updateData(dataDay, TIME_1D);
        loadedChart = true;
      });
    });

    ApiInterface().getCoinsChart(coin.id!, TIME_1W).then((data) {
      dataWeek = data;
      setState(() {});
    });

    ApiInterface().getCoinsChart(coin.id!, TIME_1M).then((data) {
      dataMonth = data;
      setState(() {});
    });

    ApiInterface().getCoinsChart(coin.id!, TIME_1Y).then((data) {
      dataYear = data;
      setState(() {});
    });

    ApiInterface().getCoinsChart(coin.id!, TIME_ALL).then((data) {
      dataAll = data;
      setState(() {});
    });
  }

  _CoinDetail({required this.coin});

  TextStyle getStyle(int timeId) {
    return TextStyle(
      color: timeId == selectedTime ? accentColor : Colors.white,
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191D2D),
      // backgroundColor: Color(0xFF000000),
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: Expanded(
              flex: 0,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                        icon: Icon(Icons.arrow_back)),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: !loadedAbout || !loadedChart
                ? Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 15, right: 12),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Hero(
                                tag: "coin_name_${coin.id}",
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Container(
                                    child: Text(
                                      '${coin.name}',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 3.0, left: 7),
                                child: Hero(
                                  tag: "coin_symbol_${coin.id}",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      coin.symbol?.toUpperCase() ?? "N/A",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ),
                      //COIN PRICE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0, left: 15, right: 12),
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 1000),
                                child: Hero(
                                  tag: "coin_price_${coin.id}",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                        "${formatter.format(coin.currentPrice)} \$",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 200),
                              child: CircularProgressIndicator(),
                            )
                          ],
                        ),
                      )
                      //COIN CHART & ABOUT
                    ],
                  )
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 15, right: 12),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Hero(
                                  tag: "coin_name_${coin.id}",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Container(
                                      child: Text(
                                        '${coin.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 3.0, left: 7),
                                  child: Hero(
                                    tag: "coin_symbol_${coin.id}",
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Text(
                                        coin.symbol?.toUpperCase() ?? "N/A",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        //COIN PRICE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 15, right: 12),
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 1000),
                                  child: Hero(
                                    tag: "coin_price_${coin.id}",
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Text(
                                          "${formatter.format(coin.currentPrice)} \$",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //COIN CHART & ABOUT
                        Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    child: SfCartesianChart(
                                        trackballBehavior: TrackballBehavior(
                                          builder: (BuildContext context,
                                              TrackballDetails
                                                  trackballDetails) {
                                            return Text(
                                              "${trackballDetails.point?.y}",
                                              style: TextStyle(
                                                fontSize: 0,
                                              ),
                                            );
                                          },
                                          // Enables the trackball
                                          enable: true,
                                          activationMode:
                                              ActivationMode.singleTap,
                                          tooltipSettings: InteractiveTooltip(
                                              enable: true,
                                              color: Color(0x00FFFFFF),
                                              borderColor: Color(0x00FFFFFF)),
                                          lineColor: Color(0x30FFFFFF),
                                          lineDashArray: [6, 4],
                                          lineWidth: 2,
                                        ),
                                        margin: EdgeInsets.all(0),
                                        plotAreaBorderWidth: 0,
                                        primaryXAxis: DateTimeAxis(
                                          isVisible: false,
                                        ),
                                        primaryYAxis: NumericAxis(
                                            isVisible: false, borderWidth: 0),
                                        tooltipBehavior:
                                            TooltipBehavior(enable: true),
                                        series: <
                                            ChartSeries<_PriceData, DateTime>>[
                                          AreaSeries<_PriceData, DateTime>(
                                              enableTooltip: false,
                                              borderColor: accentColor,
                                              borderWidth: 2.5,
                                              animationDelay: 200,
                                              animationDuration: 700,
                                              gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: <Color>[
                                                  Color(0x22F77C3F),
                                                  Color(0x00000000)
                                                ],
                                              ),
                                              dataSource: data,
                                              xValueMapper:
                                                  (_PriceData price, _) =>
                                                      price.date,
                                              yValueMapper:
                                                  (_PriceData price, _) =>
                                                      price.price,
                                              name: 'Price',
                                              // Enable data label
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                      isVisible: false))
                                        ]),
                                  ),
                                ),
                                Padding(
                                  //padding: const EdgeInsets.only(right: 12, left: 12, bottom: 15),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              minimumSize: Size(40, 30),
                                              padding: EdgeInsets.zero),
                                          onPressed: () {
                                            updateData(dataDay, TIME_1D);
                                          },
                                          child: Text("1D",
                                              style: getStyle(TIME_1D))),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              minimumSize: Size(40, 30),
                                              padding: EdgeInsets.zero),
                                          onPressed: () {
                                            updateData(dataWeek, TIME_1W);
                                          },
                                          child: Text("1W",
                                              style: getStyle(TIME_1W))),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              minimumSize: Size(40, 30),
                                              padding: EdgeInsets.zero),
                                          onPressed: () {
                                            updateData(dataMonth, TIME_1M);
                                          },
                                          child: Text("1M",
                                              style: getStyle(TIME_1M))),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              minimumSize: Size(40, 30),
                                              padding: EdgeInsets.zero),
                                          onPressed: () {
                                            updateData(dataYear, TIME_1Y);
                                          },
                                          child: Text("1Y",
                                              style: getStyle(TIME_1Y))),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              minimumSize: Size(40, 30),
                                              padding: EdgeInsets.zero),
                                          onPressed: () {
                                            updateData(dataAll, TIME_ALL);
                                          },
                                          child: Text("All",
                                              style: getStyle(TIME_ALL))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            //COIN ABOUT
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0, left: 12, right: 12),
                              child: Column(
                                children: [

                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8,),
                                        child: Text(
                                          "About ${coin.name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 15),
                                          child: ReadMoreText(
                                            coinDesc,
                                            trimMode: TrimMode.Line,
                                            trimLines: 5,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            textAlign: TextAlign.justify,
                                            lessStyle: TextStyle(color: lightBlueColor),
                                            moreStyle: TextStyle(color: lightBlueColor),
                                            trimCollapsedText: "...read more",
                                            trimExpandedText: "Show less",
                                            delimiter: " ",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10, top: 10),
                                        child: Text(
                                          "${coin.name} stats",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      )
                                    ],
                                  ),
                                  StatRow(
                                      label: "Market cap",
                                      value: formatNumber(coin.marketCap),
                                      iconData: Icons.equalizer),
                                  StatRow(
                                      label: "Volume",
                                      value: formatNumber(coin.totalVolume),
                                      iconData: Icons.bubble_chart),
                                  StatRow(
                                      label: "Circulating supply",
                                      value:
                                          formatNumber(coin.circulatingSupply),
                                      iconData: Icons.data_usage),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: StatRow(
                                        label: "Popularity",
                                        value: "#${coin.marketCapRank}",
                                        iconData: Icons.auto_awesome),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
          Expanded(
              flex: 0,
              child: Column(
                children: [
                  Container(
                    height: 85,
                    color: lightColor,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 30, right: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            print("-");
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF586AF8),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              textStyle: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          child: Text("Follow"),
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

//here goes the function
String _parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body?.text).documentElement!.text;

  return parsedString;
}

class _PriceData {
  _PriceData(this.date, this.price);

  final DateTime date;
  final double price;
}
