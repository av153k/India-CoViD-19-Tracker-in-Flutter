import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "package:covid_india_tracker/models/district_data.dart";
import "package:covid_india_tracker/services/get_districtData.dart";

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();
DistrictWiseStats _districWiseStats = new DistrictWiseStats();

class SingleState extends StatefulWidget {
  final String state;
  final int stateIndex;

  SingleState({Key key, @required this.state, @required this.stateIndex})
      : super(key: key);

  _SingleState createState() => _SingleState();
}

class _SingleState extends State<SingleState> {
  Future<CovidIndia> singleState = _covidIndiaStats.getStats();
  Future<List<DistrictData>> getData() {
    return _districWiseStats.getStats(widget.state);
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
          backgroundColor: Color(0xff212F3D),
        ),
        body: FutureBuilder(
          future: singleState,
          builder: (BuildContext context,
              AsyncSnapshot<CovidIndia> singleStateSnap) {
            if (singleStateSnap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
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
            String deathsDelta =
                singleStateSnap.data.statewise[widget.stateIndex].deltadeaths;

            return ListView(
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  height: 70,
                  alignment: Alignment(0.001, 0.2),
                  child: Text(
                    "${widget.state} Stats",
                    style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                      color: Colors.white,
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
                          "+$confirmedDelta",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          confirmed,
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
                          " ",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          active,
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
                          "+$recoveredDelta",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          recovered,
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
                          "+$deathsDelta",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          deaths,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )
                      ],
                    ),
                  ],
                ),
                FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DistrictData>> districtsSnap) {
                    if (districtsSnap.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    DataRow _getRows(index) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Text(
                              districtsSnap.data[index].district,
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              "${districtsSnap.data[index].confirmed}",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      );
                    }

                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              "District",
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
                              "Confirmed",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          districtsSnap.data.length,
                          (index) => _getRows(index),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
