import 'package:covid_india_tracker/assets/common_functions.dart';
import 'package:covid_india_tracker/models/world_data_api.dart';
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
          title: Text("Global Stats"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Octicons.globe,
                        color: Colors.teal,
                        size: 30,
                      ),
                      Text(
                        " Global Stats",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 30),
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        worldStats = getworldStats();
                      });
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

                int confirmedCases = dataSnapshot.data.global.totalConfirmed;
                int confirmedCasesDelta = dataSnapshot.data.global.newConfirmed;
                int activeCases = (dataSnapshot.data.global.totalConfirmed -
                    (dataSnapshot.data.global.totalDeaths +
                        dataSnapshot.data.global.totalRecovered));
                int recoveredCases = dataSnapshot.data.global.totalRecovered;
                int recoveredCasesDelta = dataSnapshot.data.global.newRecovered;
                int deceasedCases = dataSnapshot.data.global.totalDeaths;
                int deceasedCasesDelta = dataSnapshot.data.global.newDeaths;

                int activeDelta = (dataSnapshot.data.global.newConfirmed -
                    (dataSnapshot.data.global.newDeaths +
                        dataSnapshot.data.global.newRecovered));

                return Column(
                  children: <Widget>[
                    Container(
                      height: 20.0,
                      alignment: Alignment(0.005, 0.2),
                      child: Text(
                        "Database last updated on : ${(dataSnapshot.data.date).substring(0, 10)}, ${(dataSnapshot.data.date).substring(12, 16)}, GMT",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          getContainer("Confirmed", confirmedCases,
                              confirmedCasesDelta, 0.35, context, Colors.red),
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
                          getContainer("Recovered", recoveredCases,
                              recoveredCasesDelta, 0.35, context, Colors.green),
                          getContainer("Deceased", deceasedCases,
                              deceasedCasesDelta, 0.35, context, Colors.grey),
                        ],
                      ),
                    )
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
