import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/contsants.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/driver_bottom_nav.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class DrivOrderDetails extends StatelessWidget {
  final bool isHistory;
  const DrivOrderDetails({super.key, this.isHistory = false});

  @override
  Widget build(BuildContext context) {
    return DriverBottomNav(
      body: Stack(
        children: [
          Image.asset(
            Assets.img.background.path,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withAlpha(210),
          ),
          Column(
            children: [
              CustomAppBar(title: LocaleKeys.orderDetails.tr()),
              Container(
                width: 343.w,
                padding: EdgeInsets.all(16.r),
                margin: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(100),
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
                          text: LocaleKeys.customer_name.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: 'محمد احمد',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.driver_name.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: 'خالد علي',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.service_name.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: 'خدمة سطحه',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.customer_phone.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            makePhoneCall('0100000000');
                          },
                          child: SizedBox(
                            width: 150.w,
                            child: const AppText(
                              textAlign: TextAlign.end,
                              text: '0100000000',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.driver_phone.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            makePhoneCall('0100000000');
                          },
                          child: SizedBox(
                            width: 150.w,
                            child: const AppText(
                              textAlign: TextAlign.end,
                              text: '0100000000',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.pickup_location.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: 'address',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.dropoff_location.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: 'address',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.distance_or_meter.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: '100 كم',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.service_price.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: AppText(
                            textAlign: TextAlign.end,
                            text: '1000 ${LocaleKeys.sar.tr()}',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              if (!isHistory)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: AppButton(
                        width: 150.w,
                        color: Colors.red,
                        start: 20.w,
                        onPressed: () {},
                        child: AppText(
                          text: LocaleKeys.reject.tr(),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                      child: AppButton(
                        width: 150.w,
                        color: Colors.green,
                        end: 20.w,
                        onPressed: () {},
                        child: AppText(
                          text: LocaleKeys.accept.tr(),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
