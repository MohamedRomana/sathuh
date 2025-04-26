import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../auth/views/login/login.dart';

class TypesView extends StatelessWidget {
  const TypesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 33.w,
                width: 33.w,
                margin: EdgeInsetsDirectional.only(start: 38.w, top: 58.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Center(
                  child: AppText(
                    text:
                        AppCubit.get(context).changeLangIndex == 0 ? 'EN' : 'ع',
                    color: Colors.white,
                    size: 14.sp,
                    family: FontFamily.tajawalBold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  top: 15.h,
                  bottom: 150.h,
                  text: LocaleKeys.welcome_to_flatbed.tr(),
                  size: 20.sp,
                  family: FontFamily.tajawalBold,
                ),
              ),
              Center(
                child: SizedBox(
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
              ),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  top: 23.h,
                  bottom: 26.h,
                  text: LocaleKeys.select_user_type.tr(),
                  size: 24.sp,
                  family: FontFamily.tajawalBold,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 94.w,
                    height: 55.h,
                    child: AppButton(
                      onPressed: () {
                        CacheHelper.setUserType('client');
                        AppRouter.navigateAndFinish(context, const LogIn());
                      },
                      color: AppColors.primary,
                      child: AppText(
                        text: LocaleKeys.client.tr(),
                        family: FontFamily.tajawalBold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 94.w,
                    height: 55.h,
                    child: AppButton(
                      onPressed: () {
                        CacheHelper.setUserType('driver');
                        AppRouter.navigateAndFinish(context, const LogIn());
                      },
                      color: AppColors.primary,
                      child: AppText(
                        text: LocaleKeys.driver.tr(),
                        family: FontFamily.tajawalBold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 94.w,
                    height: 55.h,
                    child: AppButton(
                      onPressed: () {
                        CacheHelper.setUserType('administration');
                        AppRouter.navigateAndFinish(context, const LogIn());
                      },
                      color: AppColors.primary,
                      child: AppText(
                        text: LocaleKeys.administration.tr(),
                        size: CacheHelper.getLang() == "en" ? 12.sp : 18.sp,
                        family: FontFamily.tajawalBold,
                        color: Colors.white,
                      ),
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
