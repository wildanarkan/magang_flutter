import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nextbasis_hris/common/app_endpoint.dart';
import 'package:nextbasis_hris/data/models/login_model.dart';
import 'package:nextbasis_hris/data/models/payroll_model.dart';

class UserRepository extends GetxService {
  final storage = GetStorage();

  Future<LoginModel> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(AppEndpoint.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final loginModel = LoginModel.fromJson(data);
        return loginModel;
      } else {
        log(username);
        log(password);
        log('Login failed: ${response.statusCode}');
        return LoginModel();
      }
    } catch (e) {
      log(username);
      log(password);
      log('Error Login: $e');
      return LoginModel();
    }
  }

  Future<bool> verifyOtp(String email, String code) async {
    try {
      final token = storage.read('accessToken');
      final response = await http.post(
        Uri.parse(AppEndpoint.verifyOtp),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'email': email,
          'otp': code,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Login failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log(email);
      log(code);
      log('Error Login: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllUser() async {
    final token = storage.read('accessToken');
    final response = await http.get(
      Uri.parse(AppEndpoint.allUser),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load data user');
    }
  }

  Future<Map<String, dynamic>> checkInOut(
      double latitude, double longitude) async {
    final token = storage.read('accessToken');
    log(latitude.toString());
    log(longitude.toString());
    final response = await http.post(
      Uri.parse(AppEndpoint.checkInActivity),
      body: json.encode({
        'latitude': latitude,
        'longtitude': longitude,
      }),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 400) {
      final data = json.decode(response.body);
      throw Exception(data['message']);
    } else {
      throw Exception('An unexpected error occurred');
    }
  }

  Future<List<Map<String, dynamic>>> fetchCheckinToday(String userId) async {
    final token = storage.read('accessToken');
    final response = await http.get(
      Uri.parse('${AppEndpoint.checkInToday}$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load check-in data');
    }
  }

  Future<String?> updateProfilePhoto(String imagePath) async {
    try {
      final uri = Uri.parse(AppEndpoint.updatePhoto);
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] =
            'Bearer ${GetStorage().read('accessToken')}'
        ..files
            .add(await http.MultipartFile.fromPath('profile_photo', imagePath));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);

        if (data.containsKey('profile_photo_url')) {
          return data['profile_photo_url'];
        } else {
          log('Invalid response format');
          return null;
        }
      } else {
        log('Failed to update profile photo. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error updating profile photo: $e');
      return null;
    }
  }

  Future<bool> editProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String city,
    required String address,
  }) async {
    final token = storage.read('accessToken');
    final response = await http.post(
      Uri.parse(AppEndpoint.editprofile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'city': city,
        'address': address,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final token = storage.read('accessToken');
    final response = await http.post(
      Uri.parse(AppEndpoint.changePassword),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception('Please enter the correct current password.');
    } else {
      throw Exception('Failed to change password');
    }
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse(AppEndpoint.user),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchProfileData(int id) async {
    final String url = '${AppEndpoint.profile}$id';

    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      throw Exception('Error fetching profile data: $e');
    }
  }

  Future<List<Payrolls>> fetchPayrolls() async {
    final userId = storage.read('userId');
    if (userId == null) {
      print('User ID not found');
      return [];
    }

    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse('${AppEndpoint.payrolls}$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['payrolls'] != null) {
          final payrollModel = PayrollModel.fromJson(data);
          return payrollModel.payrolls ?? [];
        }
      } else {
        print('Failed to load payroll data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return [];
  }

  Future<Payrolls?> fetchPayrollDetail(String payrollId) async {
    final token = storage.read('accessToken');
    final url = '${AppEndpoint.payroll}$payrollId';

    try {
      print('Fetching payroll detail from: $url'); // Log URL endpoint
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data received: $data');
        if (data['payroll'] != null) {
          return Payrolls.fromJson(data['payroll']);
        }
      } else {
        print('Failed to load payroll detail data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchContracts() async {
    final userId = storage.read('userId');
    if (userId == null) {
      print('User ID not found');
      return [];
    }

    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse('${AppEndpoint.contract}$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['contracts'] is List) {
          return List<Map<String, dynamic>>.from(data['contracts']);
        }
      } else {
        print('Failed to load contract data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return [];
  }
}
