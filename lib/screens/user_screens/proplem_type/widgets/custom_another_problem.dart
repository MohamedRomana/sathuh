import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/gen/fonts.gen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomAnotherProblem extends StatelessWidget {
  final TextEditingController problemController;
  const CustomAnotherProblem({super.key, required this.problemController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (AppCubit.get(context).changeIndex == 0) {
          AppCubit.get(context).changeIndexs(index: -1);
        } else {
          AppCubit.get(context).changeIndexs(index: 0);
        }
      },
      child: Column(
        children: [
          AppCubit.get(context).changeIndex == 0
              ? Container(
                margin: EdgeInsets.all(16.r),
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                width: 343.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: const Color(0xffFBFBFB),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      color: Colors.grey,
                      offset: Offset(0, 5.r),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 285.w,
                          child: AppText(
                            text: LocaleKeys.other_problem.tr(),
                            size: 16.sp,
                            lines: 2,
                            color: Colors.black,
                            family: FontFamily.tajawalBold,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.black,
                          size: 24.sp,
                        ),
                      ],
                    ),
                    AppInput(
                      top: 10.h,
                      start: 0,
                      end: 0,
                      filled: true,
                      controller: problemController,
                      hint: LocaleKeys.write_your_problem_here.tr(),
                      enabledBorderColor: Colors.grey,
                    ),
                  ],
                ),
              )
              : Container(
                margin: EdgeInsets.all(16.sp),
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                height: 50.h,
                width: 343.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.secondray,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      color: Colors.grey,
                      offset: Offset(0, 5.r),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 285.w,
                      child: AppText(
                        text: LocaleKeys.other_problem.tr(),
                        lines: 2,
                        size: 16.sp,
                        color: Colors.white,
                        family: FontFamily.tajawalBold,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
