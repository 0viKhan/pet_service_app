import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controller/forgot_password_controller.dart';
import '../../registration/controller/register_controller.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments?['email'] ?? '';
    final otpType = Get.arguments?['otpType'] ?? 'forgot';

    final isRegisterFlow = otpType == 'register';

    final ForgotPasswordController? forgotController =
    Get.isRegistered<ForgotPasswordController>()
        ? Get.find<ForgotPasswordController>()
        : null;

    final RegisterController? registerController =
    Get.isRegistered<RegisterController>()
        ? Get.find<RegisterController>()
        : null;

    if (isRegisterFlow && registerController == null) {
      return const Scaffold(
        body: Center(
          child: Text('Register controller not found'),
        ),
      );
    }

    if (!isRegisterFlow && forgotController == null) {
      return const Scaffold(
        body: Center(
          child: Text('Forgot password controller not found'),
        ),
      );
    }

    final otpTextController = isRegisterFlow
        ? registerController!.otpController
        : forgotController!.otpController;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Text(
              'Verification Code',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF101828),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Enter the 4 digit code sent to\n$email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF667085),
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            AppTextField(
              controller: otpTextController,
              hintText: 'Enter OTP',
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            Obx(() {
              final isLoading = isRegisterFlow
                  ? registerController!.isVerifyingOtp.value
                  : forgotController!.isVerifyingOtp.value;

              return AppButton(
                title: 'Continue',
                isLoading: isLoading,
                onPressed: () {
                  if (isRegisterFlow) {
                    registerController!.verifyRegisterOtp(email);
                  } else {
                    forgotController!.verifyOtp();
                  }
                },
              );
            }),
            SizedBox(height: 26.h),
          ],
        ),
      ),
    );
  }
}