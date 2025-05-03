import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nextbasis_hris/common/app_endpoint.dart';
import 'package:nextbasis_hris/data/models/business_trip_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BusinessTripRepository extends GetxService {
  final storage = GetStorage();

  Future<List<BusinessTripModel>> fetchCurrent() async {
    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse(AppEndpoint.tripToday),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((json) => BusinessTripModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load business trips');
      }
    } catch (e) {
      throw Exception('Error fetching business trips: $e');
    }
  }

  Future<List<BusinessTripModel>> fetchAll() async {
    try {
      final token = storage.read('accessToken');
      final response = await http.get(
        Uri.parse(AppEndpoint.business),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((json) => BusinessTripModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load business trips');
      }
    } catch (e) {
      throw Exception('Error fetching business trips: $e');
    }
  }

  Future<dynamic> postTrip({
    required int idCompanyCity,
    required String note,
    required String startDate,
    required String endDate,
    required String departure,
  }) async {
    final token = storage.read('accessToken');
    final response = await http.post(
      Uri.parse(AppEndpoint.postBusinessTrip),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "id_company_city": idCompanyCity,
        "note": note,
        "start_date": startDate,
        "end_date": endDate,
        "departure_from": departure,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post trip');
    }
  }

  Future<bool> postTripDetail({
    required int idTrip,
    required List employeeList,
  }) async {
    final token = storage.read('accessToken');
    final response = await http.post(
      Uri.parse(AppEndpoint.postTripdetail),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "id_business_trip": idTrip,
        "id_user": employeeList,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      throw Exception('Failed to post trip detail');
    }
  }

  Future<void> updateExtendedDay(int businessTripId, int newExtendDay) async {
    try {
      final token = GetStorage().read('accessToken');
      final url = Uri.parse('${AppEndpoint.updateExtendedDay}$businessTripId');
      print('URL: $url');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'extend_day': newExtendDay,
        }),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to update extend: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<String> updatePhotoDocument(File file, int businessTripId) async {
    try {
      final token = GetStorage().read('accessToken');
      final url = Uri.parse('${AppEndpoint.postPhotoDocument}$businessTripId');
      final request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseBody);
        return jsonData['file_name']; // Return file name to controller
      } else {
        throw Exception('Failed to update file: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> getPhotoDocument(String url, String fileName) async {
    try {
      // Mendapatkan direktori dokumen aplikasi
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');

      // Mengunduh file dari URL
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);
      // final result = await OpenFile.open(file.path);
      // Membuka file yang telah diunduh
      // OpenFile.open(file.path);
      requestPermissionAndOpen(file.path);
      // print('OpenFile result: ${result.message}');
    } catch (e) {
      throw Exception('Photo document tidak dapat ditemukan: $e');
    }
  }

  Future<void> requestPermissionAndOpen(String filePath) async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      status = 
      // await Permission.storage.request();
      // await Permission.photos.request();
      await Permission.mediaLibrary.request();
    }

    if (status.isGranted) {
      final result = await OpenFile.open(filePath);
      print('OpenFile result: ${result.message}');
    } else if (status.isPermanentlyDenied) {
      Get.snackbar(
        'Permission permanently denied',
        'Silakan aktifkan izin penyimpanan di pengaturan aplikasi',
      );
      openAppSettings(); // Buka pengaturan app
    } else {
      Get.snackbar('Permission denied',
          'Tidak dapat membuka dokumen karena izin ditolak');
    }
  }
}
