import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import 'package:sathuh/generated/locale_keys.g.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/contsants.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../driver_details/driver_details.dart';
import '../../../map/driver_location/driver_location.dart';
import '../../home_layout.dart';

class CustomDriverNearYou extends StatefulWidget {
  final String orderId;
  const CustomDriverNearYou({super.key, required this.orderId});

  @override
  State<CustomDriverNearYou> createState() => _CustomDriverNearYouState();
}

class _CustomDriverNearYouState extends State<CustomDriverNearYou> {
  @override
  void initState() {
    AppCubit.get(context).allNearDrivers(requestId: widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetAllNearDriversSuccess) {
          showFlashMessage(
            message: 'success',
            type: FlashMessageType.success,
            context: context,
          );
        } else if (state is GetAllNearDriversFailure) {
          AppCubit.get(context).changebottomNavIndex(1);
          AppRouter.navigateAndFinish(context, const HomeLayout());
          showFlashMessage(
            message: state.error,
            type: FlashMessageType.error,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return AppCubit.get(context).allNearDriversList.isEmpty
            ? const SizedBox()
            : Container(
              height: 710.h,
              width: double.infinity,
              padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    top: 24.h,
                    text: LocaleKeys.nearest_drivers_to_you.tr(),
                    start: 16.w,
                    family: FontFamily.tajawalBold,
                    size: 21.sp,
                  ),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppCubit.get(context).allNearDriversList.length,
                    separatorBuilder:
                        (context, index) => Container(height: 16.h),
                    itemBuilder:
                        (context, index) => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppRouter.navigateTo(
                              context,
                              const DriverDetails(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        150.r,
                                      ),
                                      child: Container(
                                        color: Colors.grey,
                                        child: AppCachedImage(
                                          image:
                                              AppCubit.get(
                                                context,
                                              ).allNearDriversList[index]['user']['image'],
                                          width: 50.w,
                                          height: 50.w,
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
                                                ).allNearDriversList[index]['user']['userName'],
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
                                                '${LocaleKeys.awayFromYou.tr()} ${AppCubit.get(context).allNearDriversList[index]['distance'] ?? ""} ${LocaleKeys.km.tr()}',
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
                                        makePhoneCall(
                                          AppCubit.get(
                                            context,
                                          ).allNearDriversList[index]['user']['phone'],
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
                                      onTap: () {},
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
                                          const DriverLocation(),
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
                ],
              ),
            );
      },
    );
  }
}
