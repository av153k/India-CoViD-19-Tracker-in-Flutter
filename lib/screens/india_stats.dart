import 'package:covid_india_tracker/screens/global_stats.dart';
import 'package:covid_india_tracker/screens/spread_trends.dart';
import 'package:covid_india_tracker/screens/statewise_stats.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "dart:async";
import "package:flag/flag.dart";

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
              Flags.getMiniFlag("IN", 25, 50),
              Text(
                "India CoViD-19 Stats",
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
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
            int tested = int.parse(dataSnapshot
                .data
                .tested[dataSnapshot.data.tested.length - 1]
                .totalindividualstested);
            int activeDelta = (confirmedCasesDelta -
                (deceasedCasesDelta + recoveredCasesDelta));
            int testedDelta = int.parse(dataSnapshot
                    .data
                    .tested[dataSnapshot.data.tested.length - 1]
                    .totalindividualstested) -
                int.parse(dataSnapshot
                    .data
                    .tested[dataSnapshot.data.tested.length - 2]
                    .totalindividualstested);

            return Column(
              children: <Widget>[
                Container(
                    height: 40.0,
                    alignment: Alignment(0.005, 0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Database last updated at : ${dataSnapshot.data.statewise[0].lastupdatedtime}",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "*Tested data only gets updated after 9 PM everyday.",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontSize: 12),
                        ),
                      ],
                    )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0xff17202a),
                                spreadRadius: 2.0,
                                offset: Offset(8.0, 8.0))
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        height: 90,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          color: Color(0xff530709),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                "Confirmed",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "+$confirmedCasesDelta",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              ),
                              Text(
                                "$confirmedCases",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0xff17202a),
                                spreadRadius: 2.0,
                                offset: Offset(8.0, 8.0))
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        height: 90,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          color: Color(0xff070D53),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Active",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "+$activeDelta",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              ),
                              Text(
                                "$activeCases",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Color(0xff17202a),
                                  spreadRadius: 2.0,
                                  offset: Offset(8.0, 8.0))
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          height: 90,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            color: Color(0xff0E5307),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Recovered",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18)),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "+$recoveredCasesDelta",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                                Text(
                                  "$recoveredCases",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0xff17202a),
                                spreadRadius: 2.0,
                                offset: Offset(8.0, 8.0))
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        height: 90,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          color: Color(0xff3C3737),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Deceased",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "+$deceasedCasesDelta",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              ),
                              Text(
                                "$deceasedCases",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0xff17202a),
                                spreadRadius: 2.0,
                                offset: Offset(8.0, 8.0))
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        height: 90,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          color: Color(0xff525307),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Tested",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.yellow,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "+$testedDelta",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              ),
                              Text(
                                "$tested",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      )
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Color(0xff17202a),
                            spreadRadius: 3.0,
                          )
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Color(0xff212F3D),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StateWiseStats(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.table_chart,
                                color: Colors.teal,
                              ),
                              Text(
                                " StateWise Stats",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Color(0xff17202a),
                            spreadRadius: 3.0,
                          )
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Color(0xff212F3D),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SpreadTrends(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.multiline_chart,
                                color: Colors.redAccent,
                              ),
                              Text(
                                " Spread Trends",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Color(0xff17202a),
                            spreadRadius: 3.0,
                          )
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Color(0xff212F3D),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GlobStats(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.language,
                                color: Colors.blue,
                              ),
                              Text(
                                "Global Stats",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
