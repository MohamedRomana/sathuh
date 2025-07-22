import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/alert_dialog.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import 'package:sathuh/gen/fonts.gen.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/contsants.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'choose_service.dart';

class CustomSubscriptions extends StatefulWidget {
  const CustomSubscriptions({super.key});

  @override
  State<CustomSubscriptions> createState() => _CustomSubscriptionsState();
}

class _CustomSubscriptionsState extends State<CustomSubscriptions> {
  @override
  void initState() {
    AppCubit.get(context).getSubscriptions();
    AppCubit.get(context).getSubYearscriptions();
    AppCubit.get(context).changesubScripeIndex(index: -1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return AppCubit.get(context).subYearMap['planType'] == null
            ? const ChooseService()
            : Column(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (AppCubit.get(context).subScripeIndex == 0) {
                      AppCubit.get(context).changesubScripeIndex(index: -1);
                    } else {
                      AppCubit.get(context).changesubScripeIndex(index: 0);
                    }
                  },
                  child: Container(
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
                        Container(
                          height: 20.w,
                          width: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Container(
                            height: 20.w,
                            width: 20.w,
                            margin: EdgeInsets.all(2.r),
                            decoration: BoxDecoration(
                              color:
                                  AppCubit.get(context).subScripeIndex == 0
                                      ? AppColors.primary
                                      : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Container(width: 18.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text:
                                  AppCubit.get(
                                            context,
                                          ).subYearMap['planType'] ==
                                          'yearly'
                                      ? LocaleKeys.annual_subscription.tr()
                                      : LocaleKeys.monthly_subscription.tr(),
                              size: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            Container(height: 5.h),
                            SizedBox(
                              width: 200.w,
                              child: AppText(
                                text:
                                    '${AppCubit.get(context).subYearMap['price'] ?? 0} ${LocaleKeys.sar.tr()}',
                                size: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (AppCubit.get(context).subScripeIndex == 1) {
                      AppCubit.get(context).changesubScripeIndex(index: -1);
                    } else {
                      AppCubit.get(context).changesubScripeIndex(index: 1);
                    }
                  },
                  child: Container(
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
                        Container(
                          height: 20.w,
                          width: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Container(
                            height: 20.w,
                            width: 20.w,
                            margin: EdgeInsets.all(2.r),
                            decoration: BoxDecoration(
                              color:
                                  AppCubit.get(context).subScripeIndex == 1
                                      ? AppColors.primary
                                      : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Container(width: 18.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text:
                                  AppCubit.get(context).subMap['planType'] ==
                                          'yearly'
                                      ? LocaleKeys.annual_subscription.tr()
                                      : LocaleKeys.monthly_subscription.tr(),
                              size: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            Container(height: 5.h),
                            SizedBox(
                              width: 200.w,
                              child: AppText(
                                text:
                                    '${AppCubit.get(context).subMap['price'] ?? 0} ${LocaleKeys.sar.tr()}',
                                size: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                AppButton(
                  onPressed: () {
                    if (AppCubit.get(context).subScripeIndex == -1) {
                      showFlashMessage(
                        message: 'اختر نوع الاشتراك',
                        type: FlashMessageType.warning,
                        context: context,
                      );
                    } else {
                      customAlertDialog(
                        context: context,
                        alertDialogHeight: 368.h,
                        alertDialogWidth: 311.w,
                        dialogBackGroundColor: AppColors.secondray,
                        child: const ConnectWithAdmin(),
                      );
                    }
                  },
                  child: AppText(
                    text: LocaleKeys.subscription.tr(),
                    size: 21.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
      },
    );
  }
}

class ConnectWithAdmin extends StatelessWidget {
  const ConnectWithAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(Assets.img.logo.path, height: 150.w, width: 150.w),
        AppText(
          text: 'تواصل مع الادمن',
          size: 18.sp,
          color: Colors.white,
          family: FontFamily.tajawalBold,
        ),

        AppButton(
          onPressed: () {
            openWhatsApps();
          },
          width: 300.w,
          color: Colors.transparent,
          borderColor: AppColors.third,
          child: AppText(
            text: LocaleKeys.contact_via_whatsapp.tr(),
            size: 18.sp,
            color: AppColors.third,
            family: FontFamily.tajawalBold,
          ),
        ),
      ],
    );
  }
}
