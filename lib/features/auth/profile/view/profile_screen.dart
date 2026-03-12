import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';
import '../widgets/logout_tile.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item_data.dart';
import '../widgets/profile_menu_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProfileMenuItemData> menuItems = [
      ProfileMenuItemData(
        title: 'Edit Profile',
        subtitle: 'Aggiorna i tuoi dati personali',
        icon: Icons.edit_outlined,
      ),
      ProfileMenuItemData(
        title: 'Order History',
        subtitle: 'Purchase Service',
        icon: Icons.shopping_cart_outlined,
      ),
      ProfileMenuItemData(
        title: 'My Added',
        subtitle: 'See your pet and park',
        icon: Icons.shopping_cart_outlined,
      ),
      ProfileMenuItemData(
        title: 'Transaction History',
        subtitle: '12/05/2025',
        icon: Icons.currency_exchange_outlined,
      ),
      ProfileMenuItemData(
        title: 'Privacy',
        subtitle: 'Manage your privacy preferences',
        icon: Icons.privacy_tip_outlined,
      ),
      ProfileMenuItemData(
        title: 'Notifications',
        subtitle: 'Configure notifications',
        icon: Icons.notifications_none_outlined,
      ),
      ProfileMenuItemData(
        title: 'Safety',
        subtitle: 'Password e autenticazione',
        icon: Icons.verified_user_outlined,
      ),
      ProfileMenuItemData(
        title: 'Help and Support',
        subtitle: 'FAQ and assistance',
        icon: Icons.help_outline,
      ),
      ProfileMenuItemData(
        title: 'Terms of Service',
        subtitle: 'Read the terms of use',
        icon: Icons.description_outlined,
      ),
      ProfileMenuItemData(
        title: 'Privacy Policy',
        subtitle: 'Privacy Policy',
        icon: Icons.shield_outlined,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: Stack(
        children: [
           ProfileHeader(),
          Positioned(
            top: 220.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24.r),
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
                itemCount: menuItems.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  if (index == menuItems.length) {
                    return LogoutTile(
                      onTap: () {
                        Get.find<ProfileController>().logout();
                      },

                    );
                  }

                  final item = menuItems[index];
                  return ProfileMenuTile(
                    item: item,
                    onTap: () {
                      if (item.title == 'Edit Profile') {
                        Get.toNamed('/change-password');
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}