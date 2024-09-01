class NominalRealizationModel {
  int? idCategoryExpenditure;
  String? categoryExpenditureName;
  String? keterangan;
  String? nominalRealization;

  NominalRealizationModel(
      {this.idCategoryExpenditure,
      this.categoryExpenditureName,
      this.keterangan,
      this.nominalRealization});

  NominalRealizationModel.fromJson(Map<String, dynamic> json) {
    idCategoryExpenditure = json['id_category_expenditure'];
    categoryExpenditureName = json['category_expenditure_name'];
    keterangan = json['keterangan'];
    nominalRealization = json['nominal_realization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_category_expenditure'] = idCategoryExpenditure;
    data['category_expenditure_name'] = categoryExpenditureName;
    data['keterangan'] = keterangan;
    data['nominal_realization'] = nominalRealization;
    return data;
  }
}
