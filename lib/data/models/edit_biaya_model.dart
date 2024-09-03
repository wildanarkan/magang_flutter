class EditBiayaModel {
  int? idBusinessTrip;
  int? idCategoryExpenditure;
  int? nominal;
  String? photoProof;
  String? keterangan;

  EditBiayaModel(
      {this.idBusinessTrip,
      this.idCategoryExpenditure,
      this.nominal,
      this.photoProof,
      this.keterangan});

  EditBiayaModel.fromJson(Map<String, dynamic> json) {
    idBusinessTrip = json['id_business_trip'];
    idCategoryExpenditure = json['id_category_expenditure'];
    nominal = json['nominal'];
    photoProof = json['photo_proof'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_business_trip'] = idBusinessTrip;
    data['id_category_expenditure'] = idCategoryExpenditure;
    data['nominal'] = nominal;
    data['photo_proof'] = photoProof;
    data['keterangan'] = keterangan;
    return data;
  }
}
