import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../app/routes/app_routes.dart';
import '../../../../core/services/local_storage_service.dart';
import '../model/login_response_model.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  LoginResponseModel? loginResponse;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    if (!_validateInputs()) return;

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('http://23.239.111.164:5022/api/v1/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      loginResponse = LoginResponseModel.fromJson(jsonData);

      if (response.statusCode == 200 && loginResponse!.success) {
        Get.snackbar(
          'Success',
          loginResponse!.message,
          snackPosition: SnackPosition.BOTTOM,
        );

        final token = loginResponse!.data.accessToken;
        final user = loginResponse!.data.user;

        debugPrint('Access Token: $token');
        debugPrint('Logged User: ${user.firstName} ${user.lastName}');

        await LocalStorageService.saveLogin(
          accessToken: token,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
        );

        Get.offAllNamed(AppRoutes.home);
      }

      else {
        Get.snackbar(
          'Login Failed',
          loginResponse?.message ?? 'Invalid email or password',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint('Login Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInputs() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      Get.snackbar('Validation', 'Please enter your email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Validation', 'Please enter a valid email');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Validation', 'Please enter your password');
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}