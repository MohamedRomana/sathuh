import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import 'package:sathuh/screens/user_screens/satha_service/satha_service.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';

class CustomServices extends StatelessWidget {
  const CustomServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'خدمات سطحه',
          start: 16.w,
          family: FontFamily.tajawalBold,
          size: 21.sp,
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            AppRouter.navigateTo(context, const SathaService());
          },
          child: Container(
            height: 150.h,
            width: 170.w,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              // color: AppColors.primary,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    Assets.img.trak.path,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 30.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(15.r),
                        bottomStart: Radius.circular(15.r),
                      ),
                    ),
                    child: Center(
                      child: AppText(
                        text: 'خدمة سطحه',
                        family: FontFamily.tajawalBold,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
