import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key});

  static const Color _primary = Color(0xFF0A7C6B);
  static const Color _textLight = Color(0xFF7B8794);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Doctor image
          Container(
            width: 86.w,
            height: 86.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: const DecorationImage(
                image: AssetImage('assets/images/doctor_girl.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 14.w),

          // Doctor info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Anna Johanson',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF202124),
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  'Veterinary Behavioral',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9AA1A9),
                  ),
                ),

                SizedBox(height: 12.h),

                Row(
                  children: [
                    Icon(
                      Icons.star_border_rounded,
                      size: 17.sp,
                      color: const Color(0xFFE6A23C),
                    ),

                    SizedBox(width: 4.w),

                    Text(
                      '4.8',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: _textLight,
                      ),
                    ),

                    SizedBox(width: 14.w),

                    Icon(
                      Icons.location_on_outlined,
                      size: 17.sp,
                      color: _primary,
                    ),

                    SizedBox(width: 4.w),

                    Text(
                      '1 km',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: _textLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}