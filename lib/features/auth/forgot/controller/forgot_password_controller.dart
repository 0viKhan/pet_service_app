import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../app/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isSendingCode = false.obs;
  final isVerifyingOtp = false.obs;
  final isResettingPassword = false.obs;

  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  String? resetToken;
  String? email;

  static const String baseUrl = 'http://23.239.111.164:5022/api/v1/auth';

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  Future<void> sendCode() async {
    debugPrint('sendCode() called');

    final enteredEmail = emailController.text.trim();

    if (enteredEmail.isEmpty) {
      Get.snackbar('Validation', 'Please enter your email');
      return;
    }

    if (!GetUtils.isEmail(enteredEmail)) {
      Get.snackbar('Validation', 'Please enter a valid email');
      return;
    }

    try {
      isSendingCode.value = true;

      final url = '$baseUrl/forgot';
      final requestBody = {
        'email': enteredEmail,
      };

      debugPrint('========== FORGOT PASSWORD REQUEST ==========');
      debugPrint('REQUEST URL: $url');
      debugPrint('REQUEST BODY: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('RESPONSE BODY: ${response.body}');
      debugPrint('============================================');

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData['success'] == true) {
        email = enteredEmail;

        final message = jsonData['data']?['message'] ??
            'Otp sent successfully. Please verify your email to change password.';

        final otpCode = jsonData['data']?['otpResponse']?['code'];
        debugPrint('FORGOT OTP CODE: $otpCode');

        Get.snackbar('Success', message);

        Get.toNamed(
          AppRoutes.otp,
          arguments: {
            'email': enteredEmail,
            'otpType': 'forgot',
          },
        );
      } else {
        Get.snackbar(
          'Failed',
          jsonData['message'] ??
              jsonData['data']?['message'] ??
              'Failed to send otp',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send code');
      debugPrint('sendCode error: $e');
    } finally {
      isSendingCode.value = false;
    }
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      Get.snackbar('Validation', 'Please enter otp');
      return;
    }

    if (otp.length != 4) {
      Get.snackbar('Validation', 'OTP must be 4 digits');
      return;
    }

    if (email == null || email!.isEmpty) {
      email = Get.arguments?['email'];
    }

    if (email == null || email!.isEmpty) {
      Get.snackbar('Error', 'Email not found. Please try again.');
      return;
    }

    try {
      isVerifyingOtp.value = true;

      final url = '$baseUrl/forgot/verify';
      final requestBody = {
        'email': email,
        'otp': otp,
      };

      debugPrint('========== VERIFY FORGOT OTP REQUEST ==========');
      debugPrint('REQUEST URL: $url');
      debugPrint('REQUEST BODY: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('RESPONSE BODY: ${response.body}');
      debugPrint('==============================================');

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData['success'] == true) {
        resetToken = jsonData['data'];

        debugPrint('RESET TOKEN: $resetToken');

        Get.snackbar('Success', 'OTP verified successfully');

        Get.toNamed(
          AppRoutes.createNewPassword,
          arguments: {
            'email': email,
            'token': resetToken,
          },
        );
      } else {
        Get.snackbar(
          'Verification Failed',
          jsonData['message'] ?? 'Invalid otp',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify otp');
      debugPrint('verifyOtp error: $e');
    } finally {
      isVerifyingOtp.value = false;
    }
  }

  Future<void> resetPassword() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty) {
      Get.snackbar('Validation', 'Please enter new password');
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

    resetToken ??= Get.arguments?['token'];
    email ??= Get.arguments?['email'];

    if (resetToken == null || resetToken!.isEmpty) {
      Get.snackbar('Error', 'Token not found. Please verify OTP again.');
      return;
    }

    try {
      isResettingPassword.value = true;

      final url = '$baseUrl/forgot/reset';
      final requestBody = {
        'password': password,
        'confirmPassword': confirmPassword,
      };

      debugPrint('========== RESET PASSWORD REQUEST ==========');
      debugPrint('REQUEST URL: $url');
      debugPrint('REQUEST HEADER TOKEN: $resetToken');
      debugPrint('REQUEST BODY: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': resetToken!,
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('RESPONSE BODY: ${response.body}');
      debugPrint('============================================');

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData['success'] == true) {
        final message = jsonData['data']?['message'] ??
            'Password updated successfully. Please login.';

        Get.snackbar('Success', message);
        Get.offAllNamed(AppRoutes.passwordChanged);
      } else {
        Get.snackbar(
          'Failed',
          jsonData['message'] ??
              jsonData['data']?['message'] ??
              'Failed to reset password',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to reset password');
      debugPrint('resetPassword error: $e');
    } finally {
      isResettingPassword.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}