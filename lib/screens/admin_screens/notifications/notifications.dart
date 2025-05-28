import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class AdmNotifications extends StatelessWidget {
  const AdmNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminBottomNav(
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
                CustomAppBar(title: LocaleKeys.notifications.tr()),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsetsDirectional.only(
                    top: 16.h,
                    bottom: 140.h,
                    start: 16.w,
                    end: 16.w,
                  ),
                  itemCount: 10,
                  separatorBuilder: (context, index) => Container(height: 16.h),
                  itemBuilder:
                      (context, index) => Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10.r),
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
                          child: Container(
                            width: 343.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffFCFCFC),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary,
                                  blurRadius: 5.r,
                                  spreadRadius: 1.r,
                                  offset: Offset(0, 5.r),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      height: 36.w,
                                      width: 36.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          5.r,
                                        ),
                                        color: const Color(0xff3FAD46),
                                      ),
                                      child: Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Colors.white,
                                        size: 25.sp,
                                      ),
                                    ),
                                    Container(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          bottom: 9.h,
                                          text: 'جديد',
                                          color: const Color(0xff3FAD46),
                                          size: 14.sp,
                                        ),
                                        Container(
                                          height: 35.h,
                                          width: 180.w,
                                          child: AppText(
                                            text:
                                                'رساله تجريبيه رساله تجريبيه رساله تجريبيه رساله تجريبيه رساله تجريبيه رساله تجريبيه رساله تجريبيه',
                                            lines: 2,
                                            size: 12.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 70.w,
                                  child: AppText(
                                    text: 'منذ 10 دقيقه',
                                    color: Colors.black,
                                    size: 12.sp,
                                  ),
                                ),
                              ],
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
