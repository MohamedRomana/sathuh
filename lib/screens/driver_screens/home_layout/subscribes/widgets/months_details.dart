import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../user_screens/bank_transfer/bank_transfer.dart';

class MonthsDetails extends StatelessWidget {
  final bool sub;
  const MonthsDetails({super.key, this.sub = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16.r),

      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(height: 20.h),
            Row(
              children: [
                Container(width: 16.w),
                Icon(Icons.error, color: Colors.black, size: 30.sp),
                AppText(
                  start: 5.w,
                  text: LocaleKeys.package_info.tr(),
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 30.sp, color: Colors.black),
                ),
                Container(width: 16.w),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.r),
              itemCount: 20,
              separatorBuilder: (context, index) => Container(height: 16.h),
              itemBuilder:
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.circle, color: Colors.black, size: 20.sp),
                      Container(
                        width: 250.w,
                        child: AppText(
                          start: 5.w,
                          lines: 3,
                          size: 14.sp,
                          text:
                              'test test test test test test test test test test test test test test test test test test test test test test test test ',
                        ),
                      ),
                    ],
                  ),
            ),
            if (sub)
              AppButton(
                start: 20.w,
                end: 20.w,
                bottom: 24.h,
                onPressed: () {
                  AppRouter.navigateAndPop(context, const BankTransferPage());
                },
                child: AppText(
                  text: LocaleKeys.subscription.tr(),
                  color: Colors.white,
                  family: FontFamily.tajawalBold,
                  size: 21.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
