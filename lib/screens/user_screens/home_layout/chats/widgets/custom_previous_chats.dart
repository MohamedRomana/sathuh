import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/custom_lottie_widget.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../chat_details/chat_details.dart';

class CustomChats extends StatelessWidget {
  const CustomChats({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 120.h, ),
      itemCount: 20,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder:
          (context, index) => InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            
            onTap: () {
              AppRouter.navigateTo(context, const ChatDetails(id: '1',));
            },
            child: Container(
              width: 343.w,
              padding: EdgeInsetsDirectional.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.third,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: AppColors.third, width: 1.w),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.third.withAlpha(70),
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 3.r),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000.r),
                    child: Image.asset(
                      Assets.img.driver.path,
                      height: 40.h,
                      width: 40.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 190.w,
                            child: AppText(
                              textAlign: TextAlign.start,
                              start: 7.w,
                              text: 'Ali Hassan Ahmed',
                              size: 16.sp,
                              color: const Color(0xff8C6263),
                              family: FontFamily.tajawalBold,
                            ),
                          ),
                          SizedBox(
                            width: 70.w,
                            child: AppText(
                              textAlign: TextAlign.end,
                              start: 7.w,
                              text: 'منذ 2 ساعة',
                              size: 14.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 250.w,
                        child: AppText(
                          top: 8.h,
                          textAlign: TextAlign.start,
                          start: 7.w,
                          text: 'يريد اسم العميل التواصل معك',
                          size: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
