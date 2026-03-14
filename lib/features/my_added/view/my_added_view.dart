import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/parkList.dart';
import '../widgets/pet_list.dart';

class MyAddedView extends StatelessWidget {
  const MyAddedView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F4F7),
        appBar: AppBar(
          title: const Text("My Added"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const BackButton(),
        ),
        body: Column(
          children: [

            SizedBox(height: 10.h),

            /// TAB BAR
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: const Color(0xffEAF6F5),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicatorPadding: EdgeInsets.zero, // ✅ এটা যোগ করুন
                indicator: BoxDecoration(
                  color: const Color(0xff0F766E),
                  borderRadius: BorderRadius.circular(26.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xff374151),
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Text("Pet"),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Text("Park"),
                    ),
                  ),
                ],
              ),
            )
,

            SizedBox(height: 10.h),

            // TAB VIEW
            Expanded(
              child: TabBarView(
                children: [
                  PetList(),
                  ParkList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}