import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/booking_card.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        title: const Text("Order History"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking History",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20.h),

            BookingCard(
              status: "Upcoming",
              price: "\$21",
              time: "9:30 PM",
              date: "Tuesday, Feb 5",
              isFinished: false,
            ),

            SizedBox(height: 16.h),

            BookingCard(
              status: "Finished",
              price: "\$21",
              time: "9:30 PM",
              date: "Tuesday, Feb 5",
              isFinished: true,
            ),
          ],
        ),
      ),
    );
  }
}