import 'dart:io';

import 'package:get/get.dart';

import '../../../core/services/local_storage_service.dart';
import '../model/pet_service.dart';

class AddAnimalController extends GetxController {
  final PetService _petService = PetService();

  RxBool isLoading = false.obs;

  Future<void> createPet({
    required String name,
    required int age,
    required String gender,
    required String about,
    required String animalType,
    required List<File> images,
  }) async {
    try {
      isLoading.value = true;

      final token = await LocalStorageService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('Access token not found');
      }

      final response = await _petService.createPet(
        token: token,
        name: name,
        age: age,
        gender: gender,
        about: about,
        animalType: animalType,
        images: images,
      );

      Get.snackbar(
        'Success',
        response['message'] ?? 'Pet created successfully',
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}