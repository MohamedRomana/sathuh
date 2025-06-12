import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/contsants.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../user_screens/driver_details/rates/product_rates.dart';
import 'widgets/about_driver.dart';
import 'widgets/driver_header.dart';
import 'widgets/driver_orders.dart';

class AdminDriverDetails extends StatelessWidget {
  final int index;
  const AdminDriverDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
                    CustomAppBar(title: LocaleKeys.driver.tr()),
                    DriverHeader(index: index),
                    AboutDriver(index: index),
                    BlocConsumer<AppCubit, AppState>(
                      listener: (context, state) {
                        if (state is DriverBanSuccess) {
                          showFlashMessage(
                            message: state.message,
                            type: FlashMessageType.success,
                            context: context,
                          );
                        } else if (state is DriverBanFailure) {
                          showFlashMessage(
                            message: state.error,
                            type: FlashMessageType.error,
                            context: context,
                          );
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          onPressed: () {
                            AppCubit.get(context).driverBan(
                              driverId:
                                  AppCubit.get(
                                    context,
                                  ).driversList[index]['user']['_id'],
                              type:
                                  AppCubit.get(
                                            context,
                                          ).driversList[index]['isBanned'] ==
                                          false
                                      ? "bann"
                                      : "unBann",
                            );
                          },
                          width: 200.w,
                          shadowColor: WidgetStateProperty.all(Colors.black),
                          elevation: WidgetStateProperty.all(5.r),
                          top: 20.h,
                          color:
                              AppCubit.get(
                                        context,
                                      ).driversList[index]['isBanned'] ==
                                      false
                                  ? Colors.red.shade900
                                  : Colors.green,
                          child:
                              state is DriverBanLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : AppText(
                                    text:
                                        AppCubit.get(
                                                  context,
                                                ).driversList[index]['isBanned'] ==
                                                false
                                            ? LocaleKeys.block_driver.tr()
                                            : LocaleKeys.unblock_driver.tr(),
                                    size: 21.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        );
                      },
                    ),
                    CustomDriverOrders(index2: index),
                    ProductRates(index2: index),

                    AppButton(
                      onPressed: () {
                        openWhatsApp(
                          AppCubit.get(
                                context,
                              ).driversList[index]['user']['phone'] ??
                              "",
                        );
                      },
                      color: AppColors.secondray,
                      top: 24.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.img.social.path,
                            height: 30.w,
                            width: 30.w,
                            fit: BoxFit.cover,
                          ),
                          Container(width: 8.w),
                          AppText(
                            text: LocaleKeys.contact_via_whatsapp.tr(),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ],
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
