import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:magang_flutter/common/urls.dart';

class EditBiayaPageController extends GetxController {
  final int idBusinessTrip; // Add instance variable for idBusinessTrip

  // Observable properties
  RxBool isLoading = false.obs;
  RxString selectedCompany = ''.obs;
  RxList<String> companyItem = <String>[].obs;
  RxList<File> images = <File>[].obs;
  Rx<TextEditingController> keteranganController = TextEditingController().obs;
  Rx<TextEditingController> amountController = TextEditingController().obs;

  // List to store category data from API
  List<dynamic> _apiData = [];

  // Constructor with required idBusinessTrip parameter
  EditBiayaPageController({required this.idBusinessTrip});

  @override
  void onInit() {
    super.onInit();
    fetchCompanyItems(); // Fetch company items when controller is initialized
  }

  // Method to select an image from the gallery
  Future<void> getImageGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Method to remove an image
  void removeImage(File image) {
    images.remove(image);
  }

  // Method to fetch company items from API
  void fetchCompanyItems() async {
    isLoading.value = true; // Start loading
    try {
      final token = GetStorage().read('accessToken');
      final response = await http.get(
        Uri.parse(URLs.categories),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _apiData = json.decode(response.body);
        companyItem.value =
            _apiData.map((item) => item['name'].toString()).toList();
        print('Company items: ${companyItem.value}'); // Log for debugging
        if (companyItem.isNotEmpty) {
          selectedCompany.value = companyItem[0];
        }
      } else {
        Get.snackbar('Error', 'Failed to load company items');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load company items');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Method to update the selected company
  void updateSelectedCompany(String companyName) {
    selectedCompany.value = companyName;
  }

  // Method to submit the edited expense data
  Future<void> submitEditBiaya() async {
    isLoading.value = true; // Start loading
    try {
      final token = GetStorage().read('accessToken');
      final uri = Uri.parse(URLs.addBusiness); // Update with your API URL

      // Create a multipart request
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token';

      // Add fields to the request
      request.fields['id_business_trip'] = idBusinessTrip.toString();
      request.fields['id_category_expenditure'] = _apiData
          .firstWhere((item) => item['name'] == selectedCompany.value)['id']
          .toString();
      request.fields['nominal'] = amountController.value.text;
      request.fields['keterangan'] = keteranganController.value.text;

      // Add file if available
      if (images.isNotEmpty) {
        final file = http.MultipartFile.fromBytes(
          'photo_proof',
          await File(images.last.path).readAsBytes(),
          filename: images.last.path.split('/').last,
        );
        request.files.add(file);
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        Get.back(result: true); // Return to the previous screen with success
        Get.snackbar('Success', 'Expense successfully updated');
      } else {
        final responseBody = await response.stream.bytesToString();
        Get.snackbar('Error', 'Failed to update expense: $responseBody');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
