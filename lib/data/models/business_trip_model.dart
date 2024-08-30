class BusinessTripModel {
  int? idBusinessTrip;
  String? companyName;
  String? cityName;
  String? startDate;
  String? endDate;
  String? status;
  String? companyAddress;
  String? departureFrom;
  String? pic;
  String? picRole;
  String? picPhone;
  int? extendDay;
  List<Users>? users;

  BusinessTripModel(
      {this.idBusinessTrip,
      this.companyName,
      this.cityName,
      this.startDate,
      this.endDate,
      this.status,
      this.companyAddress,
      this.departureFrom,
      this.pic,
      this.picRole,
      this.picPhone,
      this.extendDay,
      this.users});

  BusinessTripModel.fromJson(Map<String, dynamic> json) {
    idBusinessTrip = json['id_business_trip'];
    companyName = json['company_name'];
    cityName = json['city_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    companyAddress = json['company_address'];
    departureFrom = json['departure_from'];
    pic = json['pic'];
    picRole = json['pic_role'];
    picPhone = json['pic_phone'];
    extendDay = json['extend_day'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_business_trip'] = idBusinessTrip;
    data['company_name'] = companyName;
    data['city_name'] = cityName;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['company_address'] = companyAddress;
    data['departure_from'] = departureFrom;
    data['pic'] = pic;
    data['pic_role'] = picRole;
    data['pic_phone'] = picPhone;
    data['extend_day'] = extendDay;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? fullName;

  Users({this.id, this.fullName});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    return data;
  }
}
