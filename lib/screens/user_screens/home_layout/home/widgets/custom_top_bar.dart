import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomTopBar extends StatelessWidget {
  final String currentAddress;
  const CustomTopBar({super.key, required this.currentAddress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(start: 16.w, end: 5.w),
              height: 50.w,
              width: 50.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 3.w),
                image: DecorationImage(
                  image: AssetImage(Assets.img.client.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150.w,
                  child: AppText(
                    text: LocaleKeys.welcome_dear_customer.tr(),
                    size: 12.sp,
                    color: AppColors.secondray,
                    family: FontFamily.tajawalBold,
                  ),
                ),
                SizedBox(
                  width: 150.w,
                  child: AppText(
                    text: LocaleKeys.thank_you_for_your_preference.tr(),
                    size: 10.sp,
                    color: AppColors.secondray,
                    family: FontFamily.tajawalBold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 100.w,
              child: AppText(
                textAlign: TextAlign.end,
                text: currentAddress,
                size: 10.sp,
                color: AppColors.primary,
                family: FontFamily.tajawalBold,
              ),
            ),
            Icon(Icons.location_on, color: AppColors.primary, size: 25.r),
          ],
        ),
        SizedBox(width: 16.w),
      ],
    );
  }
}
