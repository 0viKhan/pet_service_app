import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfessionalCard extends StatelessWidget {
  final String name;
  final String role;
  final String rating;
  final String location;
  final String image;

  const ProfessionalCard({
    super.key,
    required this.name,
    required this.role,
    required this.rating,
    required this.location,
    required this.image,
  });

  static const Color _primary = Color(0xFF0A7C6B);
  static const Color _textDark = Color(0xFF222222);
  static const Color _textLight = Color(0xFF9AA1A9);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 66.w,
            height: 66.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: _textLight,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 15.sp,
                      color: const Color(0xFFF4B63D),
                    ),
                    SizedBox(width: 4.w),
                    Text(rating),
                    const Spacer(),
                    Icon(
                      Icons.location_on_outlined,
                      size: 15.sp,
                      color: _primary,
                    ),
                    SizedBox(width: 3.w),
                    Text(location),
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