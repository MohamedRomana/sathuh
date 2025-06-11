import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/contsants.dart';
import '../../../../core/widgets/app_cached.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../user_screens/map/driver_location/driver_location.dart';
import '../../admin_driver_details.dart/admin_driver_details.dart';
import '../chats/chat_details/adm_chat_details.dart';

class Drivers extends StatefulWidget {
  const Drivers({super.key});

  @override
  State<Drivers> createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  @override
  initState() {
    AppCubit.get(context).getDrivers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
                    CustomAppBar(
                      title: LocaleKeys.drivers.tr(),
                      isHomeLayout: true,
                    ),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AppCubit.get(context).driversList.length,
                      separatorBuilder:
                          (context, index) => Container(height: 16.h),
                      itemBuilder:
                          (context, index) => InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              AppRouter.navigateTo(
                                context,
                                const AdminDriverDetails(),
                              );
                            },
                            child: Container(
                              width: 343.w,
                              padding: EdgeInsets.all(16.r),
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          100.r,
                                        ),
                                        child:
                                            (AppCubit.get(context)
                                                        .driversList[index]['image']
                                                        ?.isNotEmpty ??
                                                    false)
                                                ? AppCachedImage(
                                                  width: 60.w,
                                                  height: 60.w,
                                                  image:
                                                      AppCubit.get(
                                                        context,
                                                      ).driversList[index]['image'],
                                                  fit: BoxFit.cover,
                                                )
                                                : Image.asset(
                                                   width: 60.w,
                                                  height: 60.w,
                                                  Assets.img.unphoto.path,
                                                  fit: BoxFit.cover,
                                                ),
                                      ),
                                      Container(width: 8.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 150.w,
                                            child: AppText(
                                              text: 'محمد احمد',
                                              family: FontFamily.tajawalMedium,
                                              color: AppColors.secondray,
                                              size: 14.sp,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.lightGreen,
                                                size: 8.sp,
                                              ),
                                              SizedBox(
                                                width: 100.w,
                                                child: AppText(
                                                  start: 3.w,
                                                  text: LocaleKeys.online.tr(),
                                                  family:
                                                      FontFamily.tajawalMedium,
                                                  color: Colors.lightGreen,
                                                  size: 14.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 150.w,
                                            child: AppText(
                                              text:
                                                  '${LocaleKeys.awayFromYou.tr()} 14 ${LocaleKeys.km.tr()}',
                                              family: FontFamily.tajawalMedium,
                                              color: AppColors.secondray,
                                              size: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          makePhoneCall('01000000000');
                                        },
                                        child: const Icon(
                                          Icons.phone,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Container(width: 8.w),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          AppRouter.navigateTo(
                                            context,
                                            const AdmChatDetails(),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.chat,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Container(width: 8.w),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          AppRouter.navigateTo(
                                            context,
                                            const DriverLocation(isAdmin: true),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.share_location,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ),
                    Container(height: 120.h),
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
