import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled1/app/routes/app_routes.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../auth/profile/controller/profile_controller.dart';
import '../controller/home_controller.dart';
import '../widgets/pets_section.dart';
import '../widgets/service_card.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  static const Color _bgColor = Color(0xFFF4F5F4);
  static const Color _primary = Color(0xFF0A7C6B);
  static const Color _textDark = Color(0xFF1F2937);
  static const Color _textLight = Color(0xFF7B8794);

  final ProfileController _profileController = Get.find<ProfileController>();
  final HomeController controller = Get.find<HomeController>();
  ImageProvider _getHomeProfileImage() {
    final File? localImage = _profileController.selectedLocalImage.value;
    final String networkImage = _profileController.profileImageUrl.value;

    if (localImage != null) {
      return FileImage(localImage);
    }

    if (networkImage.isNotEmpty) {
      return NetworkImage(networkImage);
    }

    return const AssetImage('assets/images/doctor_girl.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopHeader(),
                    SizedBox(height: 26.h),
                     PetsSection(),
                    SizedBox(height: 22.h),
                    _buildSectionHeader(
                      title: 'Nearest Park',
                      onTap: () {},
                    ),
                    SizedBox(height: 14.h),
                    _buildParkList(),
                    SizedBox(height: 24.h),
                    _buildSectionHeader(
                      title: 'Near By Service',
                      onTap: () {},
                    ),
                    SizedBox(height: 14.h),
                    const ServiceCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Row(
      children: [
        Obx(
              () => Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: _getHomeProfileImage(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9AA1A9),
                ),
              ),
              SizedBox(height: 2.h),
              FutureBuilder<String>(
                future: LocalStorageService.getFullName(),
                builder: (context, snapshot) {
                  final fullName = (snapshot.data ?? '').trim();

                  return Text(
                    fullName.isEmpty ? 'John Doe' : fullName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        _buildActionIcon(
          icon: Icons.chat_bubble_outline_rounded,
          showDot: false,
        ),
        SizedBox(width: 14.w),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.notification);
          },
          child: _buildActionIcon(
            icon: Icons.notifications_none_rounded,
            showDot: true,
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required bool showDot,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          icon,
          size: 22.sp,
          color: const Color(0xFF273043),
        ),
        if (showDot)
          Positioned(
            right: -1.w,
            top: 1.h,
            child: Container(
              width: 7.w,
              height: 7.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFF4B4B),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF202124),
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'View All',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: _primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParkList() {
    return Obx(() {

      if (controller.parkLoading.value) {
        return SizedBox(
          height: 178.h,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (controller.parks.isEmpty) {
        return SizedBox(
          height: 178.h,
          child: const Center(
            child: Text("No parks found"),
          ),
        );
      }

      return SizedBox(
        height: 178.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.parks.length,
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {

            final Map<String, dynamic> park =
            controller.parks[index] as Map<String, dynamic>;

            return Container(
              width: 142.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: const Color(0xFFE4E6E7),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// PARK IMAGE
                  Container(
                    height: 95.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(14.r),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          park['imageUrl'] ?? "",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 9.h, 10.w, 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// PARK NAME
                        Text(
                          park['parkName'] ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF39424E),
                          ),
                        ),

                        SizedBox(height: 5.h),

                        /// LOCATION
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 15.sp,
                              color: _primary,
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Text(
                                park['locationName'] ?? "",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xFF8B949E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  Widget _navIcon(IconData icon, bool active) {
    return Icon(
      icon,
      size: 24.sp,
      color: active ? _primary : const Color(0xFF6D6D6D),
    );
  }
}