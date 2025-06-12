import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/constants/contsants.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class AboutDriver extends StatelessWidget {
  final int index;
  const AboutDriver({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
                  SizedBox(
                    width: 180.w,
                    child: AppText(
                      textAlign: TextAlign.end,
                      text: 'سطحه انقاذ',
                      family: FontFamily.tajawalMedium,
                      size: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(height: 8.h),
              const Divider(color: Colors.grey),
              Container(height: 8.h),

              Row(
                children: [
                  AppText(
                    text: LocaleKeys.city.tr(),
                    family: FontFamily.tajawalMedium,
                    size: 16.sp,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 180.w,
                    child: AppText(
                      textAlign: TextAlign.end,
                      text: 'الدقهليه',
                      family: FontFamily.tajawalMedium,
                      size: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(height: 8.h),
              const Divider(color: Colors.grey),
              Container(height: 8.h),

              Row(
                children: [
                  AppText(
                    text: LocaleKeys.region.tr(),
                    family: FontFamily.tajawalMedium,
                    size: 16.sp,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 180.w,
                    child: AppText(
                      textAlign: TextAlign.end,
                      text: 'المنصورة',
                      family: FontFamily.tajawalMedium,
                      size: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(height: 8.h),

              const Divider(color: Colors.grey),
              Container(height: 8.h),

              Row(
                children: [
                  AppText(
                    text: LocaleKeys.phone.tr(),
                    family: FontFamily.tajawalMedium,
                    size: 16.sp,
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      makePhoneCall(
                        AppCubit.get(
                              context,
                            ).driversList[index]['user']['phone'] ??
                            "",
                      );
                    },
                    child: SizedBox(
                      width: 180.w,
                      child: AppText(
                        textAlign: TextAlign.end,
                        text:
                            AppCubit.get(
                              context,
                            ).driversList[index]['user']['phone'] ??
                            "",
                        family: FontFamily.tajawalMedium,
                        size: 16.sp,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 8.h),

              const Divider(color: Colors.grey),
              Container(height: 8.h),

              Row(
                children: [
                  AppText(
                    text: LocaleKeys.email.tr(),
                    family: FontFamily.tajawalMedium,
                    size: 16.sp,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onLongPress: () {
                      // Clipboard.setData(ClipboardData(text: AppCubit.get(context).driversList[index]['user']['email'] ?? ""));
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.all(0.r),
                            backgroundColor: Colors.transparent,
                            content: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AppText(
                                textAlign: TextAlign.end,
                                text:
                                    AppCubit.get(
                                      context,
                                    ).driversList[index]['user']['email'] ??
                                    "",
                                size: 16.sp,
                                family: FontFamily.tajawalBold,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      width: 180.w,
                      child: AppText(
                        textAlign: TextAlign.end,
                        text:
                            AppCubit.get(
                              context,
                            ).driversList[index]['user']['email'] ??
                            "",
                        family: FontFamily.tajawalMedium,
                        size: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 8.h),
              const Divider(color: Colors.grey),
              Container(height: 8.h),

              Row(
                children: [
                  AppText(
                    text: LocaleKeys.service_24_7.tr(),
                    family: FontFamily.tajawalMedium,
                    size: 16.sp,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 120.w,
                    child: AppText(
                      textAlign: TextAlign.end,
                      text: 'نعم',
                      family: FontFamily.tajawalMedium,
                      size: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
