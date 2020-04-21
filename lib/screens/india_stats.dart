import 'package:covid_india_tracker/screens/app_info.dart';
import 'package:covid_india_tracker/screens/global_stats.dart';
import 'package:covid_india_tracker/screens/pateints_analysis.dart';
import 'package:covid_india_tracker/screens/spread_trends.dart';
import 'package:covid_india_tracker/screens/statewise_stats.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "dart:async";
import "package:flag/flag.dart";
import "package:flutter_icons/flutter_icons.dart";
import "package:covid_india_tracker/assets/common_functions.dart";

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();

class IndiaStats extends StatefulWidget {
  _IndiaStats createState() => _IndiaStats();
}

class _IndiaStats extends State<IndiaStats> {
  Future<CovidIndia> asIndiaStats;

  Future<CovidIndia> getIndiaStats() {
    return _covidIndiaStats.getStats();
  }

  @override
  void initState() {
    super.initState();
    asIndiaStats = getIndiaStats();
  }

  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(3),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          margin: EdgeInsets.all(5),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flags.getMiniFlag("IN", 25, 50),
              Flexible(
                child: Text(
                  "India",
                  style: GoogleFonts.montserrat(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
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
                  setState(() {
                    asIndiaStats = getIndiaStats();
                  });
                },
              )
            ],
          ),
        ),
        FutureBuilder(
          future: asIndiaStats,
          builder:
              (BuildContext context, AsyncSnapshot<CovidIndia> dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Text("You're offline, Please connect to Internet !!!"),
              );
            }

            int confirmedCases =
                int.parse(dataSnapshot.data.statewise[0].confirmed);
            int confirmedCasesDelta =
                int.parse(dataSnapshot.data.statewise[0].deltaconfirmed);
            int activeCases = int.parse(dataSnapshot.data.statewise[0].active);
            int recoveredCases =
                int.parse(dataSnapshot.data.statewise[0].recovered);
            int recoveredCasesDelta =
                int.parse(dataSnapshot.data.statewise[0].deltarecovered);
            int deceasedCases =
                int.parse(dataSnapshot.data.statewise[0].deaths);
            int deceasedCasesDelta =
                int.parse(dataSnapshot.data.statewise[0].deltadeaths);

            int tested;
            //int testedDelta;

            if (dataSnapshot.data.tested[dataSnapshot.data.tested.length - 1]
                    .totalindividualstested ==
                "") {
              tested = int.parse(dataSnapshot
                  .data
                  .tested[dataSnapshot.data.tested.length - 2]
                  .totalindividualstested);
              /*testedDelta = int.parse(dataSnapshot
                      .data
                      .tested[dataSnapshot.data.tested.length - 2]
                      .totalindividualstested) -
                  int.parse(dataSnapshot
                      .data
                      .tested[dataSnapshot.data.tested.length - 3]
                      .totalindividualstested);*/
            } else {
              tested = int.parse(dataSnapshot
                  .data
                  .tested[dataSnapshot.data.tested.length - 1]
                  .totalindividualstested);
              /*testedDelta = int.parse(dataSnapshot
                      .data
                      .tested[dataSnapshot.data.tested.length - 1]
                      .totalindividualstested) -
                  int.parse(dataSnapshot
                      .data
                      .tested[dataSnapshot.data.tested.length - 2]
                      .totalindividualstested);*/
            }

            int activeDelta = (confirmedCasesDelta -
                (deceasedCasesDelta + recoveredCasesDelta));

            return Column(
              children: <Widget>[
                Container(
                    height: 40.0,
                    alignment: Alignment(0.01, 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Ionicons.md_sync,
                          color: Colors.white,
                        ),
                        Text(
                          " Database last sync : ${getFormattedTime(dataSnapshot.data.statewise[0].lastupdatedtime)}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getContainer("Confirmed", confirmedCases,
                          confirmedCasesDelta, 0.3, context, Colors.red),
                      getContainer("Active", activeCases, activeDelta, 0.3,
                          context, Colors.blue),
                      getContainer("Recovered", recoveredCases,
                          recoveredCasesDelta, 0.3, context, Colors.green),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getContainer("Deceased", deceasedCases,
                          deceasedCasesDelta, 0.3, context, Colors.grey),
                      getTested(tested, 1, context)
                    ],
                  ),
                )
              ],
            );
          },
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.28,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.03,
                child: Text(
                  "Additional Analysis",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    getButtons("StateWise Stats", Icons.table_chart, 0.08, 0.43,
                        context, Colors.purple, StateWiseStats()),
                    getButtons("Spread Trends", Ionicons.md_analytics, 0.08,
                        0.43, context, Colors.redAccent, SpreadTrends()),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    /*getButtons("Deep Dive", MaterialCommunityIcons.graphql,
                        0.08, 0.43, context, Colors.green, PatientsAnalysis()),*/
                    getButtons("Global Stats", Octicons.globe, 0.08, 0.43,
                        context, Colors.blue, GlobStats()),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              getButtons("App Info", Ionicons.ios_information_circle_outline,
                  0.05, 0.3, context, Colors.amber, AppInfo()),
            ],
          ),
        ),
      ],
    );
  }
}
