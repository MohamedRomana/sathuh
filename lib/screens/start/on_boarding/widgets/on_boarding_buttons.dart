// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/gen/fonts.gen.dart';
import 'package:sathuh/screens/start/types/types_view.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomOnBoardingButtons extends StatelessWidget {
  const CustomOnBoardingButtons({
    super.key,
    required this.pagesList,
    required this.currPage,
    required this.pageController,
  });

  final List pagesList;
  final double currPage;
  final PageController pageController;
  bool get isLastPage => currPage.round() == pagesList.length - 1;
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 0,
      top: 48.h,
      child: Row(
        children: [
          Visibility(
            visible: currPage <= pagesList.length - 1.5,
            child: Column(
              children: [
                SizedBox(height: 12.h),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(
                      pagesList.length - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: AppText(
                    text: LocaleKeys.skip.tr(),
                    color: Colors.black,
                    size: 18.sp,
                    family: FontFamily.tajawalBold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 170.w),
          InkWell(
            onTap: () {
              if (!isLastPage) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else {
                AppRouter.navigateAndFinish(context, const TypesView());
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              width: 125.w,
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius:  BorderRadiusDirectional.only(
                  topStart: Radius.circular(25.r),
                  bottomStart: Radius.circular(25.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back_ios, color: Colors.white),
                  AppText(
                    text:
                        currPage <= pagesList.length - 1.5
                            ? LocaleKeys.next.tr()
                            : LocaleKeys.start_now.tr(),
                    color: Colors.white,
                    size: 18.sp,
                    fontWeight: FontWeight.bold,
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
