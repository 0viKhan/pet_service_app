import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

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
          "Terms and conditions",
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
              "Terms and conditions",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "By using the Galapagos app, you agree to comply with and be bound by the following terms and conditions. Please read them carefully before using our services.",
              style: TextStyle(
                fontSize: 13.5.sp,
                color: const Color(0xFF444444),
                height: 1.7,
              ),
            ),
            SizedBox(height: 24.h),

            Text(
              "How We Use Your Information",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "We use the information we collect to:",
              style: TextStyle(
                fontSize: 13.5.sp,
                color: const Color(0xFF444444),
                height: 1.7,
              ),
            ),
            SizedBox(height: 8.h),
            _BulletList(items: const [
              "Provide and improve our app's services.",
              "Communicate with you about your account, updates, and promotions.",
              "Personalize your experience and recommend services based on your preferences.",
              "Ensure the security and integrity of our app.",
            ]),
          ],
        ),
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
          .map(
            (item) => Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 7.h, right: 8.w),
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
        ),
      )
          .toList(),
    );
  }
}