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
  Future<CovidIndia> stateStats = _covidIndiaStats.getStats();

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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleState(
                                  state:
                                      stateSnapshot.data.statewise[index].state,
                                  stateIndex: index,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width * 0.24,
                            child: Text(
                              stateSnapshot.data.statewise[index].state,
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.17,
                          child: Text(
                            stateSnapshot.data.statewise[index].confirmed,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.17,
                          child: Text(
                            stateSnapshot.data.statewise[index].active,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.17,
                          child: Text(
                            stateSnapshot.data.statewise[index].recovered,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.17,
                          child: Text(
                            stateSnapshot.data.statewise[index].deaths,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  );
                }

                return DataTable(
                  headingRowHeight: 50.0,
                  horizontalMargin: 5,
                  columnSpacing: 0,
                  sortAscending: true,
                  dataRowHeight: MediaQuery.of(context).size.height * 0.08,
                  columns: [
                    DataColumn(
                      numeric: false,
                      label: Text(
                        "State",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.purple),
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        "Cnfmd",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        "Actv",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        "Rcvrd",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.green),
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        "Dcsd",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    )
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
