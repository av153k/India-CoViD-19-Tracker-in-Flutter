import "dart:async";
import 'package:covid_india_tracker/models/district_data.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class DistrictWiseStats {
  DistrictWiseStats();

  Future<List<DistrictData>> getStats(String state) async {
    var res = await http
        .get("https://api.covid19india.org/v2/state_district_wise.json");
    var decodedJson = jsonDecode(res.body);

    for (var i = 0; i <= 33; i++) {
      if (Districts.fromJson(decodedJson[i]).state == state) {
        return Districts.fromJson(decodedJson[i]).districtData;
      }
    }
  }
}
