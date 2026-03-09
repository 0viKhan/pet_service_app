import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_helper.dart';
import '../SplashController/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller;

    final isTablet = ResponsiveHelper.isTablet(context);
    final isSmallPhone = ResponsiveHelper.isSmallPhone(context);
    final screenHeight = ResponsiveHelper.screenHeight(context);

    final double horizontalPadding = ResponsiveHelper.value<double>(
      context,
      mobile: 24,
      tablet: 40,
    );

    final double contentMaxWidth = ResponsiveHelper.value<double>(
      context,
      mobile: 380,
      tablet: 520,
    );

    final double logoSize = ResponsiveHelper.value<double>(
      context,
      mobile: isSmallPhone ? 110 : 126,
      tablet: 150,
    );

    final double logoPadding = ResponsiveHelper.value<double>(
      context,
      mobile: 18,
      tablet: 22,
    );

    final double titleFontSize = ResponsiveHelper.value<double>(
      context,
      mobile: isSmallPhone ? 24 : 28,
      tablet: 34,
    );

    final double titleGap = ResponsiveHelper.value<double>(
      context,
      mobile: 12,
      tablet: 14,
    );

    final double loaderSize = ResponsiveHelper.value<double>(
      context,
      mobile: isSmallPhone ? 42 : 50,
      tablet: 56,
    );

    final double centerToLoaderSpacing = screenHeight < 700
        ? 56
        : ResponsiveHelper.value<double>(
      context,
      mobile: 80,
      tablet: 96,
    );

    final double bottomSpacing = ResponsiveHelper.value<double>(
      context,
      mobile: 40,
      tablet: 56,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0F6F67),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentMaxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: logoSize,
                        height: logoSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            isTablet ? 28.r : 22.r,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(logoPadding),
                          child: Image.asset(
                            'assets/images/splash_logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: titleGap.h),
                      Text(
                        'MyPetCare',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: titleFontSize.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  SpinKitCircle(
                    color: Colors.white,
                    size: loaderSize,
                  ),

                  SizedBox(height: bottomSpacing.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}