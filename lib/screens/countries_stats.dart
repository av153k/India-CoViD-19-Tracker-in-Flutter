import "package:flutter/material.dart";

class Countries extends StatefulWidget {
  _Countries createState() => _Countries();
}

class _Countries extends State<Countries> {
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
          title: Text("Global Stats"),
          backgroundColor: Color(0xff17202a),
        ),
      ),
    );
  }
}
