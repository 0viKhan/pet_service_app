import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeBottomCard extends StatelessWidget {
  final dynamic item;
  final bool isTablet;
  final int currentIndex;
  final int totalPages;
  final VoidCallback onNext;
  final bool isLastPage;

  const WelcomeBottomCard({
    super.key,
    required this.item,
    required this.isTablet,
    required this.currentIndex,
    required this.totalPages,
    required this.onNext,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isTablet ? 28.w : 20.w,
        isTablet ? 28.h : 24.h,
        isTablet ? 28.w : 20.w,
        isTablet ? 32.h : 28.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
                  (dotIndex) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: _indicator(
                  active: currentIndex == dotIndex,
                  isTablet: isTablet,
                ),
              ),
            ),
          ),
          SizedBox(height: isTablet ? 24.h : 20.h),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.08, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Column(
              key: ValueKey(currentIndex),
              children: [
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isTablet ? 30.sp : 28.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  item.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isTablet ? 16.sp : 15.sp,
                    color: const Color(0xFF64748B),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isTablet ? 36.h : 30.h),
          SizedBox(
            width: double.infinity,
            height: isTablet ? 56.h : 50.h,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F6F67),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
              ),
              child: Text(
                isLastPage ? 'Get Started' : 'Next',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _indicator({
    required bool active,
    required bool isTablet,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: active
          ? (isTablet ? 28.w : 24.w)
          : (isTablet ? 20.w : 18.w),
      height: isTablet ? 7.h : 6.h,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0F6F67) : Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        border: active
            ? null
            : Border.all(color: Colors.grey.shade400, width: 1),
      ),
    );
  }
}