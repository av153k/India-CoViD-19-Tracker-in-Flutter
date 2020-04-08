import "dart:async";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:covid_india_tracker/models/raw_data.dart";

class RawDataStats {
  RawDataStats();

  Future<RawDataSet> getStats() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    var decodedJson = jsonDecode(res.body);

    RawDataSet rawDataset = RawDataSet.fromJson(decodedJson);

    return rawDataset;
  }
}
