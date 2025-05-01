import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/colors.dart';
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
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Assets.img.logo.path,
                  height: 300.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
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

                Center(
                  child: Column(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          CacheHelper.setUserType('client');
                          AppRouter.navigateAndFinish(context, const LogIn());
                        },
                        child: Container(
                          width: 311.w,
                          padding: EdgeInsets.only(top: 10.h),
                          margin: EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 1.r,
                                blurRadius: 5.r,
                                offset: Offset(0, 5.r),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 16.w),
                              Image.asset(
                                Assets.img.client.path,
                                height: 100.w,
                                width: 100.w,
                                fit: BoxFit.fill,
                              ),
                              AppText(
                                start: 16.w,
                                text: LocaleKeys.client.tr(),
                                family: FontFamily.tajawalBold,
                                color: Colors.white,
                                size: 26.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          CacheHelper.setUserType('driver');
                          AppRouter.navigateAndFinish(context, const LogIn());
                        },
                        child: Container(
                          width: 311.w,
                          padding: EdgeInsets.only(top: 10.h),
                          margin: EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondray,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 1.r,
                                blurRadius: 5.r,
                                offset: Offset(0, 5.r),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 16.w),
                              Image.asset(
                                Assets.img.driver.path,
                                height: 100.w,
                                width: 100.w,
                                fit: BoxFit.fill,
                              ),
                              AppText(
                                start: 16.w,
                                text: LocaleKeys.driver.tr(),
                                family: FontFamily.tajawalBold,
                                color: Colors.white,
                                size: 26.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          CacheHelper.setUserType('administration');
                          AppRouter.navigateAndFinish(context, const LogIn());
                        },
                        child: Container(
                          width: 311.w,
                          padding: EdgeInsets.only(top: 10.h),
                          margin: EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffE3DFD6),
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 1.r,
                                blurRadius: 5.r,
                                offset: Offset(0, 5.r),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 16.w),
                              Image.asset(
                                Assets.img.manager.path,
                                height: 100.w,
                                width: 100.w,
                                fit: BoxFit.fill,
                              ),
                              AppText(
                                start: 16.w,
                                text: LocaleKeys.administration.tr(),
                                family: FontFamily.tajawalBold,
                                color: AppColors.secondray,
                                size: 26.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
