import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "package:charts_flutter/flutter.dart" as charts;

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();

class DailyNewCases {
  final int dailyNewCases;
  final String date;

  DailyNewCases({@required this.dailyNewCases, @required this.date});
}

class TotalCases {
  final int totalConfirmed;
  final String date;

  TotalCases({@required this.totalConfirmed, @required this.date});
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
              date: statsSnapshot.data.casesTimeSeries[index].date),
        );

        final List<TotalCases> totalStats = List.generate(
          statsSnapshot.data.casesTimeSeries.length,
          (index) => TotalCases(
              totalConfirmed: int.parse(
                  statsSnapshot.data.casesTimeSeries[index].dailyconfirmed),
              date: statsSnapshot.data.casesTimeSeries[index].date),
        );

        List<charts.Series<DailyNewCases, String>> series = {
          charts.Series(
            data: dailyStats,
            id: "Daily Stats",
            domainFn: (DailyNewCases series, _) => series.date,
            measureFn: (DailyNewCases series, _) => series.dailyNewCases,
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          )
        } as List<charts.Series<DailyNewCases, String>>;

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
                  ListView(),
                  ListView(
                    children: <Widget>[
                      Container(
                        child: Expanded(
                          child: charts.BarChart(
                            series,
                            animate: true,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
