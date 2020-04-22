import 'package:covid_india_tracker/assets/common_functions.dart';
import 'package:covid_india_tracker/screens/state_test_statistics.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "package:covid_india_tracker/models/district_data.dart";
import "package:covid_india_tracker/services/get_districtData.dart";

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();
DistrictWiseStats _districWiseStats = new DistrictWiseStats();

class DistrictsStats {
  String name;
  int confirmed;
  int deltaConfirmed;
  DistrictsStats({this.name, this.confirmed, this.deltaConfirmed});
}

class SingleState extends StatefulWidget {
  final String state;
  final int stateIndex;

  SingleState({Key key, @required this.state, @required this.stateIndex})
      : super(key: key);

  _SingleState createState() => _SingleState();
}

class _SingleState extends State<SingleState> {
  Future<CovidIndia> singleState;

  Future<CovidIndia> getSingleStateData() {
    return _covidIndiaStats.getStats();
  }

  Future<List<DistrictData>> getData() {
    return _districWiseStats.getStats(widget.state);
  }

  Future<List<DistrictData>> districts;

  @override
  void initState() {
    super.initState();
    singleState = getSingleStateData();
    districts = getData();
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
          title: Text(
            widget.state,
            style: GoogleFonts.montserrat(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
            ),
            textScaleFactor: 1.0,
          ),
          backgroundColor: Color(0xff17202a),
        ),
        body: ListView(
          padding: EdgeInsets.all(5),
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              height: 70,
              alignment: Alignment(0.001, 0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${widget.state} Stats",
                    style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 23),
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          singleState = getSingleStateData();
                          districts = getData();
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: singleState,
              builder: (BuildContext context,
                  AsyncSnapshot<CovidIndia> singleStateSnap) {
                if (singleStateSnap.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: LinearProgressIndicator(),
                  );
                }

                String confirmed =
                    singleStateSnap.data.statewise[widget.stateIndex].confirmed;
                String confirmedDelta = singleStateSnap
                    .data.statewise[widget.stateIndex].deltaconfirmed;
                String active =
                    singleStateSnap.data.statewise[widget.stateIndex].active;
                String recovered =
                    singleStateSnap.data.statewise[widget.stateIndex].recovered;
                String recoveredDelta = singleStateSnap
                    .data.statewise[widget.stateIndex].deltarecovered;
                String deaths =
                    singleStateSnap.data.statewise[widget.stateIndex].deaths;
                String deathsDelta = singleStateSnap
                    .data.statewise[widget.stateIndex].deltadeaths;
                int activeDelta = (int.parse(confirmedDelta) -
                    (int.parse(deathsDelta) + int.parse(recoveredDelta)));

                return Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          getContainer(
                              "Confirmed",
                              int.parse(confirmed),
                              int.parse(confirmedDelta),
                              0.3,
                              context,
                              Colors.red),
                          getContainer("Active", int.parse(active), activeDelta,
                              0.3, context, Colors.blue),
                          getContainer(
                              "Recovered",
                              int.parse(recovered),
                              int.parse(recoveredDelta),
                              0.3,
                              context,
                              Colors.green),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          getContainer(
                              "Deceased",
                              int.parse(deaths),
                              int.parse(deathsDelta),
                              0.3,
                              context,
                              Colors.grey),
                          StateTest(
                              state: singleStateSnap
                                  .data.statewise[widget.stateIndex].state)
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            FutureBuilder(
              future: districts,
              builder: (BuildContext context,
                  AsyncSnapshot<List<DistrictData>> districtsSnap) {
                if (districtsSnap.connectionState == ConnectionState.waiting) {
                  return Center(child: LinearProgressIndicator());
                }

                List<DistrictsStats> _districts = List<DistrictsStats>();

                for (var i = 0; i < districtsSnap.data.length; i++) {
                  _districts.add(
                    DistrictsStats(
                        name: districtsSnap.data[i].district,
                        confirmed: districtsSnap.data[i].confirmed,
                        deltaConfirmed: districtsSnap.data[i].delta.confirmed),
                  );
                }

                Row finalConfirmed(DistrictsStats district) {
                  if (district.deltaConfirmed != 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "\u{2B06} ${district.deltaConfirmed}  ",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                          textScaleFactor: 1.0,
                        ),
                        Text(
                          "${district.confirmed}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${district.confirmed}',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textScaleFactor: 1.0,
                        ),
                      ],
                    );
                  }
                }

                var dataColumns = [
                  getDataColumn2(context, "Districts", Colors.purple),
                  getDataColumn2(context, "Confirmed", Colors.red)
                ];
                var dataRows = _districts
                    .map(
                      (district) => DataRow(
                        cells: [
                          DataCell(
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
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
                                child: Text(
                                  district.name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  textScaleFactor: 1.0,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
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
                                child: finalConfirmed(district),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    .toList();

                return Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Text(
                          "District-Wise Stats",
                          style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ),
                      DataTable(
                        headingRowHeight:
                            MediaQuery.of(context).size.height * 0.15,
                        columns: dataColumns,
                        dataRowHeight:
                            MediaQuery.of(context).size.height * 0.08,
                        rows: dataRows,
                      ),
                    ],
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
