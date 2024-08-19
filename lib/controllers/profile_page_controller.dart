import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:magang_flutter/common/urls.dart';
import 'package:magang_flutter/controllers/navigator_page_controllers.dart';

class ProfilePageController extends GetxController {
  var profilePhotoUrl = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> updateProfilePhoto() async {
    try {
      // Mengambil foto dari galeri atau kamera
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final uri =
            Uri.parse(URLs.updatePhoto); // Ganti dengan URL endpoint API Anda
        final request = http.MultipartRequest('POST', uri)
          ..headers['Authorization'] =
              'Bearer ${GetStorage().read('accessToken')}'
          ..files.add(
              await http.MultipartFile.fromPath('profile_photo', image.path));

        final response = await request.send();

        if (response.statusCode == 200) {
          final responseData = await response.stream.bytesToString();
          final data = json.decode(responseData);

          // Cek apakah data yang diterima memiliki kunci 'profile_photo_url'
          if (data.containsKey('profile_photo_url')) {
            final NavigatorPageControllers controller =
                Get.find<NavigatorPageControllers>();
            // Update URL foto profil setelah sukses
            profilePhotoUrl.value = data['profile_photo_url'];
            controller.fetchUserData();
            print(profilePhotoUrl);
            Get.snackbar('Success', 'Profile photo updated successfully');
          } else {
            Get.snackbar('Error', 'Invalid response format');
          }
        } else {
          Get.snackbar('Error',
              'Failed to update profile photo. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
