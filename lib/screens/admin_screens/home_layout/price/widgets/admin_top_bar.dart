import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../profile/adm_profile.dart';

class AdminTopBar extends StatelessWidget {
  const AdminTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        AppRouter.navigateTo(context, const AdmProfile());
      },
      child: Row(
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
                  text: LocaleKeys.welcome.tr(),
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
    );
  }
}
