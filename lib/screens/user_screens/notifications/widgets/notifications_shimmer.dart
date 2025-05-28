// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_shimmer.dart';

class CustomNotificationShimmer extends StatelessWidget {
  const CustomNotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        physics: const BouncingScrollPhysics(),
        itemCount: 7,
        separatorBuilder: (context, index) => Container(height: 16.h),
        itemBuilder: (context, index) {
          return Container(
            height: 90.h,
            width: 343.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.white,
              //     blurRadius: 5.r,
              //     spreadRadius: 1.r,
              //     offset: Offset(0, 5.r),
              //   ),
              // ],
            ),
          );
        },
      ),
    );
  }
}
