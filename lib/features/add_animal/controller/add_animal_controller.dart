import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/local_storage_service.dart';
import '../../../core/services/photo_picker_service.dart';
import '../../home/controller/home_controller.dart';
import '../../home/services/park_service.dart';
import '../../home/services/pet_service.dart';
import '../model.dart';

class AddAnimalController extends GetxController {
  final petNameController = TextEditingController();
  final aboutPetController = TextEditingController();

  final parkNameController = TextEditingController();
  final locationController = TextEditingController();
  final linkController = TextEditingController();

  final RxString selectedAge = '2'.obs;
  final RxString selectedGender = 'Male'.obs;
  final RxString selectedAnimalType = 'DOG'.obs;

  final RxList<File> petImages = <File>[].obs;
  final RxList<File> parkImages = <File>[].obs;

  final isSubmittingPet = false.obs;
  final isSubmittingPark = false.obs;

  final List<String> ageList = ['1', '2', '3', '4', '5', '6+'];
  final List<String> genderList = ['Male', 'Female'];

  final List<Map<String, String>> animalTypes = [
    {'emoji': '🐕', 'title': 'DOG'},
    {'emoji': '🐈', 'title': 'GATTO'},
    {'emoji': '🐇', 'title': 'RABBIT'},
    {'emoji': '🐹', 'title': 'HAMSTER'},
    {'emoji': '🐦', 'title': 'BIRD'},
    {'emoji': '🦜', 'title': 'PARROT'},
    {'emoji': '🐢', 'title': 'TURTLE'},
  ];

  final PhotoPickerService photoPickerService = Get.find<PhotoPickerService>();

  void setAge(String value) => selectedAge.value = value;
  void setGender(String value) => selectedGender.value = value;
  void setAnimalType(String value) => selectedAnimalType.value = value;

  Future<void> pickPetImages() async {
    final remaining = 5 - petImages.length;

    if (remaining <= 0) {
      Get.snackbar('Limit reached', 'You can upload maximum 5 images');
      return;
    }

    photoPickerService.clearAllImages();
    final picked = await photoPickerService.pickMultipleImages();

    if (picked.isEmpty) return;

    for (final file in picked.take(remaining)) {
      if (!petImages.any((e) => e.path == file.path)) {
        petImages.add(file);
      }
    }

    if (picked.length > remaining) {
      Get.snackbar('Notice', 'Only $remaining image(s) were added');
    }
  }

  Future<void> pickParkImages() async {
    photoPickerService.clearAllImages();
    final picked = await photoPickerService.pickMultipleImages();

    if (picked.isEmpty) return;

    parkImages.clear();
    parkImages.addAll(picked.take(5));
  }

  void removePetImage(File file) {
    petImages.removeWhere((e) => e.path == file.path);
  }

  void removeParkImage(File file) {
    parkImages.removeWhere((e) => e.path == file.path);
  }

  Future<void> submitPet() async {
    try {
      if (petNameController.text.trim().isEmpty) {
        Get.snackbar('Validation', 'Please enter pet name');
        return;
      }

      if (aboutPetController.text.trim().isEmpty) {
        Get.snackbar('Validation', 'Please enter pet description');
        return;
      }

      if (petImages.isEmpty) {
        Get.snackbar('Validation', 'Please select at least one image');
        return;
      }

      final token = await LocalStorageService.getAccessToken();

      if (token == null || token.isEmpty) {
        Get.snackbar('Error', 'Please login again');
        return;
      }

      isSubmittingPet.value = true;

      final pet = PetModel(
        name: petNameController.text.trim(),
        age: int.tryParse(selectedAge.value.replaceAll('+', '')) ?? 1,
        gender: selectedGender.value.toUpperCase(),
        about: aboutPetController.text.trim(),
        animalType: selectedAnimalType.value.toUpperCase(),
      );

      final success = await PetService().createPet(
        pet,
        token,
        petImages,
      );

      if (success) {
        if (Get.isRegistered<HomeController>()) {
          await Get.find<HomeController>().refreshHomeData();
        }

        Get.snackbar(
          'Success',
          'Pet added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );

        petNameController.clear();
        aboutPetController.clear();
        petImages.clear();
        selectedAge.value = '2';
        selectedGender.value = 'Male';
        selectedAnimalType.value = 'DOG';

        Get.back();
      }
    } catch (e) {
      debugPrint("Submit Pet Error: $e");
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSubmittingPet.value = false;
    }
  }

  Future<void> submitPark() async {
    try {
      if (parkNameController.text.trim().isEmpty) {
        Get.snackbar('Validation', 'Please enter park name');
        return;
      }

      if (locationController.text.trim().isEmpty) {
        Get.snackbar('Validation', 'Please enter location name');
        return;
      }

      if (parkImages.isEmpty) {
        Get.snackbar('Validation', 'Please select an image');
        return;
      }

      final token = await LocalStorageService.getAccessToken();

      if (token == null || token.isEmpty) {
        Get.snackbar('Error', 'Please login again');
        return;
      }

      isSubmittingPark.value = true;

      final success = await ParkService().createPark(
        parkNameController.text.trim(),
        locationController.text.trim(),
        40.7128,
        -74.0060,
        token,
        parkImages.first,
      );

      if (success) {
        if (Get.isRegistered<HomeController>()) {
          await Get.find<HomeController>().refreshHomeData();
        }

        Get.snackbar(
          'Success',
          'Park added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );

        parkNameController.clear();
        locationController.clear();
        linkController.clear();
        parkImages.clear();

        Get.back();
      }
    } catch (e) {
      debugPrint("Submit Park Error: $e");
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSubmittingPark.value = false;
    }
  }

  @override
  void onClose() {
    petNameController.dispose();
    aboutPetController.dispose();
    parkNameController.dispose();
    locationController.dispose();
    linkController.dispose();
    super.onClose();
  }
}