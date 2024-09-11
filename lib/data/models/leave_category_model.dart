class LeaveCategoryModel {
  int? id;
  String? type;
  String? limit;
  String? name;
  String? createdAt;
  String? updatedAt;

  LeaveCategoryModel(
      {this.id,
      this.type,
      this.limit,
      this.name,
      this.createdAt,
      this.updatedAt});

  LeaveCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    limit = json['limit'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['limit'] = limit;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
