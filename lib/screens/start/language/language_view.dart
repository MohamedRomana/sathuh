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
          body: Column(
            children: [
              Image.asset(
                Assets.img.logo.path,
                height: 300.h,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: AppText(
                  top: 30.h,
                  bottom: 30.h,
                  text: LocaleKeys.chooseLang.tr(),
                  color: AppColors.secondray,
                  size: 20.sp,
                  family: FontFamily.tajawalBold,
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (AppCubit.get(context).changeLangIndex == 0) {
                    AppCubit.get(context).changeLangIndexs(index: -1);
                  } else {
                    AppCubit.get(context).changeLangIndexs(index: 0);
                  }
                },
                child: Container(
                  width: 311.w,
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppCubit.get(context).changeLangIndex == 0
                                ? AppColors.primary.withAlpha(50)
                                : Colors.grey.withAlpha(100),
                        spreadRadius: 1.r,
                        blurRadius: 5.r,
                        offset: Offset(3, 5.r),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: LocaleKeys.ar.tr(),
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            AppCubit.get(context).changeLangIndex == 0
                                ? AppColors.secondray
                                : Colors.grey,
                      ),
                      Container(
                        height: 22.w,
                        width: 22.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          margin: EdgeInsets.all(2.r),
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
                  if (AppCubit.get(context).changeLangIndex == 1) {
                    AppCubit.get(context).changeLangIndexs(index: -1);
                  } else {
                    AppCubit.get(context).changeLangIndexs(index: 1);
                  }
                },
                child: Container(
                  width: 311.w,
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppCubit.get(context).changeLangIndex == 1
                                ? AppColors.primary.withAlpha(50)
                                : Colors.grey.withAlpha(100),
                        spreadRadius: 1.r,
                        blurRadius: 5.r,
                        offset: Offset(3, 5.r),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: LocaleKeys.en.tr(),
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            AppCubit.get(context).changeLangIndex == 1
                                ? AppColors.secondray
                                : Colors.grey,
                      ),
                      Container(
                        height: 22.w,
                        width: 22.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          margin: EdgeInsets.all(2.r),
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
              AppButton(
                top: 35.h,
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
        );
      },
    );
  }
}
