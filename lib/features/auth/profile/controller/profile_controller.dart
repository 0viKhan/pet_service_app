import 'dart:io';

import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();
  final AuthService _authService = AuthService();
  final Rxn<File> selectedLocalImage = Rxn<File>();
  final RxString profileImageUrl = ''.obs;
  final RxBool isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedProfileImage();
  }
  Future<void> logout() async {
    try {
      final token = await LocalStorageService.getAccessToken();

      if (token != null && token.isNotEmpty) {
        await _authService.logout(token: token);
      }

      await LocalStorageService.clearLogin();

      selectedLocalImage.value = null;
      profileImageUrl.value = '';

      Get.offAllNamed(AppRoutes.login);

      Get.snackbar(
        'Success',
        'Logged Out successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }
  Future<void> uploadProfileImage(File image) async {
    try {
      isUploading.value = true;
      selectedLocalImage.value = image;

      final token = await LocalStorageService.getAccessToken();
      final firstName = await LocalStorageService.getFirstName();

      if (token == null || token.isEmpty) {
        throw Exception('Access token not found');
      }

      final url = await _profileService.updateProfileImage(
        imageFile: image,
        token: token,
        firstName: firstName,
      );

      if (url != null && url.isNotEmpty) {
        profileImageUrl.value = url;
        await LocalStorageService.saveProfileImage(url);
      }

      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> _loadSavedProfileImage() async {
    final savedImage = await LocalStorageService.getProfileImage();
    if (savedImage != null && savedImage.isNotEmpty) {
      profileImageUrl.value = savedImage;
    }
  }
}