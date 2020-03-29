import 'package:flutter/material.dart';
import "package:covid_india_tracker/services/api_model.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "dart:async";

void main() => runApp(HomePage());

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<CovidIndia> asIndiaStats = _covidIndiaStats.getStats();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text("India CoViD-19 Tracker"),
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
                  DataCell(Text(dataSnapshot.data.statewise[index].state)),
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
                dataSnapshot.data.statewise[0].delta.recovered;
            int deceasedCases =
                int.parse(dataSnapshot.data.statewise[0].deaths);
            int deceasedCasesDelta =
                dataSnapshot.data.statewise[0].delta.deaths;

            return ListView(
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  height: 70,
                  alignment: Alignment(0.03, 0.2),
                  child: Text(
                    "India CoViD-19 Stats",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
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
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
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
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
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
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
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
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
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
                  height: 70,
                  alignment: Alignment(0.03, 0.2),
                  child: Text(
                    "StateWise Stats",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                DataTable(
                  columnSpacing: 1.0,
                  sortAscending: true,
                  dataRowHeight: 30.0,
                  columns: [
                    DataColumn(
                        label: Text("State",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.purple))),
                    DataColumn(
                        label: Text(
                      "Confirmed",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    )),
                    DataColumn(
                        label: Text("Active",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue))),
                    DataColumn(
                        label: Text("Deaths",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)))
                  ],
                  rows: List.generate(dataSnapshot.data.statewise.length,
                      (index) => _getDataRow(index)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
