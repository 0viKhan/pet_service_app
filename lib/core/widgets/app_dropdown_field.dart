import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppDropdownField extends StatelessWidget {
  final String label;
  final RxString value;
  final List<String> items;
  final Function(String) onChanged;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  static const Color textDark = Color(0xFF2E2E2E);
  static const Color inputBg = Color(0xFFF8FAFA);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Container(
            height: 46.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: inputBg,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Obx(
                  () => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value.value,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: textDark,
                  ),
                  items: items.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) {
                      onChanged(v);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}