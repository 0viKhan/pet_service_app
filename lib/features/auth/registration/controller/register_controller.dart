import 'package:get/get.dart';

class RegisterController extends GetxController {
  final selectedRole = 'professionista'.obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }

  bool isSelected(String role) => selectedRole.value == role;
}