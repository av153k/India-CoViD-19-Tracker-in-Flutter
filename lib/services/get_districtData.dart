import "dart:async";
import 'package:covid_india_tracker/models/district_data.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class DistrictWiseStats {
  DistrictWiseStats();

  Future<Districts> getStats() async {
    var res = await http.get("https://api.covid19india.org/v2/state_district_wise.json");
    var decodedJson = jsonDecode(res.body);

    Districts districtStats = Districts.fromJson(decodedJson[0]);

    return districtStats;
  }
}
