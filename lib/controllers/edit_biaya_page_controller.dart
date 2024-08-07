import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditBiayaPageController extends GetxController {
  var images = <File>[].obs;
  final picker = ImagePicker();
  final amountController = TextEditingController();

  Future<void> getImageGallery() async {
    try {
      final pickedFile = await picker.pickImage(
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

  void removeImage(File image) {
    images.remove(image);
  }
}
