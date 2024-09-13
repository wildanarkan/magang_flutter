import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/business_trip_controller.dart';
import 'package:magang_flutter/controllers/home_page_controller.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class BusinessTripDetailPageController extends GetxController {
  final BusinessTripModel trip;

  BusinessTripDetailPageController({required this.trip});
  var isCityEnabled = false.obs;
  var extendedController = TextEditingController().obs;
  var extendDay = 0.obs;
  bool isChangeExtend = false;
  bool isChangePhoto = false;
  var photoDocument = ''.obs;
  var selectedFile = Rxn<File>();
  final storage = GetStorage();
  final isSaved = false.obs;

  // Panggil ini saat halaman dimuat untuk menginisialisasi nilai extendDay
  void setInitialVariable(int day, String photo) {
    extendDay.value = day;
    photoDocument.value = photo;
    log(extendDay.value.toString());
    log(photoDocument.value.toString());
  }

  bool checkIfSaved(BusinessTripModel trip) {
    List<dynamic> savedTrips = storage.read('savedBusinessTrips') ?? [];
    return savedTrips.any((item) => item['id'] == trip.idBusinessTrip);
  }

  Future<void> downloadAndOpenFile(String url, String fileName) async {
    try {
      // Mendapatkan direktori dokumen aplikasi
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');

      // Mengunduh file dari URL
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);

      // Membuka file yang telah diunduh
      OpenFile.open(file.path);
    } catch (e) {
      Get.snackbar('Error', 'Photo document tidak dapat di temukan');
      print('Error: $e');
    }
  }

  Future<void> updateExtendedDay(int businessTripId, int newExtendDay) async {
    try {
      final token = GetStorage().read('accessToken');
      final url = Uri.parse('${URLs.updateExtendedDay}$businessTripId');
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
        extendDay.value = newExtendDay; // Update nilai extendDay di controller
        extendedController.value.clear();
        isChangeExtend = true; // Perbaikan di sini
        Get.back(closeOverlays: true);
        Get.snackbar('Success', 'Extend updated to $newExtendDay');
      } else {
        Get.snackbar(
            'Error', 'Failed to update extend: ${response.statusCode}');
      }
      log(response.statusCode.toString());
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  void onClose() async {
    if (isChangeExtend || isChangePhoto) {
      final BusinessTripController businessTripController =
          Get.find<BusinessTripController>();
      final HomePageController homePageController =
          Get.find<HomePageController>();
      homePageController.fetchCurrentBusinessTrips();
      await businessTripController.fetchBusinessTrips();
      log('sudah refresh business trip');

      final updatedTrip =
          businessTripController.getTripById(trip.idBusinessTrip!);
      if (updatedTrip != null) {
        homePageController.refreshSavedTrips(updatedTrip);
      }
      isChangeExtend = false; // Reset isChangeExtend setelah fetching
      isChangePhoto = false; // Reset isChangeExtend setelah fetching
    }
    log(isChangeExtend.toString());
    log(isChangePhoto.toString());
    print('Semua data di GetStorage:');
    storage.getKeys().forEach((key) {
      print('$key: ${storage.read(key)}');
    });

    super.onClose();
  }

  Future<void> updateFileInDatabase(File file, int businessTripId) async {
    try {
      final token = GetStorage().read('accessToken');
      final url = Uri.parse(
          '${URLs.postPhotoDocument}$businessTripId'); // Ganti dengan URL endpoint yang benar
      final request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseBody);

        // Update variabel photoDocument dengan nilai yang baru dari database
        photoDocument.value = jsonData['file_name'];
        isChangePhoto = true; // Perbaikan di sini
        log('json : ${photoDocument.value}');
        Get.back();
        Get.snackbar('Success', 'File updated successfully');
      } else {
        Get.back();
        Get.snackbar('Error', 'Failed to update file');
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
