import 'package:flutter/material.dart';

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
    formattedTime = formattedTime + "0" + "$time";
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
    content: Text("Tested data gets updated only after 9 PM everyday.",
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
