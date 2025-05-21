import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../payment/payment.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({
    super.key,
    required this.totalDistance,
    this.travelTime,
    this.arrivalTime,
  });

  final double? totalDistance;
  final int? travelTime;
  final String? arrivalTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: LocaleKeys.serviceDetails.tr(),
            size: 21.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(50),
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: LocaleKeys.arrival_abbreviation.tr(),
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 5.h,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text:
                            '${totalDistance!.toStringAsFixed(0)} ${LocaleKeys.meter.tr()}',
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(50),
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: LocaleKeys.time.tr(),
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 5.h,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: '$travelTime ${LocaleKeys.minute.tr()}',
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(50),
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: LocaleKeys.arrival_time.tr(),
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 5.h,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: '$arrivalTime',
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 343.w,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(50),
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
                      text: LocaleKeys.meter_price.tr(),
                      size: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    AppText(
                      text: '20 ${LocaleKeys.sar.tr()}',
                      size: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    AppText(
                      text: LocaleKeys.cost.tr(),
                      size: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    AppText(
                      text: '20 ${LocaleKeys.sar.tr()}',
                      size: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppButton(
            color: Colors.white,
            onPressed: () {
              AppRouter.pop(context);
              showModalBottomSheet(
                context: context,
                builder: (context) => const PaymentSheet(),
              );
            },
            child: AppText(
              text: LocaleKeys.confirm.tr(),
              size: 21.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
