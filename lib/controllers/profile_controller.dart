import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nextbasis_hris/controllers/navigator_controllers.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

class ProfileController extends GetxController {
  var profilePhotoUrl = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final UserRepository userRepository = Get.find<UserRepository>();

  Future<void> updateProfilePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Menggunakan ImageCropper untuk memotong gambar
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // Persegi
          compressQuality: 100,
          maxWidth: 800,
          maxHeight: 800,
        );

        if (croppedFile != null) {
          final newProfilePhotoUrl =
              await userRepository.updateProfilePhoto(croppedFile.path);

          if (newProfilePhotoUrl != null) {
            final NavigatorControllers controller =
                Get.find<NavigatorControllers>();
            profilePhotoUrl.value = newProfilePhotoUrl;
            controller.fetchUserData();
            Get.snackbar('Success', 'Profile photo updated successfully');
          } else {
            Get.snackbar('Error', 'Failed to update profile photo');
          }
        } else {
          Get.snackbar('Canceled', 'Photo cropping canceled');
        }
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
