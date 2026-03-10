import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show ElevatedButton, Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class primary_button extends StatelessWidget {
  const primary_button({
    super.key,
    required this.primaryColor,
    required this.text,
    required this.onPressed,
  });

  final Color primaryColor;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}