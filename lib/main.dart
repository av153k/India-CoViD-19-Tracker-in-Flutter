import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/screens/india_stats.dart";
import "package:covid_india_tracker/screens/drawer.dart";

void main() => runApp(HomePage());

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
          backgroundColor: Color(0xff212F3D),
          title: Text(
            "India CoViD-19 Tracker",
            style: GoogleFonts.montserrat(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
        ),
        drawer: DrawerContent(),
        body: IndiaStats(),
      ),
    );
  }
}
