class BusinessCalculateModel {
  int? idBusinessTrip;
  String? totalNominalPlanning;
  String? totalNominalRealization;
  String? difference;

  BusinessCalculateModel(
      {this.idBusinessTrip,
      this.totalNominalPlanning,
      this.totalNominalRealization,
      this.difference});

  BusinessCalculateModel.fromJson(Map<String, dynamic> json) {
    idBusinessTrip = json['id_business_trip'];
    totalNominalPlanning = json['total_nominal_planning'];
    totalNominalRealization = json['total_nominal_realization'];
    difference = json['difference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_business_trip'] = idBusinessTrip;
    data['total_nominal_planning'] = totalNominalPlanning;
    data['total_nominal_realization'] = totalNominalRealization;
    data['difference'] = difference;
    return data;
  }
}
