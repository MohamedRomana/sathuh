import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sathuh/screens/admin_screens/home_layout/admin_home_layout.dart';

import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../screens/user_screens/home_layout/more/more.dart';
import '../cache/cache_helper.dart';
import '../constants/colors.dart';
import '../service/cubit/app_cubit.dart';
import 'app_router.dart';
import 'app_text.dart';

class AdminBottomNav extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? resizeToAvoidBottomInset;
  const AdminBottomNav({
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
      body: body,
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
              AppCubit.get(context).changebottomAdminNavIndex(1);
              AppRouter.navigateAndFinish(context, const AdminHomeLayout());
            },
            child: Container(
              height: 65.w,
              width: 65.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondray,
              ),
              child: Center(
                child: Icon(Icons.paid, color: Colors.white, size: 40.w),
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
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
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
            SizedBox(
              width: 48.w,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppCubit.get(context).changebottomAdminNavIndex(0);
                  AppRouter.navigateAndFinish(context, const AdminHomeLayout());
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.directions_car_rounded,
                      color:
                          AppCubit.get(context).bottomAdminNavIndex == 0
                              ? AppColors.third
                              : AppColors.third,
                    ),
                    AppText(
                      text: 'السائقين',
                      size: 10.sp,
                      color: AppColors.third,
                      family: FontFamily.tajawalBold,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(),
            const SizedBox(),
            SizedBox(
              width: 48.w,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppCubit.get(context).changebottomAdminNavIndex(2);
                  AppRouter.navigateAndFinish(context, const AdminHomeLayout());
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.list_alt_rounded,
                      color:
                          AppCubit.get(context).bottomAdminNavIndex == 2
                              ? AppColors.third
                              : AppColors.third,
                    ),
                    AppText(
                      text: 'الشكاوي',
                      size: CacheHelper.getLang() == 'en' ? 11.sp : 11.sp,
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
                  AppCubit.get(context).changebottomAdminNavIndex(3);
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
    );
  }
}
