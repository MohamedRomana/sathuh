import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../driv_order_details/driv_order_details.dart';

class CustomCurrentOrders extends StatelessWidget {
  const CustomCurrentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          start: 16.w,
          text: LocaleKeys.current_orders.tr(),
          size: 20.sp,
          fontWeight: FontWeight.bold,
          bottom: 16.h,
        ),
        ListView.separated(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 15,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder:
              (context, index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppRouter.navigateTo(context, const DrivOrderDetails());
                },
                child: Container(
                  width: 343.w,
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
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: '${LocaleKeys.orderNumber.tr()} #1234',
                              size: 16.sp,
                              family: 'DINArabic-Medium',
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                  size: 14.sp,
                                ),
                                AppText(
                                  text: "منذ 10 دقائق",
                                  size: 14.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        AppText(
                          text: '${LocaleKeys.serviceName.tr()}: خدمة سطحه',
                          size: 16.sp,
                          family: 'DINArabic-Light',
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Container(
                            height: 24.h,
                            width: 83.w,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                color: const Color(0xffFF8800),
                              ),
                            ),
                            child: Center(
                              child: AppText(
                                text: 'في الطريق',
                                size: 13.sp,
                                color: const Color(0xffFF8800),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ),
      ],
    );
  }
}
