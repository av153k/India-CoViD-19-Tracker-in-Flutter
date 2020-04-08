import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "package:charts_flutter/flutter.dart" as charts;

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();

class SpreadTrends extends StatefulWidget {
  _SpreadTrendsState createState() => _SpreadTrendsState();
}

class _SpreadTrendsState extends State<SpreadTrends> {
  Future<CovidIndia> stateStats = _covidIndiaStats.getStats();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            textStyle:
                TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
    ));
  }
}
