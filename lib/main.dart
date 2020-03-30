import 'package:covid_india_tracker/models/raw_data.dart';
import 'package:flutter/material.dart';
import "package:covid_india_tracker/services/data_fetcher.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "dart:async";
import "package:google_fonts/google_fonts.dart";
import "package:geolocator/geolocator.dart";
import "package:covid_india_tracker/services/raw_data_fetch.dart";
import "package:covid_india_tracker/screens/statewise_stats.dart";

void main() => runApp(HomePage(
      androidFusedLocation: true,
    ));

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();
RawDataStats _rawDataStats = new RawDataStats();

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
    @required this.androidFusedLocation,
  }) : super(key: key);

  final bool androidFusedLocation;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<CovidIndia> asIndiaStats = _covidIndiaStats.getStats();
  Future<RawDataset> rawDataset = _rawDataStats.getStats();
  Position _currPosition;

  _getCurrentLocation() {
    Geolocator()
      ..forceAndroidLocationManager = !widget.androidFusedLocation
      ..getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((position) {
        if (mounted) {
          setState(() {
            _currPosition = position;
          });
        }
      }).catchError((e) {
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            "India CoViD-19 Tracker",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ),
        body: FutureBuilder(
          future: asIndiaStats,
          builder:
              (BuildContext context, AsyncSnapshot<CovidIndia> dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            DataRow _getDataRow(index) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text(
                      dataSnapshot.data.statewise[index].state,
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                  DataCell(Text(dataSnapshot.data.statewise[index].confirmed)),
                  DataCell(Text(dataSnapshot.data.statewise[index].active)),
                  DataCell(Text(dataSnapshot.data.statewise[index].deaths))
                ],
              );
            }

            int confirmedCases =
                int.parse(dataSnapshot.data.statewise[0].confirmed);
            int confirmedCasesDelta =
                dataSnapshot.data.statewise[0].delta.confirmed;
            int activeCases = int.parse(dataSnapshot.data.statewise[0].active);
            int activeCasesDelta = dataSnapshot.data.statewise[0].delta.active;
            int recoveredCases =
                int.parse(dataSnapshot.data.statewise[0].recovered);
            int recoveredCasesDelta =
                int.parse(dataSnapshot.data.keyValues[0].recovereddelta);
            int deceasedCases =
                int.parse(dataSnapshot.data.statewise[0].deaths);
            int deceasedCasesDelta =
                int.parse(dataSnapshot.data.keyValues[0].deceaseddelta);

            return ListView(
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  height: 70,
                  alignment: Alignment(0.001, 0.2),
                  child: Text(
                    "India CoViD-19 Stats",
                    style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Confirmed",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "+$confirmedCasesDelta",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "$confirmedCases",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Active",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "+$activeCasesDelta",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "$activeCases",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Recovered",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "+$recoveredCasesDelta",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "$recoveredCases",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Deceased",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "+$deceasedCasesDelta",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "$deceasedCases",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  height: 30.0,
                  alignment: Alignment(0.005, 0.2),
                  child: Text(
                    "Last updated at : ${dataSnapshot.data.statewise[0].lastupdatedtime}",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                FutureBuilder<GeolocationStatus>(
                    future: Geolocator().checkGeolocationPermissionStatus(),
                    builder: (BuildContext context,
                        AsyncSnapshot<GeolocationStatus> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.data == GeolocationStatus.denied) {
                        return const Text(
                            "Access to location is denied. Please allow access to loaction for this app from device's setting.");
                      }

                      return Container(
                        child: Text(
                            "Current Location - ${_currPosition.toString()}"),
                      );
                    }),
                Container(
                  height: 70,
                  alignment: Alignment(0.03, 0.2),
                  child: Text(
                    "StateWise Stats",
                    style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                StateWiseStats(),
              ],
            );
          },
        ),
      ),
    );
  }
}
