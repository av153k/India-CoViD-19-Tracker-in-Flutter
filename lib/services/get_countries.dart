import "dart:async";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:covid_india_tracker/models/global_countries_api.dart";

class CountrieStats {
  CountrieStats();

  Future<CountriesStats> getStats() async {
    var response =
        await http.get("https://corona.lmao.ninja/v2/countries?sort=country");
    var decodedJson = jsonDecode(response.body);

    return CountriesStats.fromJson(decodedJson);
  }
}
