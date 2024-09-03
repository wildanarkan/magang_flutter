class NominalModel {
  int? id;
  int? idCategoryExpenditure;
  String? categoryExpenditureName;
  String? keterangan;
  int? nominal;

  NominalModel(
      {this.id,
      this.idCategoryExpenditure,
      this.categoryExpenditureName,
      this.keterangan,
      this.nominal});

  NominalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCategoryExpenditure = json['id_category_expenditure'];
    categoryExpenditureName = json['category_expenditure_name'];
    keterangan = json['keterangan'];
    nominal = json['nominal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_category_expenditure'] = idCategoryExpenditure;
    data['category_expenditure_name'] = categoryExpenditureName;
    data['keterangan'] = keterangan;
    data['nominal'] = nominal;
    return data;
  }
}
