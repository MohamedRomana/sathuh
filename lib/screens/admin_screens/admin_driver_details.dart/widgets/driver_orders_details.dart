import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import '../../../../core/constants/contsants.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class DriverOrdersDetails extends StatelessWidget {
  const DriverOrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminBottomNav(
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
                          text: 'اسم العميل',
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
                          text: 'اسم السائق',
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
                          text: 'اسم الخدمه',
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
                          text: 'هاتف العميل',
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
                          text: 'هاتف السائق',
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
                          text: 'مكان التوصيل',
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
                          text: 'مكان الوصول',
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
                          text: 'عدد الامتار / الكيلو',
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
                          text: 'سعر الخدمه',
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
            ],
          ),
        ],
      ),
    );
  }
}
