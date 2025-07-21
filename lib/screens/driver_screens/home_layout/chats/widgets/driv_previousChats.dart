// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../chat_details/chat_details.dart';

class DrivPreviousChats extends StatefulWidget {
  const DrivPreviousChats({super.key});

  @override
  State<DrivPreviousChats> createState() => _DrivPreviousChatsState();
}

class _DrivPreviousChatsState extends State<DrivPreviousChats> {
  @override
  void initState() {
    AppCubit.get(context).getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            bottom: 120.h,
          ),
          itemCount: AppCubit.get(context).chatsList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder:
              (context, index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,

                onTap: () {
                  AppRouter.navigateTo(
                    context,
                    DrivChatDetails(
                      id:
                          AppCubit.get(
                            context,
                          ).chatsList[index]['subParticipant']['\$__']['parent']['subParticipant']['_id'],
                    ),
                  );
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
                        child: AppCachedImage(
                          image:
                              AppCubit.get(
                                context,
                              ).chatsList[index]['subParticipant']['\$__']['parent']['subParticipant']['image'],
                          width: 50.w,
                          height: 50.h,
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
                                  text:
                                      AppCubit.get(
                                        context,
                                      ).chatsList[index]['subParticipant']['\$__']['parent']['subParticipant']['userName'],
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
      },
    );
  }
}
