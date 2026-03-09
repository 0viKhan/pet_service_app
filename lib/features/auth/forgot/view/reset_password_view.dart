import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18.sp,
            color: const Color(0xFF475467),
          ),
        ),
        title: Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF344054),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),

            Column(
              children: [
                Text(
                  'Reset Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF101828),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Enter your email, we will send a verification\ncode to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF667085),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 18.h),
                AppTextField(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  borderRadius: 111.r,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 18.sp,
                    color: const Color(0xFF98A2B3),
                  ),
                ),
              ],
            ),

            const Spacer(),

            AppButton(
              title: 'Send code',
              onPressed: () {
                Get.toNamed(
                  AppRoutes.otp,
                  arguments: {
                    'nextRoute': AppRoutes.createNewPassword,
                  },
                );
              },
            ),
            SizedBox(height: 26.h),
          ],
        ),
      ),
    );
  }
}