class NominalPlanningModel {
  int? idCategoryExpenditure;
  String? categoryExpenditureName;
  String? keterangan;
  String? nominalPlanning;

  NominalPlanningModel(
      {this.idCategoryExpenditure,
      this.categoryExpenditureName,
      this.keterangan,
      this.nominalPlanning});

  NominalPlanningModel.fromJson(Map<String, dynamic> json) {
    idCategoryExpenditure = json['id_category_expenditure'];
    categoryExpenditureName = json['category_expenditure_name'];
    keterangan = json['keterangan'];
    nominalPlanning = json['nominal_planning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_category_expenditure'] = idCategoryExpenditure;
    data['category_expenditure_name'] = categoryExpenditureName;
    data['keterangan'] = keterangan;
    data['nominal_planning'] = nominalPlanning;
    return data;
  }
}
