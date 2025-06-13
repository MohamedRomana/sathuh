// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomChatWithContainer extends StatelessWidget {
  final Map<String, dynamic> user;
  const CustomChatWithContainer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        // AppRouter.navigateTo(context, const DriverDetails());
      },
      child: Container(
        width: 343.w,
        padding: EdgeInsets.all(16.r),
        margin: EdgeInsetsDirectional.only(
          top: 16.h,
          start: 16.w,
          end: 16.w,
          bottom: 21.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
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
        child: Row(
          children: [
            Container(
              height: 50.w,
              width: 50.w,
              decoration: BoxDecoration(
                color: AppColors.secondray,
                border: Border.all(color: AppColors.secondray, width: 2.w),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child:
                    (user['image'].isNotEmpty ?? false)
                        ? AppCachedImage(
                          image: user['image'],
                          height: 50.w,
                          width: 50.w,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          Assets.img.unphoto.path,
                          height: 50.w,
                          width: 50.w,
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            Container(width: 6.w),
            AppText(
              text: "${LocaleKeys.chat_with.tr()} ${user['userName']}",
              size: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
