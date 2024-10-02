import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_endpoint.dart';
import 'package:nextbasis_hris/controllers/planning_controller.dart';
import 'package:nextbasis_hris/data/repo/planning_repository.dart';

class PlanningUpdateController extends GetxController {
  final PlanningRepository _planningRepository = PlanningRepository();
  final PlanningController nominalPageController =
      Get.find<PlanningController>();

  final int idBusinessTrip;
  final int? idItem;

  RxBool isLoading = false.obs;
  RxString selectedCompany = ''.obs;
  RxList<String> companyItem = <String>[].obs;
  RxList<File> images = <File>[].obs;
  RxString existingPhotoUrl = ''.obs;
  File? photoProof;

  Rx<TextEditingController> keteranganController = TextEditingController().obs;
  Rx<TextEditingController> amountController = TextEditingController().obs;

  List<dynamic> _apiData = [];

  PlanningUpdateController({
    required this.idBusinessTrip,
    this.idItem,
  });

  @override
  void onInit() {
    super.onInit();
    if (idItem != null) {
      fetchCategoryExpenditure();
      fetchDataForEdit(); // Fetch data if idItem is not null
    } else {
      fetchCategoryExpenditure();
    }
  }

  void fetchDataForEdit() async {
    log('fetch data for edit');
    isLoading.value = true;
    try {
      final token = GetStorage().read('accessToken');
      final response = await http.get(
        Uri.parse('${AppEndpoint.getRealizationId}$idItem'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        selectedCompany.value = data['category_expenditure_name'];
        keteranganController.value.text = data['keterangan'];
        amountController.value.text = data['nominal'].toString();

        // Jika ada URL gambar, simpan dalam variabel existingPhotoUrl
        if (data['photo_proof'] != null) {
          existingPhotoUrl.value = data['photo_proof'];
        }

        log(data.toString());
      } else {
        Get.snackbar('Error', backgroundColor: AppColor.error, 'Failed to load item details');
      }
    } catch (e) {
      Get.snackbar('Error', backgroundColor: AppColor.error, 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateRealization() async {
    isLoading.value = true;
    try {
      final success = await _planningRepository.updateRealization(
        idItem: idItem!,
        keterangan: keteranganController.value.text,
        nominal: amountController.value.text,
        photoProof: photoProof,
        idBusinessTrip: idBusinessTrip,
      );
      if (success) {
        nominalPageController.fetchNominalData(idBusinessTrip);
        Get.back(closeOverlays: true);
        Get.snackbar('Success', backgroundColor: AppColor.success, 'Data successfully updated');
      } else {
        Get.snackbar('Error', backgroundColor: AppColor.error, 'Failed to edit data');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getImageGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        images.add(File(pickedFile.path)); 
        photoProof = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void removeImage(File image) {
    images.remove(image);
  }

  Future<void> fetchCategoryExpenditure() async {
    isLoading.value = true;
    try {
      final items = await _planningRepository.fetchCategoryExpenditure();
      _apiData = items;
      companyItem.value =
          _apiData.map((item) => item['name'].toString()).toList();
      if (companyItem.isNotEmpty) {
        selectedCompany.value = companyItem[0];
      }
    } catch (e) {
      Get.snackbar('Error', backgroundColor: AppColor.error, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedCompany(String companyName) {
    selectedCompany.value = companyName;
  }

  Future<void> postRealization() async {
    List<http.MultipartFile> files = [];
    if (images.isNotEmpty) {
      final file = http.MultipartFile.fromBytes(
        'photo_proof',
        await File(images.last.path).readAsBytes(),
        filename: images.last.path.split('/').last,
      );
      files.add(file);
    }

    final success = await _planningRepository.postRealization(
      idBusinessTrip: idBusinessTrip.toString(),
      selectedCategoryId: _apiData
          .firstWhere((item) => item['name'] == selectedCompany.value)['id']
          .toString(),
      nominal: amountController.value.text,
      keterangan: keteranganController.value.text,
      files: files,
    );

    if (success) {
      Get.back(result: true, closeOverlays: true);
      Get.snackbar('Success', backgroundColor: AppColor.success, 'Expense successfully created');
    } else {
      Get.snackbar('Error', backgroundColor: AppColor.error, 'Failed to created expense');
    }
  }
}
