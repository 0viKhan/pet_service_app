import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled1/app/routes/app_routes.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controller/login_controller.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24.h),

                Container(
                  height: 72.w,
                  width: 72.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F6F67),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/splash_logo.png',
                      width: 42.w,
                      height: 42.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                Text(
                  'Hey! Welcome back',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  'Sign in to your account',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),

                SizedBox(height: 29.h),
                AppTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 18.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),

                SizedBox(height: 14.h),

                Obx(
                      () => AppTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    obscureText: controller.isPasswordHidden.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 18.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: controller.togglePasswordVisibility,
                      child: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 18.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.resetPassword);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0F6F67),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 22.h),

                Obx(
                      () => AppButton(
                    title: 'Log in',
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      controller.login();
                    },
                  ),
                ),

                SizedBox(height: 14.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.register);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF33A097),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}