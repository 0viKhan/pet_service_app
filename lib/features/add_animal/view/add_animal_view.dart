import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_dropdown_field.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../controller/add_animal_controller.dart';
class AddAnimalView extends GetView<AddAnimalController> {
  const AddAnimalView({super.key});
  static const Color primaryColor = Color(0xFF0A7C6B);
  static const Color pageBg = Colors.white;
  static const Color textDark = Color(0xFF2E2E2E);
  static const Color textLight = Color(0xFF9AA1A7);
  static const Color borderColor = Color(0xFFE3E7E7);
  static const Color inputBg = Color(0xFFF8FAFA);
  static const Color chipBg = Color(0xFFF1F3F3);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: pageBg,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                child: Column(
                  children: [
                    _buildTopBar(),
                    SizedBox(height: 16.h),
                    _buildTabBar(),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: _buildPetForm(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: _buildParkForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return SizedBox(
      height: 34.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: Get.back,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: const Color(0xFF5C6670),
              ),
            ),
          ),
          Text(
            'Add Animal',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 42.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F4),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFDDE5E3)),
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF5F6B66),
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pets, size: 16),
                SizedBox(width: 6),
                Text('Add Pet'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.park_outlined, size: 16),
                SizedBox(width: 6),
                Text('Add Park'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18.h),
        _buildLabel('Name'),
        SizedBox(height: 6.h),
        AppTextField(
          hintText: 'Enter your pet name',
          controller: controller.petNameController,
          fillColor: inputBg,
          borderRadius: 20.r,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: AppDropdownField(
                label: 'Age',
                value: controller.selectedAge,
                items: controller.ageList,
                onChanged: controller.setAge,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: AppDropdownField(
                label: 'Gender',
                value: controller.selectedGender,
                items: controller.genderList,
                onChanged: controller.setGender,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _buildLabel('About Pet'),
        SizedBox(height: 6.h),
        AppTextField(
          hintText: 'Enter your animal memo',
          controller: controller.aboutPetController,
          fillColor: inputBg,
          borderRadius: 20.r,
          maxLines: 3,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
        ),
        SizedBox(height: 12.h),
        _buildLabel('Animal Type'),
        SizedBox(height: 8.h),
        _buildAnimalTypes(),
        SizedBox(height: 14.h),
        Row(
          children: [
            _buildLabel('Image'),
            Text(
              ' (Max 5)',
              style: TextStyle(
                fontSize: 11.sp,
                color: textLight,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        _buildImagePicker(),
        SizedBox(height: 22.h),
        primary_button(
          primaryColor: primaryColor,
          text: 'AddPet',
          onPressed: controller.submitPet,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildParkForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18.h),
        _buildLabel('Park Name'),
        SizedBox(height: 6.h),
        AppTextField(
          hintText: 'Enter your park name',
          controller: controller.parkNameController,
          fillColor: inputBg,
          borderRadius: 20.r,
        ),
        SizedBox(height: 12.h),
        _buildLabel('Location'),
        SizedBox(height: 6.h),
        AppTextField(
          hintText: 'Room',
          controller: controller.locationController,
          fillColor: inputBg,
          borderRadius: 20.r,
        ),
        SizedBox(height: 12.h),
        _buildLabel('Link'),
        SizedBox(height: 6.h),
        AppTextField(
          hintText: 'https://maps.google.com/xxxxxx',
          controller: controller.linkController,
          keyboardType: TextInputType.url,
          fillColor: inputBg,
          borderRadius: 20.r,
        ),
        SizedBox(height: 12.h),
        _buildLabel('Image'),
        SizedBox(height: 8.h),
        _buildImagePicker(),
        SizedBox(height: 22.h),
        primary_button(
          primaryColor: primaryColor,
          text: 'AddPark',
          onPressed: controller.submitPark,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
    );
  }



  Widget _buildAnimalTypes() {
    return Obx(
          () => Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: controller.animalTypes.map((item) {
          final title = item['title']!;
          final emoji = item['emoji']!;
          final isSelected = controller.selectedAnimalType.value == title;

          return GestureDetector(
            onTap: () => controller.setAnimalType(title),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : chipBg,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    emoji,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF5C6660),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildImagePicker() {
    return Container(
      width: 34.w,
      height: 34.w,
      decoration: BoxDecoration(
        color: const Color(0xFFD8DEDD),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFC6CFCD)),
      ),
      child: Icon(
        Icons.add_a_photo_outlined,
        size: 16.sp,
        color: const Color(0xFF5F6766),
      ),
    );
  }
}
