import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "package:covid_india_tracker/models/data_api.dart";
import 'package:syncfusion_flutter_charts/charts.dart';

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();

class DailyNewCases {
  final int dailyNewCases;
  final int dailyNewRecovered;
  final int dailyNewDeaths;
  final String date;

  DailyNewCases(
      {@required this.dailyNewCases,
      @required this.date,
      @required this.dailyNewDeaths,
      @required this.dailyNewRecovered});
}

class TotalCases {
  final int totalConfirmed;
  final int totalRecovered;
  final int totalDeaths;
  final String date;

  TotalCases(
      {@required this.totalConfirmed,
      @required this.date,
      @required this.totalDeaths,
      @required this.totalRecovered});
}

class SpreadTrends extends StatefulWidget {
  _SpreadTrendsState createState() => _SpreadTrendsState();
}

class _SpreadTrendsState extends State<SpreadTrends> {
  Future<CovidIndia> statsGraphs;

  Future<CovidIndia> getGraphData() {
    return _covidIndiaStats.getStats();
  }

  @override
  void initState() {
    super.initState();
    statsGraphs = getGraphData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff212F3D),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xff17202a),
          title: Text(
            "Spread Trends",
            style: GoogleFonts.montserrat(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  setState(() {
                    statsGraphs = getGraphData();
                  });
                })
          ],
        ),
        body: FutureBuilder(
          future: statsGraphs,
          builder:
              (BuildContext context, AsyncSnapshot<CovidIndia> statsSnapshot) {
            if (statsSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final int length = statsSnapshot.data.casesTimeSeries.length;

            final List<DailyNewCases> dailyStats = List.generate(
              30,
              (index) => DailyNewCases(
                  dailyNewCases: int.parse(statsSnapshot.data
                      .casesTimeSeries[(length - 30) + index].dailyconfirmed),
                  dailyNewDeaths: int.parse(statsSnapshot.data
                      .casesTimeSeries[(length - 30) + index].dailydeceased),
                  dailyNewRecovered: int.parse(statsSnapshot.data
                      .casesTimeSeries[(length - 30) + index].dailyrecovered),
                  date: statsSnapshot
                      .data.casesTimeSeries[(length - 30) + index].date),
            );

            final List<TotalCases> totalStats = List.generate(
              30,
              (index) => TotalCases(
                  totalConfirmed: int.parse(statsSnapshot.data
                      .casesTimeSeries[(length - 30) + index].totalconfirmed),
                  totalDeaths: int.parse(statsSnapshot.data
                      .casesTimeSeries[(length - 30) + index].totaldeceased),
                  totalRecovered: int.parse(statsSnapshot.data
                      .casesTimeSeries[(length - 30) + index].totalrecovered),
                  date: statsSnapshot
                      .data.casesTimeSeries[(length - 30) + index].date),
            );

            List<ColumnSeries<DailyNewCases, String>> seriesDNC = [
              ColumnSeries<DailyNewCases, String>(
                  dataSource: dailyStats,
                  xValueMapper: (DailyNewCases series, _) => series.date,
                  yValueMapper: (DailyNewCases series, _) =>
                      series.dailyNewCases,
                  color: Colors.deepOrange[900],
                  name: "Daily New Confirmed Cases"),
            ];

            List<ColumnSeries<DailyNewCases, String>> seriesDND = [
              ColumnSeries<DailyNewCases, String>(
                  dataSource: dailyStats,
                  xValueMapper: (DailyNewCases series, _) => series.date,
                  yValueMapper: (DailyNewCases series, _) =>
                      series.dailyNewDeaths,
                  color: Colors.grey[500],
                  name: "Daily New Deaths")
            ];

            List<ColumnSeries<DailyNewCases, String>> seriesDNR = [
              ColumnSeries<DailyNewCases, String>(
                  dataSource: dailyStats,
                  xValueMapper: (DailyNewCases series, _) => series.date,
                  yValueMapper: (DailyNewCases series, _) =>
                      series.dailyNewRecovered,
                  color: Colors.lightGreen[900],
                  name: "Daily New Recoveries")
            ];

            List<FastLineSeries<TotalCases, String>> seriesTNC = [
              FastLineSeries<TotalCases, String>(
                  width: 3.5,
                  dataSource: totalStats,
                  xValueMapper: (TotalCases series, _) => series.date,
                  yValueMapper: (TotalCases series, _) => series.totalConfirmed,
                  color: Colors.deepOrange[900],
                  name: "Total Confirmed Cases")
            ];

            List<FastLineSeries<TotalCases, String>> seriesTND = [
              FastLineSeries<TotalCases, String>(
                  width: 3.5,
                  dataSource: totalStats,
                  xValueMapper: (TotalCases series, _) => series.date,
                  yValueMapper: (TotalCases series, _) => series.totalDeaths,
                  color: Colors.grey[500],
                  name: "Total Deaths")
            ];

            List<FastLineSeries<TotalCases, String>> seriesTNR = [
              FastLineSeries<TotalCases, String>(
                  width: 3.5,
                  dataSource: totalStats,
                  xValueMapper: (TotalCases series, _) => series.date,
                  yValueMapper: (TotalCases series, _) => series.totalRecovered,
                  color: Colors.lightGreen[900],
                  name: "Total Recoveries")
            ];

            return DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: Color(0xff212F3D),
                appBar: TabBar(
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      text: "Cummulative",
                    ),
                    Tab(
                      text: "Daily",
                    )
                  ],
                ),
                body: TabBarView(
                  children: [
                    Container(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 30.0,
                            alignment: Alignment(0.005, 0.2),
                            child: Text(
                              "[Tap on the graph to see details]",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 2.0,
                                    offset: Offset(5.0, 5.0))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              color: Color(0xff212F3D),
                              semanticContainer: true,
                              elevation: 0,
                              margin: EdgeInsets.all(5),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    labelStyle:
                                        ChartTextStyle(color: Colors.white),
                                    majorGridLines: MajorGridLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                  labelStyle:
                                      ChartTextStyle(color: Colors.white),
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                title: ChartTitle(
                                    text: "Total Confirmed Cases",
                                    textStyle:
                                        ChartTextStyle(color: Colors.white)),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: seriesTNC,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 2.0,
                                    offset: Offset(5.0, 5.0))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              color: Color(0xff212F3D),
                              semanticContainer: true,
                              elevation: 0,
                              margin: EdgeInsets.all(5),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    labelStyle:
                                        ChartTextStyle(color: Colors.white),
                                    majorGridLines: MajorGridLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                  labelStyle:
                                      ChartTextStyle(color: Colors.white),
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                title: ChartTitle(
                                    text: "Total Recovered Cases",
                                    textStyle:
                                        ChartTextStyle(color: Colors.white)),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: seriesTNR,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 2.0,
                                    offset: Offset(5.0, 5.0))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              color: Color(0xff212F3D),
                              semanticContainer: true,
                              elevation: 0,
                              margin: EdgeInsets.all(5),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    labelStyle:
                                        ChartTextStyle(color: Colors.white),
                                    majorGridLines: MajorGridLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                  labelStyle:
                                      ChartTextStyle(color: Colors.white),
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                title: ChartTitle(
                                    text: "Total Deaths",
                                    textStyle:
                                        ChartTextStyle(color: Colors.white)),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: seriesTND,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 30.0,
                            alignment: Alignment(0.005, 0.2),
                            child: Text(
                              "[Tap on the graph to see details]",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 2.0,
                                    offset: Offset(5.0, 5.0))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              color: Color(0xff212F3D),
                              semanticContainer: true,
                              elevation: 0,
                              margin: EdgeInsets.all(5),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    labelStyle:
                                        ChartTextStyle(color: Colors.white),
                                    majorGridLines: MajorGridLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                  labelStyle:
                                      ChartTextStyle(color: Colors.white),
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                title: ChartTitle(
                                    text: "Daily New Confirmed Cases",
                                    textStyle:
                                        ChartTextStyle(color: Colors.white)),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: seriesDNC,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 2.0,
                                    offset: Offset(5.0, 5.0))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              color: Color(0xff212F3D),
                              semanticContainer: true,
                              elevation: 0,
                              margin: EdgeInsets.all(5),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    labelStyle:
                                        ChartTextStyle(color: Colors.white),
                                    majorGridLines: MajorGridLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                  labelStyle:
                                      ChartTextStyle(color: Colors.white),
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                title: ChartTitle(
                                    text: "Daily New Recoveries",
                                    textStyle:
                                        ChartTextStyle(color: Colors.white)),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: seriesDNR,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 2.0,
                                    offset: Offset(5.0, 5.0))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              color: Color(0xff212F3D),
                              semanticContainer: true,
                              elevation: 0,
                              margin: EdgeInsets.all(5),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    labelStyle:
                                        ChartTextStyle(color: Colors.white),
                                    majorGridLines: MajorGridLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                  labelStyle:
                                      ChartTextStyle(color: Colors.white),
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                title: ChartTitle(
                                    text: "Daily New Deaths",
                                    textStyle:
                                        ChartTextStyle(color: Colors.white)),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: seriesDND,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
