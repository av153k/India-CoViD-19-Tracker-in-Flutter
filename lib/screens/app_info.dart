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
          children: <Widget>[],
        ),
      ),
    );
  }
}
