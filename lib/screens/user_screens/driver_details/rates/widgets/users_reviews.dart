import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';

class UsersReviews extends StatefulWidget {
  const UsersReviews({super.key});

  @override
  State<UsersReviews> createState() => UsersReviewsState();
}

class UsersReviewsState extends State<UsersReviews> {
  int visibleCount = 2;

  @override
  Widget build(BuildContext context) {
    // final ratess = List<Map<String, dynamic>>.from(
    //   AppCubit.get(context).showServiceModel['rates'] ?? [],
    // ).reversed.toList();

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: 343.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 5.r),
                  )
                ]
              ),
              child: ListView.separated(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 16.w,
                  bottom: 20.h,
                ),
                itemCount: visibleCount < 10 ? visibleCount : 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder:
                    (context, index) => const Divider(color: Colors.grey),
                itemBuilder:
                    (context, index) => Column(
                      children: [
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000.r),
                              child: Image.asset(
                                Assets.img.client.path,
                                height: 30.w,
                                width: 30.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            RatingBar.readOnly(
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              initialRating: 2,
                              maxRating: 5,
                              isHalfAllowed: true,
                              halfFilledIcon: Icons.star_half,
                              size: 18.sp,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 300.w,
                          child: AppText(
                            top: 6.h,
                            text: 'test test test test test',
                            lines: 3,
                            size: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (visibleCount < 10)
                  SizedBox(
                    height: 35.h,
                    child: AppButton(
                      onPressed: () {
                        setState(() {
                          visibleCount += 3;
                        });
                      },
                      width: 130.w,
                      radius: 100.r,
                      end: 16.w,
                      elevation: WidgetStateProperty.all(3.r),
                      shadowColor: WidgetStateProperty.all(AppColors.primary),
                      child: AppText(
                        size: 18.sp,
                        text: 'عرض المزيد',
                        color: Colors.white,
                        family: FontFamily.tajawalBold,
                      ),
                    ),
                  ),
                if (visibleCount > 2)
                  IconButton(
                    icon: Container(
                      height: 35.w,
                      width: 35.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.r,
                            spreadRadius: 1.r,
                            color: Colors.grey,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Icon(Icons.arrow_upward, size: 24.sp),
                    ),
                    onPressed: () {
                      Scrollable.ensureVisible(
                        context,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
