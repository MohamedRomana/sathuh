import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors.dart';
import 'custom_shimmer.dart';

class CustomListShimmer extends StatelessWidget {
  const CustomListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder:
            (context, index) => Container(
              height: 100.h,
              width: 343.w,
              margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemCount: 20,
      ),
    );
  }
}
