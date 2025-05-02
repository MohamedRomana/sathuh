import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.img.background.path,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withAlpha(210),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const CustomAppBar(title: 'المحادثات'),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsetsDirectional.only(
                    start: 16.w,
                    end: 16.w,
                    top: 20.h,
                    bottom: 160.h,
                  ),
                  itemCount: 10,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder:
                      (context, index) => Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5.r),
                              blurRadius: 5.r,
                              spreadRadius: 1.r,
                              offset: Offset(0, 5.r),
                            ),
                          ],
                        ),
                        child: Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  // AppCubit.get(context).deleteNotification(
                                  //   notificationId: AppCubit.get(context)
                                  //       .notificationsModel[index]
                                  //       .id
                                  //       .toString(),
                                  //   index: index,
                                  // );
                                },
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: LocaleKeys.delete.tr(),
                              ),
                            ],
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              // AppRouter.navigateTo(
                              //   context,
                              //   ChatDetails(
                              //     salerId:
                              //         CacheHelper.getUserType() == "saler"
                              //             ? AppCubit.get(context)
                              //                 .allChatsList[index]['user_id']
                              //                 .toString()
                              //             : AppCubit.get(context)
                              //                 .allChatsList[index]['saler_id']
                              //                 .toString(),
                              //   ),
                              // );
                            },
                            child: Container(
                              width: 343.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50.w,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 5.r,
                                          spreadRadius: 1.r,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        Assets.svg.drawerProfile,
                                        height: 30.w,
                                        width: 30.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 170.w,
                                            child: AppText(
                                              textAlign: TextAlign.start,
                                              text: "محمد احمد",
                                              size: 16.sp,
                                              color: AppColors.secondray,
                                              family: FontFamily.tajawalBold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 70.w,
                                            child: AppText(
                                              textAlign: TextAlign.end,
                                              text: "منذ 4 ساعات",
                                              size: 12.sp,
                                              color: AppColors.secondray,
                                              family: FontFamily.tajawalLight,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 200.w,
                                        child: AppText(
                                          textAlign: TextAlign.start,
                                          top: 5.h,
                                          text: "رساله تجريبية",
                                          size: 12.sp,
                                          color: Colors.grey,
                                          family: FontFamily.tajawalLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
