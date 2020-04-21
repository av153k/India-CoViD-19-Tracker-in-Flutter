import 'package:covid_india_tracker/models/raw_data.dart';
import 'package:covid_india_tracker/services/raw_data_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

RawDataStats _rawDataStats = new RawDataStats();

class PatientsInfo {
  final int male;
  final int female;
  final int unknown1;
  final String nationality;
  final int deceased;
  final int recovered;

  PatientsInfo(
      {this.male,
      this.female,
      this.unknown1,
      this.nationality,
      this.deceased,
      this.recovered});
}

class PatientsAnalysis extends StatefulWidget {
  _PatientsAnalysis createState() => _PatientsAnalysis();
}

class _PatientsAnalysis extends State<PatientsAnalysis> {
  Future<RawDataSet> rawData;

  Future<RawDataSet> getRawData() {
    return _rawDataStats.getStats();
  }

  @override
  void initState() {
    super.initState();
    rawData = getRawData();
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
            "Patients Analysis",
            style: GoogleFonts.montserrat(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xff17202a),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  setState(() {
                    rawData = getRawData();
                  });
                })
          ],
        ),
        body: FutureBuilder(
            future: rawData,
            builder: (BuildContext context, AsyncSnapshot<RawDataSet> rawSnap) {
              if (rawSnap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: <Widget>[],
              );
            }),
      ),
    );
  }
}
