import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../app/routes/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const Color _primary = Color(0xFF0A7C6B);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 70.h,
            padding: EdgeInsets.fromLTRB(26.w, 16.h, 26.w, 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.06),
                  blurRadius: 18,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navIcon(Icons.home_rounded, 0),
                _navIcon(Icons.map_outlined, 1),
                SizedBox(width: 55.w),
                _navIcon(Icons.pets_outlined, 2),
                _navIcon(Icons.person_outline_rounded, 3),
              ],
            ),
          ),

          Positioned(
            top: -18.h,
            child: GestureDetector(
              onTap: () => onTap(4),
              child: Container(
                width: 60.w,
                height: 60.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: _primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _primary.withOpacity(.30),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.addAnimal);
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 27.sp,
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, int index) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        size: 28.sp,
        color: isActive ? _primary : const Color(0xFF6D6D6D),
      ),
    );
  }
}