import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_lottie_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../user_screens/chat_details/chat_details.dart';

class AdmPreviousChats extends StatelessWidget {
  const AdmPreviousChats({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppCubit.get(context).getChatRooms();
    });

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return AppCubit.get(context).chatRooms.isEmpty
            ? Column(
              children: [
                SizedBox(height: 120.h),
                CustomLottieWidget(lottieName: Assets.img.emptyorder),
              ],
            )
            : Container(
              height: 570.h,
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.all(16.r),
              margin: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 16.w,
                bottom: 130.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF3F3F3),
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: BlocConsumer<AppCubit, AppState>(
                // استخدم BlocConsumer للاستماع للتغييرات
                listener: (context, state) {
                  if (state is GetChatRoomsError) {
                    // أظهر رسالة خطأ للمستخدم
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is GetChatRoomsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetChatRoomsSuccess) {
                    final chatRooms = state.chatRooms;
                    if (chatRooms.isEmpty) {
                      return Center(
                        child: AppText(
                          text: 'لا توجد محادثات سابقة.',
                          size: 16.sp,
                        ),
                      );
                    }
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: chatRooms.length,
                      separatorBuilder:
                          (context, index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                      itemBuilder: (context, index) {
                        final chatRoom = chatRooms[index];
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppRouter.navigateTo(
                              context,
                              ChatDetails(
                                destId: chatRoom.otherUserId,
                                otherUserName: chatRoom.otherUserName,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 45.w,
                                width: 45.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: SvgPicture.asset(
                                  Assets.svg.drawerProfile,
                                  height: 45.w,
                                  width: 45.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(width: 6.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 170.w,
                                        child: AppText(
                                          text:
                                              chatRoom
                                                  .otherUserName, // اسم المستخدم الآخر
                                          size: 16.sp,
                                          color: AppColors.primary,
                                          family: Assets.fonts.tajawalBold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70.w,
                                        child: AppText(
                                          textAlign: TextAlign.end,
                                          text:
                                              chatRoom
                                                  .lastMessageTime, // وقت آخر رسالة
                                          size: 12.sp,
                                          family: Assets.fonts.tajawalBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                    child: AppText(
                                      text: chatRoom.lastMessage, // آخر رسالة
                                      size: 12.sp,
                                      color: Colors.grey,
                                      family: Assets.fonts.tajawalBold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink(); // في حالة AppInitial أو أي حالة أخرى
                },
              ),
            );
      },
    );
  }
}
