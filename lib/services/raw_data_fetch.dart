import "dart:async";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:covid_india_tracker/models/raw_data.dart";

class RawDataStats {
  RawDataStats();

  Future<RawDataset> getStats() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    var decodedJson = jsonDecode(res.body);

    RawDataset rawDataset = RawDataset.fromJson(decodedJson);

    return rawDataset;
  }
}
