import 'package:covid_india_tracker/screens/statewise_stats.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class DrawerContent extends StatefulWidget {
  _DrawerContentState createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        elevation: 50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
                child: Text("App Features",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                    textAlign: TextAlign.center),
              ),
            ),
            ListTile(
              leading: Icon(Icons.table_chart, color: Colors.teal),
              title: Text(
                "StateWise Stats",
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StateWiseStats(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.multiline_chart,
                color: Colors.red,
              ),
              title: Text(
                "Spread Trends",
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: Colors.cyan,
              ),
              title: Text(
                "Patients Information",
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.blueAccent,
              ),
              title: Text(
                "World Stats",
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.green),
              title: Text(
                "App Info",
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
