import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_button.dart';
import '../controller/otp_controller.dart';

class VerificationCodeView extends GetView<OtpController> {
  const VerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18.sp,
            color: const Color(0xFF475467),
          ),
        ),
        title: Text(
          'Verification Code',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF344054),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            final isSmallPhone = constraints.maxWidth < 360;

            final horizontalPadding = isTablet ? 32.w : 16.w;
            final contentMaxWidth = isTablet ? 520.w : double.infinity;

            final otpBoxSize = isTablet
                ? 64.w
                : isSmallPhone
                ? 46.w
                : 52.w;

            final otpSpacing = isTablet
                ? 12.w
                : isSmallPhone
                ? 6.w
                : 8.w;

            final otpFontSize = isTablet
                ? 24.sp
                : isSmallPhone
                ? 18.sp
                : 20.sp;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 12.h,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentMaxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: isTablet ? 28.h : 20.h),

                      Text(
                        'Verification Code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 26.sp : 22.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF101828),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Text(
                        'Enter the verification code that we have sent to your email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 14.sp : 12.sp,
                          color: const Color(0xFF667085),
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: isTablet ? 40.h : 30.h),

                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: otpSpacing,
                        runSpacing: otpSpacing,
                        children: List.generate(
                          4,
                              (index) => Container(
                            width: otpBoxSize,
                            height: otpBoxSize,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                isTablet ? 12.r : 10.r,
                              ),
                              border: Border.all(
                                color: index == 2
                                    ? const Color(0xFF0F6F67)
                                    : const Color(0xFFE4E7EC),
                                width: 1.4,
                              ),
                            ),
                            child: Text(
                              index == 0
                                  ? '4'
                                  : index == 1
                                  ? '7'
                                  : '',
                              style: TextStyle(
                                fontSize: otpFontSize,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF101828),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: isTablet ? 40.h : 30.h),

                      AppButton(
                        title: 'Continue',
                        onPressed: controller.onContinue,
                      ),

                      SizedBox(height: 18.h),

                      Text.rich(
                        TextSpan(
                          text: 'Re-send code in ',
                          style: TextStyle(
                            fontSize: isTablet ? 13.sp : 12.sp,
                            color: const Color(0xFF667085),
                          ),
                          children: [
                            TextSpan(
                              text: '0:43',
                              style: TextStyle(
                                color: const Color(0xFF0F6F67),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}