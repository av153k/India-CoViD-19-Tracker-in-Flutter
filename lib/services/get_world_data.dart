import "dart:async";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:covid_india_tracker/models/world_data_api.dart";

class GlobalStats {
  GlobalStats();

  Future<WorldStats> getStats() async {
    var response =
        await http.get("https://api.thevirustracker.com/free-api?global=stats");
    var decodedJson = jsonDecode(response.body);

    return WorldStats.fromJson(decodedJson);
  }
}
