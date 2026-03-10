import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled1/app/routes/app_routes.dart';
import '../widgets/pets_section.dart';
import '../widgets/service_card.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const Color _bgColor = Color(0xFFF4F5F4);
  static const Color _primary = Color(0xFF0A7C6B);
  static const Color _textDark = Color(0xFF1F2937);
  static const Color _textLight = Color(0xFF7B8794);

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

                    const PetsSection(),
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
        Container(
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
            image: const DecorationImage(
              image: AssetImage('assets/images/doctor_girl.jpg'),
              fit: BoxFit.cover,
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
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
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
         onTap:(){
           Get.toNamed(AppRoutes.notification);
         } ,
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
    final parks = [
      {
        'title': 'Villa Borghese',
        'location': 'Rome',
        'image': 'assets/images/girl1.jpg',
      },
      {
        'title': 'Parco Sempione',
        'location': 'Milan',
        'image': 'assets/images/girl2.jpg',
      },
      {
        'title': 'Giardino',
        'location': 'Florence',
        'image': 'assets/images/girl2.jpg',
      },
      {
        'title': 'Giardino',
        'location': 'Florence',
        'image': 'assets/images/girl1.jpg',
      },
    ];

    return SizedBox(
      height: 178.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: parks.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final park = parks[index];
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
                Container(
                  height: 95.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14.r),
                    ),
                    image: DecorationImage(
                      image: AssetImage(park['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 9.h, 10.w, 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        park['title']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF39424E),
                        ),
                      ),
                      SizedBox(height: 5.h),
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
                              park['location']!,
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
  }
  Widget _navIcon(IconData icon, bool active) {
    return Icon(
      icon,
      size: 24.sp,
      color: active ? _primary : const Color(0xFF6D6D6D),
    );
  }
}