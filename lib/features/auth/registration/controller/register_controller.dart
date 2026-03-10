import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../app/routes/app_routes.dart';
import '../../../../core/config/api_constants.dart';

class RegisterController extends GetxController {
  final selectedRole = 'professionista'.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  final isLoading = false.obs;
  final isVerifyingOtp = false.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }

  bool isSelected(String role) => selectedRole.value == role;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  Future<void> register() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final city = cityController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (firstName.isEmpty) {
      Get.snackbar('Validation', 'Please enter first name');
      return;
    }

    if (lastName.isEmpty) {
      Get.snackbar('Validation', 'Please enter last name');
      return;
    }

    if (email.isEmpty) {
      Get.snackbar('Validation', 'Please enter email');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Validation', 'Please enter a valid email');
      return;
    }

    if (city.isEmpty) {
      Get.snackbar('Validation', 'Please enter city');
      return;
    }

    if (password.isEmpty) {
      Get.snackbar('Validation', 'Please enter password');
      return;
    }

    if (password.length < 6) {
      Get.snackbar('Validation', 'Password must be at least 6 characters');
      return;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Validation', 'Please confirm password');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Validation', 'Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;

      final requestBody = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'city': city,
        'password': password,
      };

      debugPrint('========== REGISTER REQUEST ==========');
      debugPrint('REQUEST URL: ${ApiConstants.signUp}');
      debugPrint('REQUEST BODY: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(ApiConstants.signUp),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('RESPONSE BODY: ${response.body}');
      debugPrint('=====================================');

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          jsonData['success'] == true) {
        final message =
            jsonData['message'] ?? jsonData['data']?['message'] ?? 'Success';

        final otpCode = jsonData['data']?['otpResponse']?['code'];
        debugPrint('REGISTER OTP CODE: $otpCode');

        Get.snackbar('Success', message);

        Get.toNamed(
          AppRoutes.otp,
          arguments: {
            'email': email,
            'otpType': 'register',
          },
        );
      } else {
        Get.snackbar(
          'Failed',
          jsonData['message'] ??
              jsonData['data']?['message'] ??
              'Registration failed',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Registration failed');
      debugPrint('register error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyRegisterOtp(String email) async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      Get.snackbar('Validation', 'Please enter otp');
      return;
    }

    if (otp.length != 4) {
      Get.snackbar('Validation', 'OTP must be 4 digits');
      return;
    }

    try {
      isVerifyingOtp.value = true;

      final requestBody = {
        'email': email,
        'otp': otp,
      };

      debugPrint('======= REGISTER OTP VERIFY REQUEST =======');
      debugPrint('REQUEST URL: ${ApiConstants.verifyRegisterOtp}');
      debugPrint('REQUEST BODY: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(ApiConstants.verifyRegisterOtp),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('RESPONSE BODY: ${response.body}');
      debugPrint('===========================================');

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          jsonData['success'] == true) {
        Get.snackbar(
          'Success',
          jsonData['message'] ?? 'Account verified successfully',
        );

        Get.offAllNamed(AppRoutes.login);
      } else {
        Get.snackbar(
          'Failed',
          jsonData['message'] ?? 'OTP verification failed',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP');
      debugPrint('verifyRegisterOtp error: $e');
    } finally {
      isVerifyingOtp.value = false;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    cityController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.onClose();
  }
}