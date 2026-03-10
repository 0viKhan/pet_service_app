import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controller/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Column(
            children: [
              SizedBox(height: 4.h),
              Container(
                height: 58.w,
                width: 58.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F6F67),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/splash_logo.png',
                    width: 35.w,
                    height: 35.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF101828),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Create account and enjoy all services',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF667085),
                ),
              ),
              SizedBox(height: 18.h),

              Obx(
                    () => Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: const Color(0xFF0F6F67),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectRole('proprietario'),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 38.h,
                            decoration: BoxDecoration(
                              color: controller.isSelected('proprietario')
                                  ? const Color(0xFF0F6F67)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pets,
                                  size: 14.sp,
                                  color: controller.isSelected('proprietario')
                                      ? Colors.white
                                      : const Color(0xFF344054),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Proprietario',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: controller.isSelected('proprietario')
                                        ? Colors.white
                                        : const Color(0xFF344054),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectRole('professionista'),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 38.h,
                            decoration: BoxDecoration(
                              color: controller.isSelected('professionista')
                                  ? const Color(0xFF0F6F67)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.business_center_outlined,
                                  size: 14.sp,
                                  color: controller.isSelected('professionista')
                                      ? Colors.white
                                      : const Color(0xFF344054),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Professionista',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                    controller.isSelected('professionista')
                                        ? Colors.white
                                        : const Color(0xFF344054),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              AppTextField(
                controller: controller.firstNameController,
                hintText: 'First Name',
                prefixIcon: Icon(
                  Icons.person_outline,
                  size: 18.sp,
                  color: const Color(0xFF98A2B3),
                ),
              ),

              SizedBox(height: 12.h),

              AppTextField(
                controller: controller.lastNameController,
                hintText: 'Last Name',
                prefixIcon: Icon(
                  Icons.person_outline,
                  size: 18.sp,
                  color: const Color(0xFF98A2B3),
                ),
              ),

              SizedBox(height: 12.h),

              AppTextField(
                controller: controller.emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 18.sp,
                  color: const Color(0xFF98A2B3),
                ),
              ),

              SizedBox(height: 12.h),

              AppTextField(
                controller: controller.cityController,
                hintText: 'City',
                prefixIcon: Icon(
                  Icons.location_city_outlined,
                  size: 18.sp,
                  color: const Color(0xFF98A2B3),
                ),
              ),

              SizedBox(height: 12.h),

              Obx(
                    () => AppTextField(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  obscureText: controller.isPasswordHidden.value,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: 18.sp,
                    color: const Color(0xFF98A2B3),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: controller.togglePasswordVisibility,
                    child: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 18.sp,
                      color: const Color(0xFF98A2B3),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              Obx(
                    () => AppTextField(
                  controller: controller.confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: controller.isConfirmPasswordHidden.value,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: 18.sp,
                    color: const Color(0xFF98A2B3),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: controller.toggleConfirmPasswordVisibility,
                    child: Icon(
                      controller.isConfirmPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 18.sp,
                      color: const Color(0xFF98A2B3),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Obx(
                    () => AppButton(
                  title: 'Next',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.register();
                  },
                ),
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF98A2B3),
                    ),
                  ),
                  GestureDetector(
                    onTap: Get.back,
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F6F67),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}