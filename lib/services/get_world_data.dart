import "dart:async";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:covid_india_tracker/models/world_data_api.dart";

class GlobalStats {
  GlobalStats();

  Future<WorldStats> getStats() async {
    var response = await http.get("https://api.covid19api.com/summary");
    var decodedJson = jsonDecode(response.body);

    return WorldStats.fromJson(decodedJson);
  }
}
