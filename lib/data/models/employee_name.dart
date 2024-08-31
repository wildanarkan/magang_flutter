class EmployeeName {
  int? id;
  String? fullName;

  EmployeeName({this.id, this.fullName});

  EmployeeName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    return data;
  }
}
