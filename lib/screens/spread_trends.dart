import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "package:charts_flutter/flutter.dart" as charts;
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
  Future<CovidIndia> statsGraphs = _covidIndiaStats.getStats();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: statsGraphs,
      builder: (BuildContext context, AsyncSnapshot<CovidIndia> statsSnapshot) {
        if (statsSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<DailyNewCases> dailyStats = List.generate(
          statsSnapshot.data.casesTimeSeries.length,
          (index) => DailyNewCases(
              dailyNewCases: int.parse(
                  statsSnapshot.data.casesTimeSeries[index].dailyconfirmed),
              dailyNewDeaths: int.parse(
                  statsSnapshot.data.casesTimeSeries[index].dailydeceased),
              dailyNewRecovered: int.parse(
                  statsSnapshot.data.casesTimeSeries[index].dailyrecovered),
              date: statsSnapshot.data.casesTimeSeries[index].date),
        );

        final List<TotalCases> totalStats = List.generate(
          statsSnapshot.data.casesTimeSeries.length,
          (index) => TotalCases(
              totalConfirmed: int.parse(
                  statsSnapshot.data.casesTimeSeries[index].totalconfirmed),
              totalDeaths: int.parse(
                  statsSnapshot.data.casesTimeSeries[index].totaldeceased),
              totalRecovered: int.parse(
                  statsSnapshot.data.casesTimeSeries[index].totalrecovered),
              date: statsSnapshot.data.casesTimeSeries[index].date),
        );

        List<BarSeries<DailyNewCases, String>> seriesDNC = [
          BarSeries<DailyNewCases, String>(
              opacity: 5.0,
              dataSource: dailyStats,
              xValueMapper: (DailyNewCases series, _) => series.date,
              yValueMapper: (DailyNewCases series, _) => series.dailyNewCases,
              color: Colors.redAccent,
              name: "Daily New Confirmed Cases")
        ];

        List<BarSeries<DailyNewCases, String>> seriesDND = [
          BarSeries<DailyNewCases, String>(
              opacity: 5.0,
              dataSource: dailyStats,
              xValueMapper: (DailyNewCases series, _) => series.date,
              yValueMapper: (DailyNewCases series, _) => series.dailyNewDeaths,
              color: Colors.grey,
              name: "Daily New Deaths")
        ];

        List<BarSeries<DailyNewCases, String>> seriesDNR = [
          BarSeries<DailyNewCases, String>(
              opacity: 5.0,
              dataSource: dailyStats,
              xValueMapper: (DailyNewCases series, _) => series.date,
              yValueMapper: (DailyNewCases series, _) =>
                  series.dailyNewRecovered,
              color: Colors.greenAccent,
              name: "Daily New Recoveries")
        ];

        List<LineSeries<TotalCases, String>> seriesTNC = [
          LineSeries<TotalCases, String>(
              opacity: 5.0,
              dataSource: totalStats,
              xValueMapper: (TotalCases series, _) => series.date,
              yValueMapper: (TotalCases series, _) => series.totalConfirmed,
              color: Colors.redAccent,
              name: "Total Confirmed Cases")
        ];

        List<LineSeries<TotalCases, String>> seriesTND = [
          LineSeries<TotalCases, String>(
              opacity: 5.0,
              dataSource: totalStats,
              xValueMapper: (TotalCases series, _) => series.date,
              yValueMapper: (TotalCases series, _) => series.totalDeaths,
              color: Colors.grey,
              name: "Total Deaths")
        ];

        List<LineSeries<TotalCases, String>> seriesTNR = [
          LineSeries<TotalCases, String>(
              opacity: 5.0,
              dataSource: totalStats,
              xValueMapper: (TotalCases series, _) => series.date,
              yValueMapper: (TotalCases series, _) => series.totalRecovered,
              color: Colors.greenAccent,
              name: "Total Recoveries")
        ];

        return DefaultTabController(
          length: 2,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.black87,
                title: Text(
                  "Spread Trends",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: "Cummulative",
                    ),
                    Tab(
                      text: "Daily",
                    )
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Container(
                    height: 50,
                    child: Column(
                      children: <Widget>[
                        Card(
                          semanticContainer: true,
                          elevation: 10,
                          margin: EdgeInsets.all(5),
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                                majorGridLines: MajorGridLines(width: 0)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: MajorGridLines(width: 0),
                            ),
                            title: ChartTitle(text: "Total Confirmed Cases"),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: seriesTNC,
                          ),
                        ),
                        Card(
                          semanticContainer: true,
                          elevation: 10,
                          margin: EdgeInsets.all(5),
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                                majorGridLines: MajorGridLines(width: 0)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: MajorGridLines(width: 0),
                            ),
                            title: ChartTitle(text: "Total Recoveries"),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: seriesTNR,
                          ),
                        ),
                        Card(
                          semanticContainer: true,
                          elevation: 10,
                          margin: EdgeInsets.all(5),
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                                majorGridLines: MajorGridLines(width: 0)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: MajorGridLines(width: 0),
                            ),
                            title: ChartTitle(text: "Total Deaths"),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: seriesTND,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Column(
                      children: <Widget>[
                        Card(
                          semanticContainer: true,
                          elevation: 10,
                          margin: EdgeInsets.all(5),
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                                majorGridLines: MajorGridLines(width: 0)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: MajorGridLines(width: 0),
                            ),
                            title:
                                ChartTitle(text: "Daily New Confirmed Cases"),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: seriesDNC,
                          ),
                        ),
                        Card(
                          semanticContainer: true,
                          elevation: 10,
                          margin: EdgeInsets.all(5),
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                                majorGridLines: MajorGridLines(width: 0)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: MajorGridLines(width: 0),
                            ),
                            title: ChartTitle(text: "Daily New Recoveries"),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: seriesDNR,
                          ),
                        ),
                        Card(
                          semanticContainer: true,
                          elevation: 10,
                          margin: EdgeInsets.all(5),
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                                majorGridLines: MajorGridLines(width: 0)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: MajorGridLines(width: 0),
                            ),
                            title: ChartTitle(text: "Daily New Deaths"),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: seriesDND,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
