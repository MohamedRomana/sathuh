import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class CustomAuthHeader extends StatelessWidget {
  const CustomAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 61.h),
      height: 250.h,
      child: Column(
        children: [
          TweenAnimationBuilder(
            curve: Curves.fastOutSlowIn,
            tween: Tween<double>(begin: 0, end: 128.w),
            duration: const Duration(seconds: 1),
            builder:
                (context, value, child) => Image.asset(
                  Assets.img.logo.path,
                  height: value.h,
                  width: value.w,
                  fit: BoxFit.fill,
                ),
          ),
          TweenAnimationBuilder(
            curve: Curves.fastOutSlowIn,
            tween: Tween<double>(begin: 0, end: 30.sp),
            duration: const Duration(seconds: 1),
            builder:
                (context, value, child) => AppText(
                  top: 15.h,
                  textAlign: TextAlign.center,
                  text: 'سطحه',
                  color: AppColors.primary,
                  size: value.sp,
                  family: FontFamily.tajawalBold,
                ),
          ),
        ],
      ),
    );
  }
}
