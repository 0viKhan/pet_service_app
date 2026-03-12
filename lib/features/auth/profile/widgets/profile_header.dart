import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 56.h,
        left: 16.w,
        right: 16.w,
        bottom: 26.h,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF006D5B),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          CircleAvatar(
            radius: 34.r,
            backgroundColor: Colors.white24,
            backgroundImage: const AssetImage('assets/images/cat.png'),
          ),
          SizedBox(height: 10.h),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

        ],
      ),
    );

  }
}