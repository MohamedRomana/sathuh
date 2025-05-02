import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_shimmer.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomOrdersShimmer extends StatelessWidget {
  const CustomOrdersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return Container(
            width: 343.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "${LocaleKeys.orderNumber.tr()} 23456",
                      color: Colors.grey.withOpacity(.2),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.grey.withOpacity(.2),
                          size: 18.sp,
                        ),
                        AppText(
                          start: 5.w,
                          text: "منذ 2 ساعة",
                          size: 12.sp,
                          family: FontFamily.tajawalLight,
                          color: Colors.grey.withOpacity(.2),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "اسم الخدمة: تنظيف وتعقيم",
                      family: FontFamily.tajawalLight,
                      color: Colors.grey.withOpacity(.2),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(.2),
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: AppText(
                        text: "جاري التنفيذ",
                        color: Colors.grey.withOpacity(.2),
                        size: 13.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
