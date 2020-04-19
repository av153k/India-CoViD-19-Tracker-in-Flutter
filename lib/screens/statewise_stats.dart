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
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.purple,
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
                                MaterialPageRoute<String>(
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
                      DataCell(
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.redAccent,
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
                              child: finalConfirmed(index)),
                        ),
                      ),
                      DataCell(
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.blueAccent,
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
                      DataCell(
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.greenAccent,
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
                              width: MediaQuery.of(context).size.width * 0.17,
                              child: finalRecoveries(index)),
                        ),
                      ),
                      DataCell(
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.white70,
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
                              child: finalDeath(index)),
                        ),
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
                        "Active",
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
