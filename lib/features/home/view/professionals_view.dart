import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled1/app/routes/app_routes.dart';

import '../../../core/widgets/professional_card.dart';

class ProfessionalsView extends StatelessWidget {
  const ProfessionalsView({super.key});

  static const Color _bgColor = Color(0xFFF6F7F7);
  static const Color _primary = Color(0xFF0A7C6B);
  static const Color _textDark = Color(0xFF2B2B2B);
  static const Color _textLight = Color(0xFF9AA1A9);

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      'Veterinarians',
      'Dog trainers',
      'Pet sitters',
    ];

    final professionals = [
      {
        'name': 'Kali',
        'role': 'Breeder',
        'rating': '4.8',
        'location': 'Sassari',
        'image': 'assets/images/doggesh3.png',
      },
      {
        'name': 'Clinica Veterinaria Test',
        'role': 'Pet sitters',
        'rating': '4.8',
        'location': 'Rome',
        'image': 'assets/images/cat.png',
      },
      {
        'name': 'Kali',
        'role': 'Dog trainers',
        'rating': '4.8',
        'location': 'Milan',
        'image': 'assets/images/doggesh2.jpg',
      },
      {
        'name': 'cliba',
        'role': 'Veterinarians',
        'rating': '4.8',
        'location': 'Florence',
        'image': 'assets/images/doggesh3.png',
      },
      {
        'name': 'Clinica Veterinaria Test',
        'role': 'Breeder',
        'rating': '4.8',
        'location': 'Rome',
        'image': 'assets/images/cat.png',
      },
    ];

    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              _buildHeader(),
              SizedBox(height: 18.h),
              _buildCategoryList(categories),
              SizedBox(height: 18.h),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 12.h),
                  itemCount: professionals.length,
                  separatorBuilder: (_, __) => SizedBox(height: 14.h),
                  itemBuilder: (context, index) {
                    final item = professionals[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.petdetails);
                      },
                      child: ProfessionalCard(
                        name: item['name']!,
                        role: item['role']!,
                        rating: item['rating']!,
                        location: item['location']!,
                        image: item['image']!,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 34.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
          Center(
            child: Text(
              'Professionals',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: _textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(List<String> categories) {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final isActive = index == 0;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: isActive ? _primary : const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isActive
                    ? _primary
                    : const Color(0xFFD7DADD),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              categories[index],
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : const Color(0xFF4B5563),
              ),
            ),
          );
        },
      ),
    );
  }
}

