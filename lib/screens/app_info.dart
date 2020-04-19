import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter_icons/flutter_icons.dart";
import "package:url_launcher/url_launcher.dart";
import "package:google_fonts/google_fonts.dart";

class AppInfo extends StatefulWidget {
  _AppInfo createState() => new _AppInfo();
}

class _AppInfo extends State<AppInfo> {
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
          title: Text("App Info"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: Text(
                            "Data Source Links",
                            style: GoogleFonts.montserrat(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0xff17202a),
                                spreadRadius: 3.0,
                              )
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: Color(0xff212F3D),
                            ),
                            child: InkWell(
                              onTap: () {
                                launch("http://patientdb.covid19india.org/");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(Octicons.database, color: Colors.green),
                                  Text(
                                    "Crowdsourced Patient Database",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0xff17202a),
                                spreadRadius: 3.0,
                              )
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: Color(0xff212F3D),
                            ),
                            child: InkWell(
                              onTap: () {
                                launch("https://icmr.nic.in/content/covid-19");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(Octicons.link, color: Colors.yellow),
                                  Text(
                                    "Tested individuals data source",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: Text(
                            "API Details",
                            style: GoogleFonts.montserrat(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0xff17202a),
                                spreadRadius: 3.0,
                              )
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: Color(0xff212F3D),
                            ),
                            child: InkWell(
                              onTap: () {
                                launch("https://github.com/covid19india/api");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(Octicons.mark_github,
                                      color: Colors.white),
                                  Text(
                                    "India Stats API            ",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0xff17202a),
                                spreadRadius: 3.0,
                              )
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: Color(0xff212F3D),
                            ),
                            child: InkWell(
                              onTap: () {
                                launch("https://covid19api.com/");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Ionicons.md_link,
                                    color: Colors.yellow,
                                    size: 25,
                                  ),
                                  Text(
                                    "Global Stats API            ",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: Text(
                            "Developer Info",
                            style: GoogleFonts.montserrat(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 3.0,
                                  )
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Color(0xff212F3D),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    launch("https://github.com/code-ninza");
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Octicons.mark_github,
                                          color: Colors.white),
                                      Text(
                                        "GitHub",
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 3.0,
                                  )
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Color(0xff212F3D),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    launch("https://www.linkedin.com/in/av153k/");
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Ionicons.logo_linkedin,
                                          color: Colors.blue[800]),
                                      Text(
                                        "LinkedIn",
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 3.0,
                                  )
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Color(0xff212F3D),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    launch("https://www.facebook.com/av153k");
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        Ionicons.logo_facebook,
                                        color: Colors.blue,
                                        size: 25,
                                      ),
                                      Text(
                                        "Connect",
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0xff17202a),
                                    spreadRadius: 3.0,
                                  )
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Color(0xff212F3D),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    launch(
                                        "https://www.instagram.com/avishek.py/");
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Ionicons.logo_instagram,
                                          color: Colors.redAccent),
                                      Text(
                                        "Instagram",
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
