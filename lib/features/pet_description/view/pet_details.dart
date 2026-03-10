import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PetDetailsView extends StatelessWidget {
  const PetDetailsView({super.key});

  static const Color pageBg = Color(0xFFF5F6FA);
  static const Color cardColor = Colors.white;
  static const Color textDark = Color(0xFF111827);
  static const Color textLight = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      body: Stack(
        children: [
          const _PetHeaderImage(),
          const _TopActionBar(),
          const _BottomDetailsCard(),
        ],
      ),
    );
  }
}

class _PetHeaderImage extends StatelessWidget {
  const _PetHeaderImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420.h,
      width: double.infinity,
      child: Image.asset(
        'assets/images/thirsty_dog.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _TopActionBar extends StatelessWidget {
  const _TopActionBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CircleIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: Get.back,
            ),
            _CircleIconButton(
              icon: Icons.more_vert_rounded,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomDetailsCard extends StatelessWidget {
  const _BottomDetailsCard();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 305.h,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 18.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Luna',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: PetDetailsView.textDark,
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: _InfoChip(
                      title: 'Male',
                      subtitle: 'Sex',
                      bgColor: const Color(0xFFDCD4F7),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _InfoChip(
                      title: '2 Years',
                      subtitle: 'Age',
                      bgColor: const Color(0xFFF3E3A8),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _InfoChip(
                      title: 'CANE',
                      subtitle: 'Category',
                      bgColor: const Color(0xFFD8EEDC),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Text(
                'About Luna',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: PetDetailsView.textDark,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Luna is not just a pet to me, she is a part of my family. '
                    'One look into her eyes makes all my tiredness fade away. '
                    'She is loving, intelligent, and incredibly loyal. The way she '
                    'gets excited when I come home is impossible to describe in words. '
                    'She loves to play, but she also enjoys sitting quietly by my side. '
                    'Luna is my daily source of happiness and my best companion.',
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.7,
                  color: PetDetailsView.textLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bgColor;

  const _InfoChip({
    required this.title,
    required this.subtitle,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }
}
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: const Color(0xFF1F2937),
        ),
      ),
    );
  }
}