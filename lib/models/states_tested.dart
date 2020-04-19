class StateTested {
  List<StatesTestedData> statesTestedData;

  StateTested({this.statesTestedData});

  StateTested.fromJson(Map<String, dynamic> json) {
    if (json['states_tested_data'] != null) {
      statesTestedData = new List<StatesTestedData>();
      json['states_tested_data'].forEach((v) {
        statesTestedData.add(new StatesTestedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statesTestedData != null) {
      data['states_tested_data'] =
          this.statesTestedData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatesTestedData {
  String negative;
  String numcallsstatehelpline;
  String numicubeds;
  String numisolationbeds;
  String numventilators;
  String positive;
  String positiveratebytests;
  String source;
  String source2;
  String state;
  String testsperthousand;
  String totalpeopleinquarantine;
  String totalpeoplereleasedfromquarantine;
  String totaltested;
  String unconfirmed;
  String updatedon;

  StatesTestedData(
      {this.negative,
      this.numcallsstatehelpline,
      this.numicubeds,
      this.numisolationbeds,
      this.numventilators,
      this.positive,
      this.positiveratebytests,
      this.source,
      this.source2,
      this.state,
      this.testsperthousand,
      this.totalpeopleinquarantine,
      this.totalpeoplereleasedfromquarantine,
      this.totaltested,
      this.unconfirmed,
      this.updatedon});

  StatesTestedData.fromJson(Map<String, dynamic> json) {
    negative = json['negative'];
    numcallsstatehelpline = json['numcallsstatehelpline'];
    numicubeds = json['numicubeds'];
    numisolationbeds = json['numisolationbeds'];
    numventilators = json['numventilators'];
    positive = json['positive'];
    positiveratebytests = json['positiveratebytests'];
    source = json['source'];
    source2 = json['source2'];
    state = json['state'];
    testsperthousand = json['testsperthousand'];
    totalpeopleinquarantine = json['totalpeopleinquarantine'];
    totalpeoplereleasedfromquarantine =
        json['totalpeoplereleasedfromquarantine'];
    totaltested = json['totaltested'];
    unconfirmed = json['unconfirmed'];
    updatedon = json['updatedon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['negative'] = this.negative;
    data['numcallsstatehelpline'] = this.numcallsstatehelpline;
    data['numicubeds'] = this.numicubeds;
    data['numisolationbeds'] = this.numisolationbeds;
    data['numventilators'] = this.numventilators;
    data['positive'] = this.positive;
    data['positiveratebytests'] = this.positiveratebytests;
    data['source'] = this.source;
    data['source2'] = this.source2;
    data['state'] = this.state;
    data['testsperthousand'] = this.testsperthousand;
    data['totalpeopleinquarantine'] = this.totalpeopleinquarantine;
    data['totalpeoplereleasedfromquarantine'] =
        this.totalpeoplereleasedfromquarantine;
    data['totaltested'] = this.totaltested;
    data['unconfirmed'] = this.unconfirmed;
    data['updatedon'] = this.updatedon;
    return data;
  }
}
