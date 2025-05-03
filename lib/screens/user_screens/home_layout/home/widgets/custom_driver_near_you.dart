import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/contsants.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../driver_details/driver_details.dart';

class CustomDriverNearYou extends StatelessWidget {
  const CustomDriverNearYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          top: 24.h,
          text: 'السائقين الاقرب اليك',
          start: 16.w,
          family: FontFamily.tajawalBold,
          size: 21.sp,
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 15,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder:
              (context, index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppRouter.navigateTo(context, const DriverDetails());
                },
                child: Container(
                  width: 343.w,
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(150.r),
                            child: Container(
                              color: Colors.grey,
                              child: Image.asset(
                                Assets.img.driver.path,
                                height: 50.w,
                                width: 50.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150.w,
                                child: AppText(
                                  text: 'محمد احمد',
                                  family: FontFamily.tajawalMedium,
                                  color: AppColors.secondray,
                                  size: 14.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.lightGreen,
                                    size: 8.sp,
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: AppText(
                                      start: 3.w,
                                      text: 'متصل',
                                      family: FontFamily.tajawalMedium,
                                      color: Colors.lightGreen,
                                      size: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 150.w,
                                child: AppText(
                                  text: 'على بعد 14 كم',
                                  family: FontFamily.tajawalMedium,
                                  color: AppColors.secondray,
                                  size: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              makePhoneCall('01000000000');
                            },
                            child: const Icon(Icons.phone, color: Colors.red),
                          ),
                          SizedBox(width: 8.w),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              AppCubit.get(context).changebottomNavIndex(3);
                            },
                            child: const Icon(Icons.chat, color: Colors.green),
                          ),
                          SizedBox(width: 8.w),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {},
                            child: const Icon(
                              Icons.share_location,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ],
    );
  }
}
