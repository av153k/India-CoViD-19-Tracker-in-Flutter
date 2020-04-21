import "dart:async";
import 'package:covid_india_tracker/assets/common_functions.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "package:covid_india_tracker/models/states_tested.dart";

class StatesMiscData {
  StatesMiscData();

  Future<StatesTestedData> getStats(String stateName) async {
    var response =
        await http.get("https://api.covid19india.org/state_test_data.json");
    var decodedJson = jsonDecode(response.body);

    StateTested allStates = StateTested.fromJson(decodedJson);

    for (var i = 0; i < allStates.statesTestedData.length; i++) {
      if (allStates.statesTestedData[i].state == stateName && allStates.statesTestedData[i].updatedon == getDate(1)) {
        return allStates.statesTestedData[i];
      }
    }
  }
}
