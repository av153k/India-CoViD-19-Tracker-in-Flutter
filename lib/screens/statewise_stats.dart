import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "package:covid_india_tracker/models/data_api.dart";

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();

class StateWiseStats extends StatefulWidget {
  _StateWiseStats createState() => _StateWiseStats();
}

class _StateWiseStats extends State<StateWiseStats> {
  Future<CovidIndia> stateStats = _covidIndiaStats.getStats();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: stateStats,
        builder:
            (BuildContext context, AsyncSnapshot<CovidIndia> stateSnapshot) {
          if (stateSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          DataRow _getDataRow(index) {
            return DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    stateSnapshot.data.statewise[index].state,
                    style: GoogleFonts.montserrat(),
                  ),
                ),
                DataCell(Text(stateSnapshot.data.statewise[index].confirmed)),
                DataCell(Text(stateSnapshot.data.statewise[index].active)),
                DataCell(Text(stateSnapshot.data.statewise[index].deaths))
              ],
            );
          }

          return DataTable(
            columnSpacing: 1.0,
            sortAscending: true,
            dataRowHeight: 30.0,
            columns: [
              DataColumn(
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
              DataColumn(
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
                label: Text(
                  "Deaths",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
              )
            ],
            rows: List.generate(stateSnapshot.data.statewise.length - 1,
                (index) => _getDataRow(index + 1)),
          );
        });
  }
}
