import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "At Absolutely Astrology, we respect and protect your privacy. This Privacy Policy explains how we collect, use, and safeguard your personal information when using our app.",
              style: TextStyle(
                fontSize: 13.5.sp,
                color: const Color(0xFF444444),
                height: 1.7,
              ),
            ),
            SizedBox(height: 24.h),

            _SectionTitle("How We Use Your Information"),
            SizedBox(height: 10.h),
            _BulletList(items: const [
              "To provide and improve our app's services.",
              "To communicate with you about your account, updates, and promotions.",
              "To personalize your experience and recommend services based on your preferences.",
              "To ensure the security and integrity of our app.",
            ]),
            SizedBox(height: 24.h),

            _SectionTitle("Information We Collect:"),
            SizedBox(height: 10.h),
            _BulletRichItem(
              label: "Personal Information:",
              value: " Name, email address, and phone number.",
            ),
            SizedBox(height: 4.h),
            _BulletRichItem(
              label: "Usage Data:",
              value: " Information on how you use the app and interactions with content.",
            ),
            SizedBox(height: 24.h),

            _SectionTitle("Contact Us"),
            SizedBox(height: 10.h),
            Text(
              "For any questions or concerns about your privacy, feel free to reach us:",
              style: TextStyle(
                fontSize: 13.5.sp,
                color: const Color(0xFF444444),
                height: 1.7,
              ),
            ),
            SizedBox(height: 12.h),
            _ContactRow(
              icon: Icons.email_outlined,
              text: "support@absolutelyastrology.com",
            ),
            SizedBox(height: 8.h),
            _ContactRow(
              icon: Icons.phone_outlined,
              text: "+123 456 7890",
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.h, right: 8.w),
              child: Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Color(0xFF444444),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 13.5.sp,
                  color: const Color(0xFF444444),
                  height: 1.7,
                ),
              ),
            ),
          ],
        ),
      ))
          .toList(),
    );
  }
}

class _BulletRichItem extends StatelessWidget {
  final String label;
  final String value;
  const _BulletRichItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h, right: 8.w),
          child: Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Color(0xFF444444),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13.5.sp,
                color: const Color(0xFF444444),
                height: 1.7,
              ),
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF0F766E)),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 13.5.sp,
            color: const Color(0xFF444444),
          ),
        ),
      ],
    );
  }
}