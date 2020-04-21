import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

var months = {"03": "March", "04": "April", "05": "May"};

String getFormattedDate(String fullDate) {
  String formattedDate;
  formattedDate = formattedDate + fullDate.substring(0, 2);
  formattedDate = formattedDate + months[fullDate.substring(3, 4)];

  return formattedDate;
}

String getFormattedTime(String fullDate) {
  String formattedTime = "";
  if (int.parse(fullDate.substring(11, 13)) > 12) {
    int time = int.parse(fullDate.substring(11, 13)) - 12;
    formattedTime = formattedTime + "$time";
  } else {
    formattedTime = formattedTime + fullDate.substring(11, 13);
  }
  formattedTime = formattedTime + fullDate.substring(13, 16);

  if (int.parse(fullDate.substring(11, 13)) > 12) {
    formattedTime = formattedTime + " PM";
  } else {
    formattedTime = formattedTime + " AM";
  }

  return formattedTime;
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      "OK",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Color(0xff212F3D),
    title: Text("Tested Info !", style: TextStyle(color: Colors.white)),
    content: Text("Tested data gets updated only after Midnight.",
        style: TextStyle(color: Colors.white)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Container getContainer(String string1, int int1, int int2, double width,
    BuildContext context, Color color1) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            blurRadius: 5.0,
            color: Color(0xff17202a),
            spreadRadius: 2.0,
            offset: Offset(8.0, 8.0))
      ],
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    height: 90,
    width: MediaQuery.of(context).size.width * width,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      color: Color(0xff212F3D),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            string1,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: color1, fontWeight: FontWeight.w300, fontSize: 18)),
            textAlign: TextAlign.center,
          ),
          if (int2 != null)
            Text(
              "+$int2",
              style: TextStyle(
                  color: color1, fontWeight: FontWeight.w300, fontSize: 14),
            ),
          Text(
            "$int1",
            style: TextStyle(
                color: color1, fontWeight: FontWeight.w300, fontSize: 17),
          ),
        ],
      ),
    ),
  );
}

Container getTested(int int1, int int2, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            blurRadius: 5.0,
            color: Color(0xff17202a),
            spreadRadius: 2.0,
            offset: Offset(8.0, 8.0))
      ],
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    height: 90,
    width: MediaQuery.of(context).size.width * 0.3,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      color: Color(0xff212F3D),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Tested",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.yellow,
                          fontSize: 18,
                          fontWeight: FontWeight.w300)),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Octicons.alert,
                  color: Colors.yellow,
                  size: 13,
                )
              ],
            ),
            onTap: () {
              showAlertDialog(context);
            },
          ),
          Text(
            "+$int2",
            style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.w300,
                fontSize: 14),
          ),
          Text(
            "$int1",
            style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.w300,
                fontSize: 17),
          )
        ],
      ),
    ),
  );
}

Container getButtons(String name, IconData icon, double height, double width,
    BuildContext context, Color color1, StatefulWidget state1) {
  return Container(
    height: MediaQuery.of(context).size.height * height,
    width: MediaQuery.of(context).size.width * width,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => state1,
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              color: color1,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                name,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

DataCell getDataCells(BuildContext context, double width, Column column1) {
  return DataCell(
    Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Color(0xff17202a),
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Container(
          decoration: BoxDecoration(
            color: Color(0xff212F3D),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * width,
          child: column1),
    ),
  );
}

DataColumn getDataColumn(String string1, Color color1) {
  return DataColumn(
    numeric: false,
    label: Text(
      string1,
      style: GoogleFonts.montserrat(
        textStyle:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: color1),
      ),
    ),
  );
}

DataColumn getDataColumn2(BuildContext context, String string1, Color color1) {
  return DataColumn(
    label: Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Color(0xff17202a),
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff212F3D),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          string1,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: color1,
            ),
          ),
        ),
      ),
    ),
  );
}

Column finalStats(int int1, int int2, Color color1) {
  if (int1 != 0) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          "\u{2B06} $int1",
          style: TextStyle(color: color1, fontSize: 13),
        ),
        Text(
          "$int2",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  } else {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "$int2",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

String getDate(int int1) {
  var date = DateTime.now();
  int day = date.day - int1;
  int month = date.month;
  int year = date.year;

  String tempdate =
      day.toString() + "/0" + month.toString() + "/" + year.toString();

  return tempdate;
}
