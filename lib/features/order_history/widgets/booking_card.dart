import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingCard extends StatelessWidget {
  final String status;
  final String price;
  final String time;
  final String date;
  final bool isFinished;

  const BookingCard({
    super.key,
    required this.status,
    required this.price,
    required this.time,
    required this.date,
    required this.isFinished,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isFinished
                      ? Colors.green.withOpacity(.1)
                      : Colors.orange.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isFinished
                        ? Colors.green
                        : Colors.orange,
                    fontSize: 12.sp,
                  ),
                ),
              ),

              const Spacer(),

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Text(
                  "Paid",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              Text(
                "Grooming Service",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                price,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              if (!isFinished)
                Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),

              SizedBox(width: 8.w),

              CircleAvatar(
                radius: 14.r,
                backgroundColor: Colors.teal.withOpacity(.1),
                child: const Icon(
                  Icons.chat,
                  size: 14,
                  color: Colors.teal,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}