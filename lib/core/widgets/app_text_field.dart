import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final double? borderRadius;
  final int maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;

  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.fillColor,
    this.borderRadius,
    this.maxLines = 1,
    this.contentPadding,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 20.r;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
        readOnly: readOnly,
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xFF1F2937),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF9CA3AF),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: fillColor ?? const Color(0xFFF8FAFA),
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: maxLines > 1 ? 12.h : 12.h,
              ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: Color(0xFF0F6F67),
              width: 1.2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}