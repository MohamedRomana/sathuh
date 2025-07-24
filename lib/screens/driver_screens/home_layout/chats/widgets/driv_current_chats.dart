// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/cache/cache_helper.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_list_shimmer.dart';
import '../../../../../core/widgets/custom_lottie_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../chat_details/chat_details.dart';

class DrivCusrrentChats extends StatefulWidget {
  const DrivCusrrentChats({super.key});

  @override
  State<DrivCusrrentChats> createState() => _DrivCusrrentChatsState();
}

class _DrivCusrrentChatsState extends State<DrivCusrrentChats> {
  Timer? _chatRefreshTimer;

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).chatsCurrentList.clear();
    timeago.setLocaleMessages('ar', timeago.ArMessages());

    // استدعاء أول مرة
    AppCubit.get(context).getCurrentChats();

    // تحديث تلقائي كل 5 ثواني
    _chatRefreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      AppCubit.get(context).getCurrentChats();
    });
  }

  @override
  void dispose() {
    // لازم تلغي التايمر لما الصفحة تتقفل علشان ميتسربش
    _chatRefreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> getOtherUserData(
      Map<String, dynamic> chat,
      String currentUserId,
    ) {
      final parentData = chat['mainUser']?['\$__']?['parent'];
      final mainUser = parentData?['mainUser'];
      final subParticipant = parentData?['subParticipant'];

      if (mainUser == null || subParticipant == null) return {};

      final isCurrentUserMain = mainUser['_id'] == currentUserId;

      return {
        'otherUser': isCurrentUserMain ? subParticipant : mainUser,
        'messages': parentData['messages'] ?? [],
      };
    }

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state is GetChatsLoading &&
                AppCubit.get(context).chatsCurrentList.isEmpty
            ? const CustomListShimmer()
            : AppCubit.get(context).chatsCurrentList.isEmpty
            ? Center(
              child: CustomLottieWidget(lottieName: Assets.img.emptyorder),
            )
            : ListView.separated(
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 16.w,
                bottom: 120.h,
              ),
              itemCount: AppCubit.get(context).chatsCurrentList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final currentUserId = CacheHelper.getUserId();

                final chat = AppCubit.get(context).chatsCurrentList[index];
                final chatData = getOtherUserData(chat, currentUserId);
                final otherUser = chatData['otherUser'];
                final messages = chatData['messages'] as List;

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
                  onTap: () {
                    AppRouter.navigateTo(
                      context,
                      DrivChatDetails(
                        id: otherUser['_id'],
                        name: otherUser['userName'],
                        image: otherUser['image'],
                        oldMessages: messages,
                      ),
                    );
                  },
                  child: Container(
                    width: 343.w,
                    padding: EdgeInsetsDirectional.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.third,
                      borderRadius: BorderRadius.circular(15.r),
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
                            image: otherUser['image'],
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
                                    text: otherUser['userName'],
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
