class LoginModel {
  Meta? meta;
  Result? result;

  LoginModel({this.meta, this.result});

  LoginModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Meta {
  int? code;
  String? status;
  String? message;

  Meta({this.code, this.status, this.message});

  Meta.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Result {
  String? accessToken;
  String? tokenType;
  User? user;

  Result({this.accessToken, this.tokenType, this.user});

  Result.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  Null nik;
  Null city;
  Null address;
  Null religion;
  Null birthDate;
  Null phoneNumber;
  String? email;
  Null emailVerifiedAt;
  String? genderStatus;
  Null profilePhoto;
  Null ktpPhoto;
  Null noRekening;
  Null blacklistReason;
  Null blockDate;
  String? maritalStatus;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.nik,
      this.city,
      this.address,
      this.religion,
      this.birthDate,
      this.phoneNumber,
      this.email,
      this.emailVerifiedAt,
      this.genderStatus,
      this.profilePhoto,
      this.ktpPhoto,
      this.noRekening,
      this.blacklistReason,
      this.blockDate,
      this.maritalStatus,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nik = json['nik'];
    city = json['city'];
    address = json['address'];
    religion = json['religion'];
    birthDate = json['birth_date'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    genderStatus = json['gender_status'];
    profilePhoto = json['profile_photo'];
    ktpPhoto = json['ktp_photo'];
    noRekening = json['no_rekening'];
    blacklistReason = json['blacklist_reason'];
    blockDate = json['block_date'];
    maritalStatus = json['marital_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nik'] = nik;
    data['city'] = city;
    data['address'] = address;
    data['religion'] = religion;
    data['birth_date'] = birthDate;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['gender_status'] = genderStatus;
    data['profile_photo'] = profilePhoto;
    data['ktp_photo'] = ktpPhoto;
    data['no_rekening'] = noRekening;
    data['blacklist_reason'] = blacklistReason;
    data['block_date'] = blockDate;
    data['marital_status'] = maritalStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
