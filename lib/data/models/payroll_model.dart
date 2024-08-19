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
  List<Lines>? lines;

  Payrolls(
      {this.id,
      this.idEmployee,
      this.masterCategory,
      this.payrollDate,
      this.netAmount,
      this.lines});

  Payrolls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idEmployee = json['id_employee'];
    masterCategory = json['master_category'];
    payrollDate = json['payroll_date'];
    netAmount = json['net_amount'];
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_employee'] = idEmployee;
    data['master_category'] = masterCategory;
    data['payroll_date'] = payrollDate;
    data['net_amount'] = netAmount;
    if (lines != null) {
      data['lines'] = lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? lineMasterCategory;
  int? nominal;
  String? note;

  Lines({this.lineMasterCategory, this.nominal, this.note});

  Lines.fromJson(Map<String, dynamic> json) {
    lineMasterCategory = json['line_master_category'];
    nominal = json['nominal'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['line_master_category'] = lineMasterCategory;
    data['nominal'] = nominal;
    data['note'] = note;
    return data;
  }
}
