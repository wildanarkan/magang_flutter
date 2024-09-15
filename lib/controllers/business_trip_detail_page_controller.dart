import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magang_flutter/controllers/business_trip_controller.dart';
import 'package:magang_flutter/controllers/home_page_controller.dart';
import 'package:magang_flutter/data/models/business_trip_model.dart';
import 'package:magang_flutter/data/repo/business_trip_repository.dart';

class BusinessTripDetailPageController extends GetxController {
  final BusinessTripModel trip;

  BusinessTripDetailPageController({required this.trip});
  final storage = GetStorage();

  final BusinessTripRepository _businessTripRepository =
      BusinessTripRepository();

  final BusinessTripController businessTripController =
      Get.find<BusinessTripController>();
  final HomePageController homePageController = Get.find<HomePageController>();

  // var isCityEnabled = false.obs;
  bool isChangeExtend = false;
  bool isChangePhoto = false;
  final isSaved = false.obs;

  var extendDay = 0.obs;
  var extendedController = TextEditingController().obs;

  var photoDocument = ''.obs;
  var selectedFile = Rxn<File>();

  void setInitialVariable(int day, String photo) {
    extendDay.value = day;
    photoDocument.value = photo;
    log(extendDay.value.toString());
    log(photoDocument.value.toString());
  }

  @override
  void onClose() async {
    if (isChangeExtend || isChangePhoto) {
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

  Future<void> downloadAndOpenFile(String url, String fileName) async {
    try {
      await _businessTripRepository.getPhotoDocument(url, fileName);
    } catch (e) {
      Get.snackbar('Error', 'Photo document tidak dapat ditemukan');
      print('Error: $e');
    }
  }

  Future<void> updateExtendedDay(int businessTripId, int newExtendDay) async {
    try {
      await _businessTripRepository.updateExtendedDay(
          businessTripId, newExtendDay);
      extendDay.value = newExtendDay;
      extendedController.value.clear();
      isChangeExtend = true;
      Get.back(closeOverlays: true);
      Get.snackbar('Success', 'Extend updated to $newExtendDay');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> updateFileInDatabase(File file, int businessTripId) async {
    try {
      final updatedFileName = await _businessTripRepository.updatePhotoDocument(
          file, businessTripId);
      photoDocument.value = updatedFileName;
      isChangePhoto = true;
      log('File updated: ${photoDocument.value}');
      Get.back();
      Get.snackbar('Success', 'File updated successfully');
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  bool checkIfSaved(BusinessTripModel trip) {
    List<dynamic> savedTrips = storage.read('savedBusinessTrips') ?? [];
    return savedTrips.any((item) => item['id'] == trip.idBusinessTrip);
  }
}
