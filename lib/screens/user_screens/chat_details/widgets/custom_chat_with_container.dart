// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomChatWithContainer extends StatelessWidget {
  const CustomChatWithContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsetsDirectional.only(
        top: 16.h,
        start: 16.w,
        end: 16.w,
        bottom: 21.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
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
      child: Row(
        children: [
          Container(
            height: 40.w,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.secondray,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: Image.asset(
                Assets.img.driver.path,
                height: 40.w,
                width: 40.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          AppText(
            text: "${LocaleKeys.chat_with.tr()} محمد احمد",
            size: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
