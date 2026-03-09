import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PetsSection extends StatelessWidget {
  const PetsSection({super.key});

  static const Color _primary = Color(0xFF0A7C6B);

  @override
  Widget build(BuildContext context) {
    final pets = [
      {
        'name': 'Bella',
        'image': 'assets/images/dog.png',
        'color': const Color(0xFFE5B11D),
      },
      {
        'name': 'Roudy',
        'image': 'assets/images/doggesh2.png',
        'color': const Color(0xFF7C87B5),
      },
      {
        'name': 'Luna',
        'image': 'assets/images/doggesh3.png',
        'color': const Color(0xFFE29369),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'My Pets',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF202124),
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.pets,
              color: _primary,
              size: 22.sp,
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: pets.map((pet) {
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 86.w,
                      height: 86.w,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: pet['color'] as Color,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(pet['image'] as String),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      pet['name'] as String,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF5F6368),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}