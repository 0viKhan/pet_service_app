import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/api_constants.dart';
import '../../../../core/services/local_storage_service.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final hideOldPassword = true.obs;
  final hideNewPassword = true.obs;
  final hideConfirmPassword = true.obs;

  void toggleOldPasswordVisibility() {
    hideOldPassword.toggle();
  }

  void toggleNewPasswordVisibility() {
    hideNewPassword.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    hideConfirmPassword.toggle();
  }

  Future<void> changePassword() async {
    print('UPDATE BUTTON CLICKED');

    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Validation', 'Please fill all password fields');
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar('Validation', 'New password must be at least 6 characters');
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Validation',
        'New password and confirm password do not match',
      );
      return;
    }

    final token = await LocalStorageService.getAccessToken();

    print("Base URL: ${ApiConstants.baseUrl}");
    print("Change Password URL: ${ApiConstants.changePassword}");
    print("Token: $token");

    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'User token not found. Please login again.');
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.patch(
        Uri.parse(ApiConstants.changePassword),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData['success'] == true) {
        Get.snackbar(
          'Success',
          jsonData['message'] ?? 'Password changed successfully',
        );

        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        Get.back();
      } else {
        Get.snackbar(
          'Failed',
          jsonData['message'] ?? 'Failed to change password',
        );
      }
    } catch (e) {
      print('changePassword error: $e');
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}