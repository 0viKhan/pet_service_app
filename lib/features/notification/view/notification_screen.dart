import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 18.w),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Notification',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
              _item(
                'Congratulations, your Payment has been successfully paid',
                '1 day Ago',
              ),
              SizedBox(height: 16.h),
              _item(
                'Provider Accepted – Secure Payment Now',
                '3 hours Ago',
              ),
              SizedBox(height: 16.h),
              _item(
                'Congratulations, your Payment has been successfully paid',
                '1 day Ago',
              ),
              SizedBox(height: 16.h),
              _item(
                'Congratulations, your Payment has been successfully paid',
                '1 day Ago',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(String title, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16.r,
          backgroundColor: const Color(0xFFEAEAEA),
          child: Icon(Icons.shopping_cart_outlined, size: 18.sp, color: Colors.black),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                time,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}