import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/contsants.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../user_screens/driver_details/rates/product_rates.dart';
import '../home_layout/admin_home_layout.dart';

class AdminDriverDetails extends StatelessWidget {
  const AdminDriverDetails({super.key});

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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomAppBar(title: LocaleKeys.driver.tr()),
                const DriverHeader(),
                const AboutDriver(),
                const DriverOrders(),
                const ProductRates(),
                AppButton(
                  onPressed: () {
                    openWhatsApp('0100020202020');
                  },
                  color: AppColors.secondray,
                  top: 24.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.img.social.path,
                        height: 30.w,
                        width: 30.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 8.w),
                      AppText(
                        text: LocaleKeys.contact_via_whatsapp.tr(),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 120.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DriverOrders extends StatelessWidget {
  const DriverOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: AppText(
            start: 16.w,
            text: LocaleKeys.orders.tr(),
            size: 20.sp,
            fontWeight: FontWeight.bold,
            top: 24.h,
            bottom: 16.h,
          ),
        ),
        Container(
          padding: EdgeInsetsDirectional.all(16.r),
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
          child: ListView.separated(
            padding: EdgeInsetsDirectional.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder:
                (BuildContext context, int index) => SizedBox(height: 16.h),
            itemCount: 10,
            itemBuilder:
                (BuildContext context, int index) => InkWell(
                  onTap: () {
                    // AppRouter.navigateTo(
                    //     context,
                    //     OrderDetails(
                    //       id: AppCubit.get(context).ordersList[index]['id'],
                    //     ));
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 343.w,
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(15.r),
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
                                text: '${LocaleKeys.order_number.tr()} #45454',
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
                                    text: "10/10/2022",
                                    size: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppText(
                            text: '${LocaleKeys.serviceName.tr()}: خدمة سطحة',
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
                                  text: 'مكتمل',
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
        ),
      ],
    );
  }
}

class AboutDriver extends StatelessWidget {
  const AboutDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
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
      child: Column(
        children: [
          Row(
            children: [
              AppText(
                text: LocaleKeys.service_name.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'سطحه انقاذ',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: LocaleKeys.city.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'الدقهليه',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: LocaleKeys.region.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'المنصورة',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),

          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: LocaleKeys.phone.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: '+2010123456789',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: LocaleKeys.service_24_7.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'نعم',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),

          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),
          Row(
            children: [
              AppText(
                text: LocaleKeys.service_provider_name.tr(),
                family: FontFamily.tajawalMedium,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'محمد احمد علي',
                family: FontFamily.tajawalMedium,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DriverHeader extends StatelessWidget {
  const DriverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.secondray,
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(250.r),
                bottomStart: Radius.circular(250.r),
              ),
              border: Border.all(color: AppColors.primary, width: 7.w),
            ),
          ),
          Container(
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.secondray,
              border: Border.symmetric(
                vertical: BorderSide(color: AppColors.primary, width: 7.w),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(top: 50.h),
                  decoration: BoxDecoration(
                    color: AppColors.third,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.asset(
                      Assets.img.driver.path,
                      height: 150.w,
                      width: 150.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 100.h,
            start: 140.w,
            child: AppText(
              bottom: 16.h,
              top: 16.h,
              text: 'محمد احمد',
              size: 24.sp,
              color: Colors.white,
            ),
          ),
          PositionedDirectional(
            bottom: 90.h,
            start: 140.w,
            end: 140.w,
            child: RatingBar.readOnly(
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              initialRating: 3.5,
              maxRating: 5,
              isHalfAllowed: true,
              halfFilledIcon: Icons.star_half,
              size: 18.sp,
            ),
          ),
          PositionedDirectional(
            bottom: 20.h,
            start: MediaQuery.of(context).size.width / 2 - 30.w,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                makePhoneCall('01000000000');
              },
              child: Container(
                height: 60.w,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 2.r),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call, color: Colors.red, size: 24.sp),
                    const AppText(
                      text: 'Call',
                      color: Colors.red,
                      family: FontFamily.tajawalBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 50.h,
            start: MediaQuery.of(context).size.width / 2 + 60.w,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changebottomAdminNavIndex(3);
                AppRouter.navigateAndFinish(context, const AdminHomeLayout());
              },
              child: Container(
                height: 60.w,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 2.r),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat, color: Colors.green, size: 24.sp),
                    const AppText(
                      text: 'Chat',
                      color: Colors.green,
                      family: FontFamily.tajawalBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 50.h,
            end: MediaQuery.of(context).size.width / 2 + 60.w,
            child: Container(
              height: 60.w,
              width: 60.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 2.r),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share_location, color: Colors.blue, size: 24.sp),
                  AppText(
                    text: 'Location',
                    size: 12.sp,
                    color: Colors.blue,
                    family: FontFamily.tajawalBold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
