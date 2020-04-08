class GlobalData {
  AllRoute allRoute;
  AllRoute countriesRoute;
  AllRoute countryStatusDayOneLiveRoute;
  AllRoute countryStatusDayOneRoute;
  AllRoute countryStatusDayOneTotalRoute;
  AllRoute countryStatusLiveRoute;
  AllRoute countryStatusRoute;
  AllRoute countryStatusTotalRoute;
  AllRoute exportRoute;
  AllRoute liveCountryStatusAfterDateRoute;
  AllRoute liveCountryStatusRoute;
  AllRoute summaryRoute;
  AllRoute webhookRoute;

  GlobalData(
      {this.allRoute,
      this.countriesRoute,
      this.countryStatusDayOneLiveRoute,
      this.countryStatusDayOneRoute,
      this.countryStatusDayOneTotalRoute,
      this.countryStatusLiveRoute,
      this.countryStatusRoute,
      this.countryStatusTotalRoute,
      this.exportRoute,
      this.liveCountryStatusAfterDateRoute,
      this.liveCountryStatusRoute,
      this.summaryRoute,
      this.webhookRoute});

  GlobalData.fromJson(Map<String, dynamic> json) {
    allRoute = json['allRoute'] != null
        ? new AllRoute.fromJson(json['allRoute'])
        : null;
    countriesRoute = json['countriesRoute'] != null
        ? new AllRoute.fromJson(json['countriesRoute'])
        : null;
    countryStatusDayOneLiveRoute = json['countryStatusDayOneLiveRoute'] != null
        ? new AllRoute.fromJson(json['countryStatusDayOneLiveRoute'])
        : null;
    countryStatusDayOneRoute = json['countryStatusDayOneRoute'] != null
        ? new AllRoute.fromJson(json['countryStatusDayOneRoute'])
        : null;
    countryStatusDayOneTotalRoute =
        json['countryStatusDayOneTotalRoute'] != null
            ? new AllRoute.fromJson(json['countryStatusDayOneTotalRoute'])
            : null;
    countryStatusLiveRoute = json['countryStatusLiveRoute'] != null
        ? new AllRoute.fromJson(json['countryStatusLiveRoute'])
        : null;
    countryStatusRoute = json['countryStatusRoute'] != null
        ? new AllRoute.fromJson(json['countryStatusRoute'])
        : null;
    countryStatusTotalRoute = json['countryStatusTotalRoute'] != null
        ? new AllRoute.fromJson(json['countryStatusTotalRoute'])
        : null;
    exportRoute = json['exportRoute'] != null
        ? new AllRoute.fromJson(json['exportRoute'])
        : null;
    liveCountryStatusAfterDateRoute =
        json['liveCountryStatusAfterDateRoute'] != null
            ? new AllRoute.fromJson(json['liveCountryStatusAfterDateRoute'])
            : null;
    liveCountryStatusRoute = json['liveCountryStatusRoute'] != null
        ? new AllRoute.fromJson(json['liveCountryStatusRoute'])
        : null;
    summaryRoute = json['summaryRoute'] != null
        ? new AllRoute.fromJson(json['summaryRoute'])
        : null;
    webhookRoute = json['webhookRoute'] != null
        ? new AllRoute.fromJson(json['webhookRoute'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allRoute != null) {
      data['allRoute'] = this.allRoute.toJson();
    }
    if (this.countriesRoute != null) {
      data['countriesRoute'] = this.countriesRoute.toJson();
    }
    if (this.countryStatusDayOneLiveRoute != null) {
      data['countryStatusDayOneLiveRoute'] =
          this.countryStatusDayOneLiveRoute.toJson();
    }
    if (this.countryStatusDayOneRoute != null) {
      data['countryStatusDayOneRoute'] = this.countryStatusDayOneRoute.toJson();
    }
    if (this.countryStatusDayOneTotalRoute != null) {
      data['countryStatusDayOneTotalRoute'] =
          this.countryStatusDayOneTotalRoute.toJson();
    }
    if (this.countryStatusLiveRoute != null) {
      data['countryStatusLiveRoute'] = this.countryStatusLiveRoute.toJson();
    }
    if (this.countryStatusRoute != null) {
      data['countryStatusRoute'] = this.countryStatusRoute.toJson();
    }
    if (this.countryStatusTotalRoute != null) {
      data['countryStatusTotalRoute'] = this.countryStatusTotalRoute.toJson();
    }
    if (this.exportRoute != null) {
      data['exportRoute'] = this.exportRoute.toJson();
    }
    if (this.liveCountryStatusAfterDateRoute != null) {
      data['liveCountryStatusAfterDateRoute'] =
          this.liveCountryStatusAfterDateRoute.toJson();
    }
    if (this.liveCountryStatusRoute != null) {
      data['liveCountryStatusRoute'] = this.liveCountryStatusRoute.toJson();
    }
    if (this.summaryRoute != null) {
      data['summaryRoute'] = this.summaryRoute.toJson();
    }
    if (this.webhookRoute != null) {
      data['webhookRoute'] = this.webhookRoute.toJson();
    }
    return data;
  }
}

class AllRoute {
  String name;
  String description;
  String path;

  AllRoute({this.name, this.description, this.path});

  AllRoute.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    path = json['Path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Path'] = this.path;
    return data;
  }
}
