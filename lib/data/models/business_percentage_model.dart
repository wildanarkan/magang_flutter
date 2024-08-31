class BusinessPercentageModel {
  int? idCategoryExpenditure;
  String? categoryName;
  String? totalNominalPlanning;
  String? totalNominalRealization;
  String? percentage;

  BusinessPercentageModel(
      {this.idCategoryExpenditure,
      this.categoryName,
      this.totalNominalPlanning,
      this.totalNominalRealization,
      this.percentage});

  BusinessPercentageModel.fromJson(Map<String, dynamic> json) {
    idCategoryExpenditure = json['id_category_expenditure'];
    categoryName = json['category_name'];
    totalNominalPlanning = json['total_nominal_planning'];
    totalNominalRealization = json['total_nominal_realization'];
    percentage = json['percentage'];
  }

  get title => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_category_expenditure'] = idCategoryExpenditure;
    data['category_name'] = categoryName;
    data['total_nominal_planning'] = totalNominalPlanning;
    data['total_nominal_realization'] = totalNominalRealization;
    data['percentage'] = percentage;
    return data;
  }
}
