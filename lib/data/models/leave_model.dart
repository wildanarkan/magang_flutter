class LeaveModel {
  List<Leaves>? leaves;

  LeaveModel({this.leaves});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    if (json['leaves'] != null) {
      leaves = <Leaves>[];
      json['leaves'].forEach((v) {
        leaves!.add(Leaves.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaves != null) {
      data['leaves'] = leaves!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leaves {
  int? id;
  int? idUser;
  String? firstName;
  String? lastName;
  int? nip;
  String? leaveCategory;
  String? reasonForLeave;
  String? startDate;
  String? endDate;
  String? status;

  Leaves(
      {this.id,
      this.idUser,
      this.firstName,
      this.lastName,
      this.nip,
      this.leaveCategory,
      this.reasonForLeave,
      this.startDate,
      this.endDate,
      this.status});

  Leaves.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    nip = json['nip'];
    leaveCategory = json['leave_category'];
    reasonForLeave = json['reason_for_leave'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_user'] = idUser;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['nip'] = nip;
    data['leave_category'] = leaveCategory;
    data['reason_for_leave'] = reasonForLeave;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    return data;
  }
}
