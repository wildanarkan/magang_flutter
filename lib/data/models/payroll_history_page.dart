class PayrollModel {
  List<Payrolls>? payrolls;

  PayrollModel({this.payrolls});

  PayrollModel.fromJson(Map<String, dynamic> json) {
    if (json['payrolls'] != null) {
      payrolls = <Payrolls>[];
      json['payrolls'].forEach((v) {
        payrolls!.add(Payrolls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payrolls != null) {
      data['payrolls'] = payrolls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payrolls {
  int? id;
  int? idEmployee;
  String? masterCategory;
  String? payrollDate;
  int? netAmount;

  Payrolls(
      {this.id,
      this.idEmployee,
      this.masterCategory,
      this.payrollDate,
      this.netAmount});

  Payrolls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idEmployee = json['id_employee'];
    masterCategory = json['master_category'];
    payrollDate = json['payroll_date'];
    netAmount = json['net_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_employee'] = idEmployee;
    data['master_category'] = masterCategory;
    data['payroll_date'] = payrollDate;
    data['net_amount'] = netAmount;
    return data;
  }
}
