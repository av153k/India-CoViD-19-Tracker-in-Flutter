import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/screens/india_stats.dart";
import "package:syncfusion_flutter_core/core.dart";

void main() {
  SyncfusionLicense.registerLicense(
      "NT8mJyc2IWhia31ifWN9Z2FoYmF8YGJ8ampqanNiYmlmamlmanMDHmg6DCc7Oj04DCAyPSYTOzwnPjI6P30wPD4=");
  return runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff212F3D),
        appBar: AppBar(
          backgroundColor: Color(0xff17202a),
          title: Text(
            "CoViD-19 Tracker",
            style: GoogleFonts.montserrat(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
            ),
            textScaleFactor: 1.0,
          ),
        ),
        body: IndiaStats(),
      ),
    );
  }
}
