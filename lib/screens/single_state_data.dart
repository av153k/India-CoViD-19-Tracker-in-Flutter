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
          title: Text(widget.state),
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
                String tested = "NA";
                int activeDelta = (int.parse(confirmedDelta) -
                    (int.parse(deathsDelta) + int.parse(recoveredDelta)));

                return Column(
                  children: <Widget>[
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    "+$confirmedDelta",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "$confirmed",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    "$active",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    "+$recoveredDelta",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "$recovered",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    "+$deathsDelta",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "$deaths",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                          ),
                          StateTest(state: singleStateSnap.data.statewise[widget.stateIndex].state)
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

                bool _sortAsc = false;

                List<DistrictsStats> _districts = List<DistrictsStats>();

                for (var i = 0; i < districtsSnap.data.length; i++) {
                  _districts.add(
                    DistrictsStats(
                        name: districtsSnap.data[i].district,
                        confirmed: districtsSnap.data[i].confirmed,
                        deltaConfirmed: districtsSnap.data[i].delta.confirmed),
                  );
                }

                onSortColumn(int columnIndex, bool ascending) {
                  if (columnIndex == 0) {
                    if (ascending) {
                      _districts
                        ..sort((a, b) => a.confirmed.compareTo(b.confirmed));
                    } else {
                      _districts
                        ..sort((a, b) => b.confirmed.compareTo(a.confirmed));
                    }
                  }
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
                        ),
                        Text(
                          "${district.confirmed}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${district.confirmed}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  }
                }

                var dataColumns = [
                  DataColumn(
                    label: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.08,
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
                          "District",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                      numeric: true,
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.08,
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
                            "Confirmed",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          _sortAsc = !_sortAsc;
                        });
                        onSortColumn(columnIndex, ascending);
                      }),
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
                                  style: TextStyle(color: Colors.white),
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
