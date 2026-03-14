import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PetCard extends StatelessWidget {
  final String image;
  final String name;

  const PetCard({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black12,
          )
        ],
      ),
      child: Row(
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 12.w),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  "Male • 2 Years • 12/02/2025",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),

          /// TAG
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Text(
              "CANE",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}