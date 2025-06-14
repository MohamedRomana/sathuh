import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../screens/user_screens/home_layout/home_layout.dart';
import '../../screens/user_screens/home_layout/more/more.dart';
import '../cache/cache_helper.dart';
import '../constants/colors.dart';
import '../service/cubit/app_cubit.dart';
import 'app_router.dart';
import 'app_text.dart';

class CustomBottomNav extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? resizeToAvoidBottomInset;
  const CustomBottomNav({
    super.key,
    required this.body,
    this.backgroundColor,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
      drawer: const CustomDrawer(),
      extendBody: true,
      backgroundColor: backgroundColor,
      appBar: appBar,
      floatingActionButtonLocation:
          floatingActionButtonLocation ??
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          floatingActionButton ??
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (CacheHelper.getUserType() == "user") {
                AppCubit.get(context).changebottomNavIndex(1);
                AppRouter.navigateAndFinish(context, const HomeLayout());
              } else {
                // AppCubit.get(context).changebottomProviderNavIndex(1);
                // AppRouter.navigateAndFinish(context, const ProviderHomeLayout());
              }
            },
            child: Container(
              height: 65.w,
              width: 65.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondray,
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.svg.home,
                  height: 25.w,
                  width: 25.w,
                  color: Colors.white,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        notchMargin: 13.r,
        clipBehavior: Clip.antiAlias,
        color: AppColors.primary,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 48.w,
              child: Builder(
                builder:
                    (context) => InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.more,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                            color: AppColors.third,
                          ),
                          AppText(
                            text: LocaleKeys.more.tr(),
                            size: 12.sp,
                            color: AppColors.third,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ),
              ),
            ),
            SizedBox(
              width: 48.w,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (CacheHelper.getUserType() == "user") {
                    AppCubit.get(context).changebottomNavIndex(0);
                    AppRouter.navigateAndFinish(context, const HomeLayout());
                  } else {
                    // AppCubit.get(context).changebottomProviderNavIndex(0);
                    // AppRouter.navigateAndFinish(
                    //   context,
                    //   const ProviderHomeLayout(),
                    // );
                  }
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      CacheHelper.getUserType() == "user"
                          ? Assets.svg.car2
                          : Assets.svg.orders,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                      color: AppColors.third,
                    ),
                    AppText(
                      text:
                          CacheHelper.getUserType() == "user"
                              ? LocaleKeys.my_cars.tr()
                              : LocaleKeys.orders.tr(),
                      size:
                          CacheHelper.getUserType() == "provider" &&
                                  CacheHelper.getLang() == 'en'
                              ? 11.sp
                              : 12.sp,
                      color: AppColors.third,
                      family: FontFamily.tajawalBold,
                    ),
                  ],
                ),
              ),
            ),
            Container(),
            Container(),
            SizedBox(
              width: 48.w,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (CacheHelper.getUserType() == "user") {
                    AppCubit.get(context).changebottomNavIndex(2);
                    AppRouter.navigateAndFinish(context, const HomeLayout());
                  } else {
                    // AppCubit.get(context).changebottomProviderNavIndex(2);
                    // AppRouter.navigateAndFinish(
                    //   context,
                    //   const ProviderHomeLayout(),
                    // );
                  }
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      CacheHelper.getUserType() == "user"
                          ? Assets.svg.orders
                          : Assets.svg.notifications,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                      color: AppColors.third,
                    ),
                    AppText(
                      text:
                          CacheHelper.getUserType() == "user"
                              ? LocaleKeys.orders.tr()
                              : LocaleKeys.notifications.tr(),
                      size:
                          CacheHelper.getLang() == 'en' &&
                                  CacheHelper.getUserType() == "user"
                              ? 11.sp
                              : 12.sp,
                      color: AppColors.third,
                      family: FontFamily.tajawalBold,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 48.w,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (CacheHelper.getUserType() == "user") {
                    AppCubit.get(context).changebottomNavIndex(3);
                    AppRouter.navigateAndFinish(context, const HomeLayout());
                  } else {
                    // AppCubit.get(context).changebottomProviderNavIndex(3);
                    // AppRouter.navigateAndFinish(
                    //   context,
                    //   const ProviderHomeLayout(),
                    // );
                  }
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.chats,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                      color: AppColors.third,
                    ),
                    AppText(
                      text: LocaleKeys.chats.tr(),
                      size: 12.sp,
                      color: AppColors.third,
                      family: FontFamily.tajawalBold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
