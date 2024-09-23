class LoginModel {
  String? accessToken;
  String? tokenType;
  User? user;
  String? otpMessage;

  LoginModel({this.accessToken, this.tokenType, this.user, this.otpMessage});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    otpMessage = json['otp_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['otp_message'] = otpMessage;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  int? nik;
  String? city;
  String? address;
  String? religion;
  String? birthDate;
  String? phoneNumber;
  String? username;
  String? email;
  String? emailVerifiedAt;
  Null twoFactorConfirmedAt;
  String? genderStatus;
  String? profilePhoto;
  String? ktpPhoto;
  int? noRekening;
  String? blacklistReason;
  String? blockDate;
  String? maritalStatus;
  Null currentTeamId;
  Null profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.nik,
      this.city,
      this.address,
      this.religion,
      this.birthDate,
      this.phoneNumber,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.twoFactorConfirmedAt,
      this.genderStatus,
      this.profilePhoto,
      this.ktpPhoto,
      this.noRekening,
      this.blacklistReason,
      this.blockDate,
      this.maritalStatus,
      this.currentTeamId,
      this.profilePhotoPath,
      this.createdAt,
      this.updatedAt,
      this.profilePhotoUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    nik = json['nik'];
    city = json['city'];
    address = json['address'];
    religion = json['religion'];
    birthDate = json['birth_date'];
    phoneNumber = json['phone_number'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    genderStatus = json['gender_status'];
    profilePhoto = json['profile_photo'];
    ktpPhoto = json['ktp_photo'];
    noRekening = json['no_rekening'];
    blacklistReason = json['blacklist_reason'];
    blockDate = json['block_date'];
    maritalStatus = json['marital_status'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['nik'] = nik;
    data['city'] = city;
    data['address'] = address;
    data['religion'] = religion;
    data['birth_date'] = birthDate;
    data['phone_number'] = phoneNumber;
    data['username'] = username;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['gender_status'] = genderStatus;
    data['profile_photo'] = profilePhoto;
    data['ktp_photo'] = ktpPhoto;
    data['no_rekening'] = noRekening;
    data['blacklist_reason'] = blacklistReason;
    data['block_date'] = blockDate;
    data['marital_status'] = maritalStatus;
    data['current_team_id'] = currentTeamId;
    data['profile_photo_path'] = profilePhotoPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_photo_url'] = profilePhotoUrl;
    return data;
  }
}
