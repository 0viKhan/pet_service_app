import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_button.dart';
import '../controller/ChangePasswordController.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18.sp,
            color: const Color(0xFF344054),
          ),
        ),
        title: Text(
          'Change Password',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1D2939),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 18.h),
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF0B6B61),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Center(
                  child: Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.4),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.pets_rounded,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.h),

              Obx(() => _PasswordField(
                label: 'Old Password',
                controller: controller.oldPasswordController,
                obscureText: controller.hideOldPassword.value,
                onToggleVisibility:
                controller.toggleOldPasswordVisibility,
              )),
              SizedBox(height: 14.h),

              Obx(() => _PasswordField(
                label: 'New Password',
                controller: controller.newPasswordController,
                obscureText: controller.hideNewPassword.value,
                onToggleVisibility:
                controller.toggleNewPasswordVisibility,
              )),
              SizedBox(height: 14.h),

              Obx(() => _PasswordField(
                label: 'Confirm Password',
                controller: controller.confirmPasswordController,
                obscureText: controller.hideConfirmPassword.value,
                onToggleVisibility:
                controller.toggleConfirmPasswordVisibility,
              )),
              SizedBox(height: 22.h),

              Obx(
                    () => AppButton(
                  title: 'Update',
                  height: 52.h,
                  borderRadius: 26.r,
                  backgroundColor: const Color(0xFF0B6B61),
                  isLoading: controller.isLoading.value,
                  onPressed: controller.changePassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  const _PasswordField({
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF344054),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFDFDFD),
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF101828).withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            obscuringCharacter: '*',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF101828),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: '*************',
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF98A2B3),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 14.w, right: 10.w),
                child: Icon(
                  Icons.lock_outline,
                  size: 18.sp,
                  color: const Color(0xFF98A2B3),
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 42.w,
                minHeight: 20.h,
              ),
              suffixIcon: IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 19.sp,
                  color: const Color(0xFF98A2B3),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: const Color(0xFF0B6B61).withOpacity(0.18),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}