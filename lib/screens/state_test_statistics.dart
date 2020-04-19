import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/models/states_tested.dart";
import "package:covid_india_tracker/services/get_state_tested.dart";

StatesMiscData _stateTested = new StatesMiscData();

class StateTest extends StatefulWidget {
  final String state;

  StateTest({Key key, @required this.state}) : super(key: key);

  _StateTest createState() => _StateTest();
}

class _StateTest extends State<StateTest> {
  Future<StatesTestedData> getSingleStateData() {
    return _stateTested.getStats(widget.state);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSingleStateData(),
        builder:
            (BuildContext context, AsyncSnapshot<StatesTestedData> testedSnap) {
          if (testedSnap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          Text getTestedData() {
            if (testedSnap.data == null) {
              return Text("Not Available",
                  style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.w300,
                      fontSize: 15));
            } else {
              return Text(
                "Not Available",
                style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w300,
                    fontSize: 17),
              );
            }
          }

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
                  Text(
                    "Tested",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.yellow,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    " ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 14),
                  ),
                  getTestedData()
                ],
              ),
            ),
          );
        });
  }
}
