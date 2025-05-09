import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/constants/contsants.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
import 'package:sathuh/screens/user_screens/home_layout/home_layout.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'rates/product_rates.dart';

class DriverDetails extends StatelessWidget {
  const DriverDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
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
                CustomAppBar(title: LocaleKeys.provider.tr()),
                const ProviderHeader(),
                const CustomAboutProvider(),
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
                        text: 'تواصل عبر الواتساب',
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

class CustomAboutProvider extends StatelessWidget {
  const CustomAboutProvider({super.key});

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
                text: 'اسم الخدمه',
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
                text: 'المدينه',
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
                text: 'المنطقه',
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
                text: 'الهاتف',
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
                text: 'خدمة 24 ساعه / 7 ايام',
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
                text: 'اسم مقدم الخدمه',
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

class ProviderHeader extends StatelessWidget {
  const ProviderHeader({super.key});

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
                AppCubit.get(context).changebottomNavIndex(3);
                AppRouter.navigateAndFinish(context, const HomeLayout());
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
