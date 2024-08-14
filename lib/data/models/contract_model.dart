class ContractModel {
  Contract? contract;

  ContractModel({this.contract});

  ContractModel.fromJson(Map<String, dynamic> json) {
    contract = json['contract'] != null
        ? Contract.fromJson(json['contract'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contract != null) {
      data['contract'] = contract!.toJson();
    }
    return data;
  }
}

class Contract {
  String? status;
  String? startDate;
  String? endDate;

  Contract({this.status, this.startDate, this.endDate});

  Contract.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}
