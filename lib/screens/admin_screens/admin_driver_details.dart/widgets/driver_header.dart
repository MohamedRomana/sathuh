import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/contsants.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../user_screens/map/driver_location/driver_location.dart';
import '../../home_layout/chats/chat_details/adm_chat_details.dart';

class DriverHeader extends StatelessWidget {
  final int index;
  const DriverHeader({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SizedBox(
          height: 350.h,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 300.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondray,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(250.r),
                    bottomStart: Radius.circular(250.r),
                  ),
                  border: Border.all(color: AppColors.primary, width: 7.w),
                ),
              ),
              Container(
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondray,
                  border: Border.symmetric(
                    vertical: BorderSide(color: AppColors.primary, width: 7.w),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 50.h),
                      decoration: BoxDecoration(
                        color: AppColors.third,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child:
                            (AppCubit.get(context)
                                        .driversList[index]['user']['image']
                                        ?.isNotEmpty ??
                                    false)
                                ? AppCachedImage(
                                  image:
                                      AppCubit.get(
                                        context,
                                      ).driversList[index]['user']['image'],
                                  height: 150.w,
                                  width: 150.w,
                                  fit: BoxFit.cover,
                                )
                                : Image.asset(
                                  Assets.img.unphoto.path,
                                  height: 150.w,
                                  width: 150.w,
                                  fit: BoxFit.fill,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                bottom: 100.h,
                // start: 140.w,
                start: 16.w,
                end: 16.w,
                child: SizedBox(
                  width: 150.w,
                  child: AppText(
                    textAlign: TextAlign.center,
                    bottom: 16.h,
                    top: 16.h,
                    text:
                        AppCubit.get(
                          context,
                        ).driversList[index]['user']['userName'] ??
                        "",
                    size: 24.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              // PositionedDirectional(
              //   bottom: 90.h,
              //   start: 140.w,
              //   end: 140.w,
              //   child: RatingBar.readOnly(
              //     filledIcon: Icons.star,
              //     emptyIcon: Icons.star_border,
              //     initialRating: 3.5,
              //     maxRating: 5,
              //     isHalfAllowed: true,
              //     halfFilledIcon: Icons.star_half,
              //     size: 18.sp,
              //   ),
              // ),
              PositionedDirectional(
                bottom: 20.h,
                start: MediaQuery.of(context).size.width / 2 - 30.w,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    makePhoneCall(
                      AppCubit.get(
                            context,
                          ).driversList[index]['user']['phone'] ??
                          "",
                    );
                  },
                  child: Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.r,
                          spreadRadius: 1.r,
                          offset: Offset(0, 2.r),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call, color: Colors.red, size: 24.sp),
                        const AppText(
                          text: 'Call',
                          color: Colors.red,
                          family: FontFamily.tajawalBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: 50.h,
                start: MediaQuery.of(context).size.width / 2 + 60.w,
                child: InkWell(
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
                        name: '',
                        image: '',
                        oldMessages: const [],
                      ),
                    );
                  },
                  child: Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.r,
                          spreadRadius: 1.r,
                          offset: Offset(0, 2.r),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat, color: Colors.green, size: 24.sp),
                        const AppText(
                          text: 'Chat',
                          color: Colors.green,
                          family: FontFamily.tajawalBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: 50.h,
                end: MediaQuery.of(context).size.width / 2 + 60.w,
                child: InkWell(
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
                        message: LocaleKeys.driver_location_unavailable.tr(),
                        type: FlashMessageType.error,
                        context: context,
                      );
                    }
                  },
                  child: Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.r,
                          spreadRadius: 1.r,
                          offset: Offset(0, 2.r),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share_location,
                          color: Colors.blue,
                          size: 24.sp,
                        ),
                        AppText(
                          text: 'Location',
                          size: 12.sp,
                          color: Colors.blue,
                          family: FontFamily.tajawalBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
