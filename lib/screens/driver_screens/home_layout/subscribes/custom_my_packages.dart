import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/alert_dialog.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/locale_keys.g.dart';
import 'months_details.dart';
import 'years_details.dart';

class CustomMyPackages extends StatelessWidget {
  const CustomMyPackages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 343.w,
          margin: EdgeInsetsDirectional.all(16.r),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.annual_subscription.tr(),
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(height: 5.h),
                  Container(
                    width: 200.w,
                    child: AppText(
                      text: '1000 ${LocaleKeys.sar.tr()}',
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  customAlertDialog(
                    alertDialogHeight: 600.h,
                    alertDialogWidth: 343.w,

                    dialogBackGroundColor: Colors.transparent,
                    context: context,
                    child: const YearsDetails(),
                  );
                },
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 30.w,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 343.w,
          margin: EdgeInsetsDirectional.all(16.r),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.monthly_subscription.tr(),
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(height: 5.h),
                  Container(
                    width: 200.w,
                    child: AppText(
                      text: '1000 ${LocaleKeys.sar.tr()}',
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  customAlertDialog(
                    alertDialogHeight: 600.h,
                    alertDialogWidth: 343.w,
                    dialogBackGroundColor: Colors.transparent,
                    context: context,
                    child: const MonthsDetails(),
                  );
                },
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 30.w,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
