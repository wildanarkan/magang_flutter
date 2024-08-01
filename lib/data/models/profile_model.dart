class ProfileModel {
  String? firstName;
  String? lastName;
  String? gender;
  String? religion;
  String? phoneNumber;
  String? address;
  String? email;
  String? profilePhoto;
  int? role;
  int? employeeGroup;
  int? position;
  int? nip;

  ProfileModel(
      {this.firstName,
      this.lastName,
      this.gender,
      this.religion,
      this.phoneNumber,
      this.address,
      this.email,
      this.profilePhoto,
      this.role,
      this.employeeGroup,
      this.position,
      this.nip});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    religion = json['religion'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    email = json['email'];
    profilePhoto = json['profile_photo'];
    role = json['role'];
    employeeGroup = json['employee_group'];
    position = json['position'];
    nip = json['nip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['religion'] = religion;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['email'] = email;
    data['profile_photo'] = profilePhoto;
    data['role'] = role;
    data['employee_group'] = employeeGroup;
    data['position'] = position;
    data['nip'] = nip;
    return data;
  }
}
