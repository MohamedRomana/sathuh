import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/custom_shimmer.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/contsants.dart';
import '../../../../core/widgets/app_cached.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_list_shimmer.dart';
import '../../../../core/widgets/custom_lottie_no_data.dart';
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

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<double> calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    double distanceInMeters = Geolocator.distanceBetween(
      startLat,
      startLng,
      endLat,
      endLng,
    );
    return distanceInMeters / 1000;
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
                    state is GetDriversLoading
                        ? const CustomListShimmer()
                        : AppCubit.get(context).driversList.isEmpty
                        ? CustomLottieNoData(
                          lottieTitle: LocaleKeys.no_drivers.tr(),
                        )
                        : ListView.separated(
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
                                    AdminDriverDetails(index: index),
                                  );
                                },
                                child: Container(
                                  width: 343.w,
                                  padding: EdgeInsets.all(16.r),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withAlpha(70),
                                        spreadRadius: 1.r,
                                        blurRadius: 5.r,
                                        offset: Offset(0, 5.r),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 60.w,
                                            width: 60.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.secondray
                                                      .withAlpha(70),
                                                  spreadRadius: 1.r,
                                                  blurRadius: 5.r,
                                                  offset: const Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),

                                              child:
                                                  (AppCubit.get(context)
                                                              .driversList[index]['user']['image']
                                                              ?.isNotEmpty ??
                                                          false)
                                                      ? AppCachedImage(
                                                        width: 60.w,
                                                        height: 60.w,
                                                        image:
                                                            AppCubit.get(
                                                              context,
                                                            ).driversList[index]['user']['image'],
                                                        fit: BoxFit.cover,
                                                      )
                                                      : Image.asset(
                                                        width: 60.w,
                                                        height: 60.w,
                                                        Assets.img.unphoto.path,
                                                        fit: BoxFit.cover,
                                                      ),
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
                                                  text:
                                                      AppCubit.get(
                                                        context,
                                                      ).driversList[index]['user']['userName'] ??
                                                      "",
                                                  family:
                                                      FontFamily.tajawalMedium,
                                                  color: AppColors.secondray,
                                                  size: 14.sp,
                                                ),
                                              ),
                                              AppCubit.get(
                                                        context,
                                                      ).driversList[index]['isAvailable'] ==
                                                      false
                                                  ? Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        color: Colors.red,
                                                        size: 8.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 100.w,
                                                        child: AppText(
                                                          start: 3.w,
                                                          text:
                                                              LocaleKeys.offline
                                                                  .tr(),
                                                          family:
                                                              FontFamily
                                                                  .tajawalMedium,
                                                          color: Colors.red,
                                                          size: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                  : Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        color:
                                                            Colors.lightGreen,
                                                        size: 8.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 100.w,
                                                        child: AppText(
                                                          start: 3.w,
                                                          text:
                                                              LocaleKeys.online
                                                                  .tr(),
                                                          family:
                                                              FontFamily
                                                                  .tajawalMedium,
                                                          color:
                                                              Colors.lightGreen,
                                                          size: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              FutureBuilder(
                                                future: getCurrentLocation().then((
                                                  position,
                                                ) {
                                                  return calculateDistance(
                                                    position.latitude,
                                                    position.longitude,
                                                    AppCubit.get(
                                                      context,
                                                    ).driversList[index]['location']['coordinates'][1],
                                                    AppCubit.get(
                                                      context,
                                                    ).driversList[index]['location']['coordinates'][0],
                                                  );
                                                }),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return SizedBox(
                                                      height: 20.h,
                                                      width: 40.w,
                                                      child:
                                                          const CustomShimmer(),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return AppText(
                                                      text: "",
                                                      family:
                                                          FontFamily
                                                              .tajawalMedium,
                                                      color: Colors.red,
                                                      size: 14.sp,
                                                    );
                                                  } else {
                                                    final distance =
                                                        snapshot.data!;
                                                    return SizedBox(
                                                      width: 150.w,
                                                      child: AppText(
                                                        text:
                                                            '${LocaleKeys.awayFromYou.tr()} ${distance.toStringAsFixed(2)} ${LocaleKeys.km.tr()}',
                                                        family:
                                                            FontFamily
                                                                .tajawalMedium,
                                                        color:
                                                            AppColors.secondray,
                                                        size: 14.sp,
                                                      ),
                                                    );
                                                  }
                                                },
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
                                              makePhoneCall(
                                                AppCubit.get(
                                                  context,
                                                ).driversList[index]['user']['phone'],
                                              );
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
                                                AdmChatDetails(
                                                  id:
                                                      AppCubit.get(
                                                        context,
                                                      ).driversList[index]['user']['_id'],
                                                ),
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
                                              if (AppCubit.get(
                                                    context,
                                                  ).driversList[index]['location']['coordinates'] !=
                                                  null) {
                                                AppRouter.navigateTo(
                                                  context,
                                                  DriverLocation(
                                                    isAdmin: true,
                                                    lat:
                                                        AppCubit.get(
                                                          context,
                                                        ).driversList[index]['location']['coordinates'][1],
                                                    lng:
                                                        AppCubit.get(
                                                          context,
                                                        ).driversList[index]['location']['coordinates'][0],
                                                  ),
                                                );
                                              } else {
                                                showFlashMessage(
                                                  message:
                                                      LocaleKeys
                                                          .driver_location_unavailable
                                                          .tr(),
                                                  type: FlashMessageType.error,
                                                  context: context,
                                                );
                                              }
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
