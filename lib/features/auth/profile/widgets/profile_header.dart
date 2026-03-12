import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/photo_picker_service.dart';
import '../../../../core/widgets/image_picker_bottom_sheet.dart' hide PhotoPickerService;

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});

  final PhotoPickerService photoPickerService = Get.find<PhotoPickerService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 56.h,
        left: 16.w,
        right: 16.w,
        bottom: 26.h,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF006D5B),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          GestureDetector(
            onTap: () async {
              await ImagePickerBottomSheet.show(
                context,
                photoPickerService: photoPickerService,
              );
            },
            child: Obx(() {
              final bool hasImage = photoPickerService.imageList.isNotEmpty;
              final File? selectedImage =
              hasImage ? photoPickerService.imageList.first : null;

              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 34.r,
                    backgroundColor: Colors.white24,
                    backgroundImage: hasImage
                        ? FileImage(selectedImage!)
                        : const AssetImage('assets/images/cat.png')
                    as ImageProvider,
                  ),
                  Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 16.sp,
                      color: const Color(0xFF006D5B),
                    ),
                  ),
                ],
              );
            }),
          ),

          SizedBox(height: 10.h),

          FutureBuilder<String>(
            future: LocalStorageService.getFullName(),
            builder: (context, snapshot) {
              final fullName = (snapshot.data ?? '').trim();

              return Text(
                fullName.isEmpty ? 'John Doe' : fullName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}