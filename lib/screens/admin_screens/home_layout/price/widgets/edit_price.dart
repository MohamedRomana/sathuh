import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';

class EditPrice extends StatelessWidget {
  const EditPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            AppText(
              text: 'ضبط التسعير',
              size: 20.sp,
              color: AppColors.primary,
              family: FontFamily.tajawalBold,
            ),
            SizedBox(height: 24.h),
            Container(
              width: 343.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(100),
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 110.w,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(100),
                          blurRadius: 5.r,
                          spreadRadius: 1.r,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).increseCount();
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ),
                        AppText(
                          start: 11.w,
                          end: 11.w,
                          text: AppCubit.get(context).count.toString(),
                          size: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).decreseCount();
                          },
                          child: Icon(
                            Icons.remove,
                            color: Colors.grey,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 130.w,
                    child: AppText(
                      start: 8.w,
                      text: 'سعر المتر في السطحه',
                      color: Colors.black,
                      lines: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    Assets.img.winchCar.path,
                    height: 60.w,
                    width: 60.w,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Container(
              width: 343.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              margin: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w,
                vertical: 24.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(100),
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 110.w,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(100),
                          blurRadius: 5.r,
                          spreadRadius: 1.r,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).increseCount2();
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ),
                        AppText(
                          start: 11.w,
                          end: 11.w,
                          text: AppCubit.get(context).count2.toString(),
                          size: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).decreseCount2();
                          },
                          child: Icon(
                            Icons.remove,
                            color: Colors.grey,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 130.w,
                    child: AppText(
                      start: 8.w,
                      text: 'سعر المتر في سطحة هيدروليك',
                      color: Colors.black,
                      lines: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    Assets.img.winchCar.path,
                    height: 60.w,
                    width: 60.w,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Container(
              width: 343.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(100),
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 110.w,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(100),
                          blurRadius: 5.r,
                          spreadRadius: 1.r,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).increseCount3();
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ),
                        AppText(
                          start: 11.w,
                          end: 11.w,
                          text: "${AppCubit.get(context).count3.toString()}%",
                          size: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).decreseCount3();
                          },
                          child: Icon(
                            Icons.remove,
                            color: Colors.grey,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 130.w,
                    child: AppText(
                      start: 8.w,
                      text: 'نسبة السائق',
                      color: Colors.black,
                      lines: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    Assets.img.driver.path,
                    height: 60.w,
                    width: 60.w,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
