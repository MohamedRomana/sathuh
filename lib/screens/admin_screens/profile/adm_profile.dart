import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'profile_edit/profile_edit.dart';

class AdmProfile extends StatelessWidget {
  const AdmProfile({super.key});

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
                CustomAppBar(title: LocaleKeys.profile.tr()),
                SizedBox(
                  height: 300.h,
                  child: Stack(
                    children: [
                      Image.asset(Assets.img.bmw.path),
                      PositionedDirectional(
                        bottom: 40.h,
                        start: 120.w,
                        child: Container(
                          height: 100.w,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 3.w),
                            image: DecorationImage(
                              image: AssetImage(Assets.img.client.path),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 343.w,
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                            text: LocaleKeys.name.tr(),
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                          const Spacer(),
                          AppText(
                            text: "Ahmed",
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
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
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                          const Spacer(),
                          AppText(
                            text: "+201032215458",
                            size: 16.sp,
                            color: Colors.blue,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      const Divider(color: Colors.grey),
                      SizedBox(height: 8.h),

                      Row(
                        children: [
                          AppText(
                            text: LocaleKeys.email.tr(),
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                          const Spacer(),
                          AppText(
                            text: "Ahmed123@gmail.com",
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
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
                            text: LocaleKeys.country.tr(),
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                          const Spacer(),
                          AppText(
                            text: "Egypt",
                            size: 16.sp,
                            color: Colors.grey,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      const Divider(color: Colors.grey),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          AppText(
                            text: 'المحافظه',
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                          const Spacer(),
                          AppText(
                            text: "الدقهليه",
                            size: 16.sp,
                            color: Colors.grey,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      const Divider(color: Colors.grey),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          AppText(
                            text: 'مدينة',
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                          const Spacer(),
                          AppText(
                            text: "المنصورة",
                            size: 16.sp,
                            color: Colors.grey,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppButton(
                  top: 24.h,
                  onPressed: () {
                    AppRouter.navigateTo(context, const AdminEditProfile());
                  },
                  child: AppText(
                    text: LocaleKeys.editprofile.tr(),
                    color: Colors.white,
                    family: FontFamily.tajawalBold,
                    size: 21.sp,
                  ),
                ),
                SizedBox(height: 124.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


