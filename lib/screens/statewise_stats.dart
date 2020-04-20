import 'package:covid_india_tracker/assets/common_functions.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "package:covid_india_tracker/screens/single_state_data.dart";

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();

class StateWiseStats extends StatefulWidget {
  _StateWiseStats createState() => _StateWiseStats();
}

class _StateWiseStats extends State<StateWiseStats> {
  Future<CovidIndia> stateStats;

  Future<CovidIndia> getStateData() {
    return _covidIndiaStats.getStats();
  }

  @override
  void initState() {
    super.initState();
    stateStats = getStateData();
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
            "StateWise Stats",
            style: GoogleFonts.montserrat(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
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
                  Text(
                    "StateWise Stats",
                    style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 23),
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: Colors.white),
                    onPressed: () {
                      setState(
                        () {
                          stateStats = getStateData();
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 30.0,
              alignment: Alignment(0.005, 0.2),
              child: Text(
                "[Tap on the state name to see details]",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            FutureBuilder(
              future: stateStats,
              builder: (BuildContext context,
                  AsyncSnapshot<CovidIndia> stateSnapshot) {
                if (stateSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                DataRow _getDataRow(index) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Color(0xff17202a),
                                spreadRadius: 2,
                              )
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleState(
                                    state: stateSnapshot
                                        .data.statewise[index].state,
                                    stateIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff212F3D),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(3.5),
                              width: MediaQuery.of(context).size.width * 0.22,
                              child: Text(
                                stateSnapshot.data.statewise[index].state,
                                style:
                                    GoogleFonts.montserrat(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      getDataCells(
                        context,
                        0.15,
                        finalStats(
                            int.parse(stateSnapshot
                                .data.statewise[index].deltaconfirmed),
                            int.parse(
                                stateSnapshot.data.statewise[index].confirmed),
                            Colors.red),
                      ),
                      DataCell(
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Color(0xff17202a),
                                spreadRadius: 2,
                              )
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff212F3D),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              stateSnapshot.data.statewise[index].active,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      getDataCells(
                        context,
                        0.15,
                        finalStats(
                            int.parse(stateSnapshot
                                .data.statewise[index].deltarecovered),
                            int.parse(
                                stateSnapshot.data.statewise[index].recovered),
                            Colors.green),
                      ),
                      getDataCells(
                        context,
                        0.15,
                        finalStats(
                            int.parse(stateSnapshot
                                .data.statewise[index].deltadeaths),
                            int.parse(
                                stateSnapshot.data.statewise[index].deaths),
                            Colors.grey),
                      ),
                    ],
                  );
                }

                return DataTable(
                  headingRowHeight: 50.0,
                  horizontalMargin: 5,
                  columnSpacing: 10,
                  sortAscending: true,
                  dataRowHeight: MediaQuery.of(context).size.height * 0.1,
                  columns: [
                    getDataColumn("State", Colors.purple),
                    getDataColumn("Cnfmd", Colors.red),
                    getDataColumn("Active", Colors.blue),
                    getDataColumn("Rcvrd", Colors.green),
                    getDataColumn("Dcsd", Colors.grey)
                  ],
                  rows: List.generate(stateSnapshot.data.statewise.length - 1,
                      (index) => _getDataRow(index + 1)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
