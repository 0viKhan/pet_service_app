import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

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
      body: Column(
        children: [
          _ProfileHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
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
                    return _LogoutTile(
                      onTap: () {
                        Get.offAllNamed('/login');
                      },
                    );
                  }

                  final item = menuItems[index];
                  return ProfileMenuTile(
                    item: item,
                    onTap: () {
                      // route handle
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

class _ProfileHeader extends StatelessWidget {
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
          CircleAvatar(
            radius: 34.r,
            backgroundColor: Colors.white24,
            backgroundImage: const AssetImage('assets/images/profile.png'),
            // NetworkImage use korle ekhane বসাও
          ),
          SizedBox(height: 10.h),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuTile extends StatelessWidget {
  final ProfileMenuItemData item;
  final VoidCallback onTap;

  const ProfileMenuTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2F0),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  item.icon,
                  color: const Color(0xFF006D5B),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1D2939),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF667085),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 22.sp,
                color: const Color(0xFF344054),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutTile extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFFF7ED),
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEDD5),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.logout,
                  color: const Color(0xFFEA580C),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFEA580C),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 22.sp,
                color: const Color(0xFFEA580C),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuItemData {
  final String title;
  final String subtitle;
  final IconData icon;

  ProfileMenuItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}