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
            Container(
              height: 70,
              alignment: Alignment(0.001, 0.2),
              child: Text(
                "StateWise Stats",
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
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
                Column finalConfirmed(int index) {
                  if (int.parse(
                          stateSnapshot.data.statewise[index].deltaconfirmed) !=
                      0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "\u{2B06} ${stateSnapshot.data.statewise[index].deltaconfirmed}",
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                        Text(
                          stateSnapshot.data.statewise[index].confirmed,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          stateSnapshot.data.statewise[index].confirmed,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  }
                }

                Column finalRecoveries(int index) {
                  if (int.parse(
                          stateSnapshot.data.statewise[index].deltarecovered) !=
                      0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "\u{2B06} ${stateSnapshot.data.statewise[index].deltarecovered}",
                          style: TextStyle(color: Colors.green, fontSize: 13),
                        ),
                        Text(
                          stateSnapshot.data.statewise[index].recovered,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          stateSnapshot.data.statewise[index].recovered,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  }
                }

                Column finalDeath(int index) {
                  if (int.parse(
                          stateSnapshot.data.statewise[index].deltadeaths) !=
                      0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "\u{2B06} ${stateSnapshot.data.statewise[index].deltadeaths}",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        Text(
                          stateSnapshot.data.statewise[index].deaths,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          stateSnapshot.data.statewise[index].deaths,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  }
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
                            child: finalConfirmed(index)),
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
                            child: finalRecoveries(index)),
                      ),
                      DataCell(
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: finalDeath(index)),
                      )
                    ],
                  );
                }

                return Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.white),
                  child: DataTable(
                    headingRowHeight: 50.0,
                    horizontalMargin: 5,
                    columnSpacing: 0,
                    sortAscending: true,
                    dataRowHeight: MediaQuery.of(context).size.height * 0.1,
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
