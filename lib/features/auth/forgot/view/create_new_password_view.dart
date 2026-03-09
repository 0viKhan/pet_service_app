import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class CreateNewPasswordView extends StatelessWidget {
  const CreateNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18.sp,
            color: const Color(0xFF475467),
          ),
        ),
        title: Text(
          'Create New Password',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF344054),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            Text(
              'Create New Password',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF101828),
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'Your password must be different from previous\nused password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF667085),
                height: 1.4,
              ),
            ),

            SizedBox(height: 24.h),

            AppTextField(
              hintText: 'Password',
              obscureText: true,
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 18.sp,
                color: const Color(0xFF98A2B3),
              ),
              suffixIcon: Icon(
                Icons.visibility_off_outlined,
                size: 18.sp,
                color: const Color(0xFF98A2B3),
              ),
            ),

            SizedBox(height: 14.h),

            AppTextField(
              hintText: 'Confirm Password',
              obscureText: true,
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 18.sp,
                color: const Color(0xFF98A2B3),
              ),
              suffixIcon: Icon(
                Icons.visibility_off_outlined,
                size: 18.sp,
                color: const Color(0xFF98A2B3),
              ),
            ),

            SizedBox(height: 26.h),

            AppButton(
              title: 'Reset Password',
              onPressed: () {
                Get.toNamed(AppRoutes.passwordChanged);
              },
            ),
          ],
        ),
      ),
    );
  }
}