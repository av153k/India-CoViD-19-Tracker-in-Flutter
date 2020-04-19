import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PatientsInfo {
  final int patientIindex;
  final String gender;
  final String ageBracket;
  final String nationality;
  final String currentStatus;

  PatientsInfo(
      {this.patientIindex, this.ageBracket, this.gender, this.nationality, this.currentStatus});
}

class PatientsAnalysis extends StatefulWidget {
  _PatientsAnalysis createState() => _PatientsAnalysis();
}

class _PatientsAnalysis extends State<PatientsAnalysis> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Patients Analysis"),
          backgroundColor: Color(0xff17202a),
        ),
      ),
    );
  }
}
