import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomAboutProvider extends StatelessWidget {
  const CustomAboutProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.r,
            spreadRadius: 1.r,
            offset: Offset(0, 5.r),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppText(
                text: LocaleKeys.service_name.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'سطحه انقاذ',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: LocaleKeys.city.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'الدقهليه',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: LocaleKeys.region.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'المنصورة',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),

          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: LocaleKeys.phone.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: '+2010123456789',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: LocaleKeys.service_24_7.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'نعم',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),

          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),
          Row(
            children: [
              AppText(
                text: LocaleKeys.service_provider_name.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'محمد احمد علي',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
