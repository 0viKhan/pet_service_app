import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAnimalController extends GetxController {
  final petNameController = TextEditingController();
  final aboutPetController = TextEditingController();

  final parkNameController = TextEditingController();
  final locationController = TextEditingController();
  final linkController = TextEditingController();

  final RxString selectedAge = '2'.obs;
  final RxString selectedGender = 'Male'.obs;
  final RxString selectedAnimalType = 'DOG'.obs;

  final List<String> ageList = ['1', '2', '3', '4', '5', '6+'];
  final List<String> genderList = ['Male', 'Female'];

  final List<Map<String, String>> animalTypes = [
    {'emoji': '🐕', 'title': 'DOG'},
    {'emoji': '🐈', 'title': 'CAT'},
    {'emoji': '🐇', 'title': 'RABBIT'},
    {'emoji': '🐹', 'title': 'HAMSTER'},
    {'emoji': '🐦', 'title': 'BIRD'},
    {'emoji': '🦜', 'title': 'PARROT'},
    {'emoji': '🐢', 'title': 'TURTLE'},
    {'emoji': '🦎', 'title': 'REPTILE'},
  ];

  void setAge(String value) => selectedAge.value = value;
  void setGender(String value) => selectedGender.value = value;
  void setAnimalType(String value) => selectedAnimalType.value = value;

  void submitPet() {
    debugPrint('Pet Name: ${petNameController.text.trim()}');
    debugPrint('About Pet: ${aboutPetController.text.trim()}');
    debugPrint('Age: ${selectedAge.value}');
    debugPrint('Gender: ${selectedGender.value}');
    debugPrint('Type: ${selectedAnimalType.value}');

    Get.snackbar(
      'Success',
      'Pet added successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void submitPark() {
    debugPrint('Park Name: ${parkNameController.text.trim()}');
    debugPrint('Location: ${locationController.text.trim()}');
    debugPrint('Link: ${linkController.text.trim()}');

    Get.snackbar(
      'Success',
      'Park added successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
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