import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/custom_lottie_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_list_shimmer.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../chat_details/chat_details.dart';

class CustomChats extends StatefulWidget {
  const CustomChats({super.key});

  @override
  State<CustomChats> createState() => _CustomChatsState();
}

class _CustomChatsState extends State<CustomChats> {
  Timer? _chatRefreshTimer;

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).chatsList.clear();
    timeago.setLocaleMessages('ar', timeago.ArMessages());

    // استدعاء أول مرة
    AppCubit.get(context).getChats();

    // تحديث تلقائي كل 5 ثواني
    _chatRefreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      AppCubit.get(context).getChats();
    });
  }

  @override
  void dispose() {
    _chatRefreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state is GetChatsLoading &&
                AppCubit.get(context).chatsList.isEmpty
            ? const CustomListShimmer()
            : AppCubit.get(context).chatsList.isEmpty
            ? Center(
              child: CustomLottieWidget(lottieName: Assets.img.emptyorder),
            )
            : ListView.separated(
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 16.w,
                bottom: 120.h,
              ),
              itemCount: AppCubit.get(context).chatsList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final chat = AppCubit.get(context).chatsList[index];
                final messages =
                    chat['mainUser']['\$__']['parent']['messages'] as List;
                final lastMessage =
                    messages.isNotEmpty
                        ? messages.last['message']
                        : 'لا توجد رسائل';
                final lastMessageTime =
                    messages.isNotEmpty
                        ? timeago.format(
                          DateTime.parse(messages.last['createdAt']),
                          locale: 'ar',
                        )
                        : '';
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,

                  onTap: () {
                    AppRouter.navigateTo(
                      context,
                      ChatDetails(
                        id:
                            AppCubit.get(
                              context,
                            ).chatsList[index]['mainUser']['\$__']['parent']['mainUser']['_id'],
                        name:
                            AppCubit.get(
                              context,
                            ).chatsList[index]['mainUser']['\$__']['parent']['mainUser']['userName'],
                        image:
                            AppCubit.get(
                              context,
                            ).chatsList[index]['mainUser']['\$__']['parent']['mainUser']['image'],
                        oldMessages:
                            AppCubit.get(context).chatsList[index]['messages'],
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
                                ).chatsList[index]['mainUser']['\$__']['parent']['mainUser']['image'],
                            width: 45.w,
                            height: 45.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 150.w,
                                  child: AppText(
                                    textAlign: TextAlign.start,
                                    start: 7.w,
                                    text:
                                        AppCubit.get(
                                          context,
                                        ).chatsList[index]['mainUser']['\$__']['parent']['mainUser']['userName'],
                                    size: 16.sp,
                                    color: const Color(0xff8C6263),
                                    family: FontFamily.tajawalBold,
                                  ),
                                ),
                                SizedBox(
                                  width: 100.w,
                                  child: AppText(
                                    textAlign: TextAlign.end,
                                    start: 7.w,
                                    text: lastMessageTime,
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
                                text: lastMessage,
                                size: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
      },
    );
  }
}
