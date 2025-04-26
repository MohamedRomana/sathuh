// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/screens/start/on_boarding/on_boarding.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      final currentLocale = context.locale.languageCode;
      if (currentLocale == 'en') {
        AppCubit.get(context).changeLangIndexs(index: 1);
      } else {
        AppCubit.get(context).changeLangIndexs(index: 0);
      }
    });
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 24.w,
              end: 24.w,
              top: 90.h,
            ),
            child: Column(
              children: [
                SizedBox(
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
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: AppText(
                    text: LocaleKeys.chooseLang.tr(),
                    color: AppColors.fontColor,
                    size: 20.sp,
                    family: FontFamily.tajawalBold,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: AppText(
                    top: 18.h,
                    bottom: 30.h,
                    text: LocaleKeys.please_select_language.tr(),
                    color: AppColors.fontColor.withOpacity(0.5),
                    size: 16.sp,
                    family: FontFamily.tajawalMedium,
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changeLangIndexs(index: 0);
                      },
                      child: Container(
                        width: 343.w,
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 10.w,
                          vertical: 18.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Assets.img.saudiArabia.path,
                                  height: 24.w,
                                  width: 24.w,
                                  fit: BoxFit.cover,
                                ),
                                AppText(
                                  start: 23.w,
                                  text: "العربية",
                                  color: AppColors.fontColor,
                                  size: 18.sp,
                                  family: FontFamily.tajawalMedium,
                                ),
                              ],
                            ),
                            Container(
                              height: 20.w,
                              width: 20.w,
                              decoration: const BoxDecoration(
                                color: AppColors.borderColor,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                margin: EdgeInsets.all(3.w),
                                height: 20.w,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  color:
                                      AppCubit.get(context).changeLangIndex == 0
                                          ? AppColors.primary
                                          : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changeLangIndexs(index: 1);
                      },
                      child: Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 10.w,
                          vertical: 18.h,
                        ),
                        margin: EdgeInsets.only(top: 18.h, bottom: 100.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Assets.img.unitedKingdom.path,
                                  height: 24.w,
                                  width: 24.w,
                                  fit: BoxFit.cover,
                                ),
                                AppText(
                                  start: 23.w,
                                  text: "English",
                                  color: AppColors.fontColor,
                                  size: 18.sp,
                                  family: FontFamily.tajawalMedium,
                                ),
                              ],
                            ),
                            Container(
                              height: 20.w,
                              width: 20.w,
                              decoration: const BoxDecoration(
                                color: AppColors.borderColor,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                margin: EdgeInsets.all(3.w),
                                height: 20.w,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  color:
                                      AppCubit.get(context).changeLangIndex == 1
                                          ? AppColors.primary
                                          : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                AppButton(
                  onPressed: () {
                    if (AppCubit.get(context).changeLangIndex == 0) {
                      CacheHelper.setLang('ar');
                      context.setLocale(const Locale('ar'));
                      AppRouter.navigateAndFinish(context, const OnBoarding());
                    } else if (AppCubit.get(context).changeLangIndex == 1) {
                      CacheHelper.setLang('en');
                      context.setLocale(const Locale('en'));
                      AppRouter.navigateAndFinish(context, const OnBoarding());
                    }
                  },
                  child: AppText(
                    text: LocaleKeys.confirm.tr(),
                    color: Colors.white,
                    size: 21.sp,
                    family: FontFamily.tajawalBold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
