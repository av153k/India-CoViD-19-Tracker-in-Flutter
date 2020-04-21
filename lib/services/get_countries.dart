import "dart:async";
import 'package:covid_india_tracker/models/world_data_api.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "package:covid_india_tracker/models/global_countries_api.dart";

class Country {
  final String code;
  final String name;

  Country({@required this.code, @required this.name});
}

class CountryStats {
  CountryStats();

  var endpoint = "https://corona.lmao.ninja/v2/countries?sort=country";

  Future<List<Country>> getCountryList() async {
    var response = await http.get(endpoint);
    var decodedJson = jsonDecode(response.body);

    List<Country> countryList = [];

    for (var i = 0; i < decodedJson.length; i++) {
      countryList.add(
        Country(
          code: CountriesStats.fromJson(decodedJson[i]).countryInfo.iso2,
          name: CountriesStats.fromJson(decodedJson[i]).country,
        ),
      );
    }
    return countryList;
  }
}
