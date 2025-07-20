import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomSubscriptions extends StatefulWidget {
  const CustomSubscriptions({super.key});

  @override
  State<CustomSubscriptions> createState() => _CustomSubscriptionsState();
}

class _CustomSubscriptionsState extends State<CustomSubscriptions> {
  @override
  void initState() {
    AppCubit.get(context).getSubscriptions();
    AppCubit.get(context).changesubScripeIndex(index: -1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            // InkWell(
            //   splashColor: Colors.transparent,
            //   highlightColor: Colors.transparent,
            //   onTap: () {
            //     if (AppCubit.get(context).subScripeIndex == 0) {
            //       AppCubit.get(context).changesubScripeIndex(index: -1);
            //     } else {
            //       AppCubit.get(context).changesubScripeIndex(index: 0);
            //     }
            //   },
            //   child: Container(
            //     width: 343.w,
            //     margin: EdgeInsetsDirectional.all(16.r),
            //     padding: EdgeInsets.all(16.r),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10.r),
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey,
            //           blurRadius: 5.r,
            //           spreadRadius: 1.r,
            //           offset: Offset(0, 5.r),
            //         ),
            //       ],
            //     ),
            //     child: Row(
            //       children: [
            //         Container(
            //           height: 20.w,
            //           width: 20.w,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             border: Border.all(color: AppColors.primary),
            //           ),
            //           child: Container(
            //             height: 20.w,
            //             width: 20.w,
            //             margin: EdgeInsets.all(2.r),
            //             decoration: BoxDecoration(
            //               color:
            //                   AppCubit.get(context).subScripeIndex == 0
            //                       ? AppColors.primary
            //                       : Colors.transparent,
            //               shape: BoxShape.circle,
            //             ),
            //           ),
            //         ),
            //         Container(width: 18.w),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             AppText(
            //               text: LocaleKeys.annual_subscription.tr(),
            //               size: 16.sp,
            //               fontWeight: FontWeight.bold,
            //             ),
            //             Container(height: 5.h),
            //             SizedBox(
            //               width: 200.w,
            //               child: AppText(
            //                 text: '1000 ${LocaleKeys.sar.tr()}',
            //                 size: 16.sp,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //         const Spacer(),
            //         InkWell(
            //           splashColor: Colors.transparent,
            //           highlightColor: Colors.transparent,
            //           onTap: () {
            //             customAlertDialog(
            //               alertDialogHeight: 600.h,
            //               alertDialogWidth: 343.w,
            //               dialogBackGroundColor: Colors.transparent,
            //               context: context,
            //               child: const YearsDetails(),
            //             );
            //           },
            //           child: Icon(
            //             Icons.error_outline_rounded,
            //             size: 30.w,
            //             color: AppColors.primary,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
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
                // if (AppCubit.get(context).subScripeIndex == 0) {
                //   customAlertDialog(
                //     alertDialogHeight: 600.h,
                //     alertDialogWidth: 343.w,

                //     dialogBackGroundColor: Colors.transparent,
                //     context: context,
                //     child: const YearsDetails(sub: true),
                //   );
                // } else if (AppCubit.get(context).subScripeIndex == 1) {
                //   customAlertDialog(
                //     alertDialogHeight: 600.h,
                //     alertDialogWidth: 343.w,

                //     dialogBackGroundColor: Colors.transparent,
                //     context: context,
                //     child: const MonthsDetails(sub: true),
                //   );
                // }
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
