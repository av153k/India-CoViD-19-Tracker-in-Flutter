import 'package:covid_india_tracker/assets/common_functions.dart';
import 'package:covid_india_tracker/models/world_data_api.dart';
import 'package:covid_india_tracker/screens/countries_stats.dart';
import 'package:covid_india_tracker/services/get_world_data.dart';
import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import "package:google_fonts/google_fonts.dart";
import "dart:async";

GlobalStats _globalStats = new GlobalStats();

class GlobStats extends StatefulWidget {
  _GlobStats createState() => _GlobStats();
}

class _GlobStats extends State<GlobStats> {
  Future<WorldStats> worldStats;

  Future<WorldStats> getworldStats() {
    return _globalStats.getStats();
  }

  @override
  void initState() {
    super.initState();
    worldStats = getworldStats();
  }

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
          title: Text(
            "Global Stats",
            style: GoogleFonts.montserrat(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xff17202a),
        ),
        body: ListView(
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              height: 70,
              alignment: Alignment(0.001, 0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Octicons.globe,
                    color: Colors.teal,
                    size: 30,
                  ),
                  Flexible(
                    child: Text(
                      "Global",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 30),
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          worldStats = getworldStats();
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: worldStats,
              builder: (BuildContext context,
                  AsyncSnapshot<WorldStats> dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                String filler = 'NA';

                int confirmedCases = dataSnapshot.data.cases;
                int confirmedCasesDelta = dataSnapshot.data.todayCases;
                int activeCases = dataSnapshot.data.active;
                int recoveredCases = dataSnapshot.data.recovered;
                int recoveredCasesDelta = int.tryParse(filler);
                int deceasedCases = dataSnapshot.data.deaths;
                int deceasedCasesDelta = dataSnapshot.data.todayDeaths;
                int activeDelta = int.tryParse(filler);

                return Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          getContainer("Confirmed", confirmedCases,
                              confirmedCasesDelta, 0.35, context, Colors.red),
                          getContainer("Deceased", deceasedCases,
                              deceasedCasesDelta, 0.35, context, Colors.grey),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          getContainer("Recovered", recoveredCases,
                              recoveredCasesDelta, 0.35, context, Colors.green),
                          getContainer("Active", activeCases, activeDelta, 0.35,
                              context, Colors.blue)
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          getContainer(
                              "Cases/Mil",
                              dataSnapshot.data.casesPerOneMillion,
                              recoveredCasesDelta,
                              0.35,
                              context,
                              Colors.redAccent),
                          getContainer(
                              "Deaths/Mil",
                              dataSnapshot.data.deathsPerOneMillion,
                              activeDelta,
                              0.35,
                              context,
                              Colors.grey),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          getButtons(
                            "View CountryWise Stats",
                            Ionicons.ios_arrow_dropright_circle,
                            0.08,
                            0.7,
                            context,
                            Colors.deepPurple,
                            Countries(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
