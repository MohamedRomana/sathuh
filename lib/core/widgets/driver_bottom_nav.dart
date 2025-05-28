import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../screens/driver_screens/home_layout/home_layout.dart';
import '../../screens/user_screens/home_layout/more/more.dart';
import '../constants/colors.dart';
import '../service/cubit/app_cubit.dart';
import 'app_router.dart';
import 'app_text.dart';

class DriverBottomNav extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? resizeToAvoidBottomInset;
  const DriverBottomNav({
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
              AppCubit.get(context).changebottomDriverNavIndex(1);
              AppRouter.navigateAndFinish(context, const DriverHomeLayout());
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
            Container(
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
            Container(
              width: 48.w,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppCubit.get(context).changebottomDriverNavIndex(0);
                  AppRouter.navigateAndFinish(
                    context,
                    const DriverHomeLayout(),
                  );
                },
                child: Column(
                  children: [
                    const Icon(Icons.paid, color: Colors.white),
                    AppText(
                      text: LocaleKeys.packages.tr(),
                      size: 12.sp,
                      color: AppColors.third,
                      family: FontFamily.tajawalBold,
                    ),
                  ],
                ),
              ),
            ),
            Container(),
            Container(),
            Container(
              width: 48.w,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppCubit.get(context).changebottomDriverNavIndex(2);
                  AppRouter.navigateAndFinish(
                    context,
                    const DriverHomeLayout(),
                  );
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.orders,

                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                      color: AppColors.third,
                    ),
                    AppText(
                      text: LocaleKeys.orders.tr(),

                      size: 12.sp,
                      color: AppColors.third,
                      family: FontFamily.tajawalBold,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 48.w,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppCubit.get(context).changebottomDriverNavIndex(3);
                  AppRouter.navigateAndFinish(
                    context,
                    const DriverHomeLayout(),
                  );
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
