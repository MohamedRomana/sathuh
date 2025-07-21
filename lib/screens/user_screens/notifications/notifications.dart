// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/cache/cache_helper.dart';
import 'package:sathuh/core/widgets/custom_shimmer.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../core/widgets/custom_lottie_widget.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    AppCubit.get(context).getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
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
                    state is GetNotificationsLoading &&
                            AppCubit.get(context).notificationsList.isEmpty
                        ? const CustomShimmer()
                        : AppCubit.get(context).notificationsList.isEmpty
                        ? Center(
                          child: CustomLottieWidget(
                            lottieName: Assets.img.emptyorder,
                          ),
                        )
                        : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsetsDirectional.only(
                            top: 16.h,
                            bottom: 140.h,
                            start: 16.w,
                            end: 16.w,
                          ),
                          itemCount:
                              AppCubit.get(context).notificationsList.length,
                          separatorBuilder:
                              (context, index) => Container(height: 16.h),
                          itemBuilder:
                              (context, index) => Container(
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
                                      color: AppColors.primary.withAlpha(50),
                                      blurRadius: 5.r,
                                      spreadRadius: 1.r,
                                      offset: Offset(0, 5.r),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              text:
                                                  AppCubit.get(
                                                    context,
                                                  ).notificationsList[index]['type'],
                                              color: const Color(0xff3FAD46),
                                              size: 14.sp,
                                            ),
                                            SizedBox(
                                              height: 35.h,
                                              width: 180.w,
                                              child: AppText(
                                                text:
                                                    CacheHelper.getLang() ==
                                                            'en'
                                                        ? AppCubit.get(
                                                          context,
                                                        ).notificationsList[index]['message_en']
                                                        : AppCubit.get(
                                                              context,
                                                            ).notificationsList[index]['message_ar'] ??
                                                            'No title',
                                                lines: 2,
                                                size: 12.sp,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      child: AppText(
                                        text: _formatDate(
                                          AppCubit.get(
                                                context,
                                              ).notificationsList[index]['createdAt'] ??
                                              "",
                                        ),
                                        color: Colors.black,
                                        size: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

String _formatDate(String? isoDate) {
  if (isoDate == null) return '';
  final date = DateTime.parse(isoDate);
  return DateFormat('dd/MM/yyyy').format(date);
}
