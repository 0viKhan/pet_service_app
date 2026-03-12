import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/photo_picker_service.dart';
import '../../../../core/widgets/image_picker_bottom_sheet.dart' hide PhotoPickerService;
import '../controller/profile_controller.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});

  final PhotoPickerService _photoPickerService = Get.find<PhotoPickerService>();
  final ProfileController _profileController = Get.find<ProfileController>();

  Future<void> _pickAndUploadImage(BuildContext context) async {
    await ImagePickerBottomSheet.show(
      context,
      photoPickerService: _photoPickerService,
    );

    if (_photoPickerService.imageList.isNotEmpty) {
      final File pickedImage = _photoPickerService.imageList.first;
      await _profileController.uploadProfileImage(pickedImage);
    }
  }

  ImageProvider _getProfileImage() {
    if (_profileController.selectedLocalImage.value != null) {
      return FileImage(_profileController.selectedLocalImage.value!);
    }

    if (_profileController.profileImageUrl.value.isNotEmpty) {
      return NetworkImage(_profileController.profileImageUrl.value);
    }

    return const AssetImage('assets/images/cat.png');
  }

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
            onTap: () => _pickAndUploadImage(context),
            child: Obx(
                  () => Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 34.r,
                    backgroundColor: Colors.white24,
                    backgroundImage: _getProfileImage(),
                  ),
                  Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: _profileController.isUploading.value
                        ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF006D5B),
                      ),
                    )
                        : Icon(
                      Icons.camera_alt_outlined,
                      size: 16.sp,
                      color: const Color(0xFF006D5B),
                    ),
                  ),
                ],
              ),
            ),
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