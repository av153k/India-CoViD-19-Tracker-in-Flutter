import "dart:async";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:covid_india_tracker/models/data_api.dart";

class CovidIndiaStats {
  CovidIndiaStats();

  Future<CovidIndia> getStats() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    var decodedJson = jsonDecode(res.body);

    CovidIndia indiaStats = CovidIndia.fromJson(decodedJson);

    return indiaStats;
  }
}
