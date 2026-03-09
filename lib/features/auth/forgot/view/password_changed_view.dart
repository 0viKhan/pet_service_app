import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/widgets/app_button.dart';

class PasswordChangedView extends StatelessWidget {
  const PasswordChangedView({super.key});

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
          'Password Changed',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF344054),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            const Spacer(),

            /// Success Icon
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 88.w,
                  height: 88.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F6F67),
                    shape: BoxShape.circle,
                  ),
                ),

                Icon(
                  Icons.shield_outlined,
                  size: 34.sp,
                  color: Colors.white,
                ),

                Positioned(
                  top: 8.h,
                  left: 0,
                  child: _dot(10.w),
                ),
                Positioned(
                  top: 10.h,
                  right: 4.w,
                  child: _dot(7.w),
                ),
                Positioned(
                  bottom: 14.h,
                  left: -4.w,
                  child: _dot(5.w),
                ),
                Positioned(
                  bottom: 8.h,
                  right: -2.w,
                  child: _dot(4.w),
                ),
              ],
            ),

            SizedBox(height: 28.h),

            Text(
              'Password Changed',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF101828),
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              'Password changed successfully, you\ncan login again with new password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF667085),
                height: 1.5,
              ),
            ),

            const Spacer(),

            AppButton(
              title: 'Log in',
              onPressed: () {
                Get.offAllNamed(AppRoutes.login);
              },
            ),

            SizedBox(height: 28.h),
          ],
        ),
      ),
    );
  }

  Widget _dot(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF9BC4BE),
        shape: BoxShape.circle,
      ),
    );
  }
}