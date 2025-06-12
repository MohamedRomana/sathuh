import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sathuh/core/constants/colors.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../user_screens/home_layout/more/more.dart';

class AdminHomeLayout extends StatefulWidget {
  const AdminHomeLayout({super.key});

  @override
  State<AdminHomeLayout> createState() => _AdminHomeLayoutState();
}

class _AdminHomeLayoutState extends State<AdminHomeLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation2 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? -200.0 : 200.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation3 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? 200.0 : -200.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation = Tween<double>(
      begin: -40.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 90), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            bool? shouldPop = await showDialog<bool>(
              context: context,
              
              builder:
                  (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text(LocaleKeys.doYouWantToLeaveThisApp.tr()),
                    content: Text(LocaleKeys.areYouSure.tr()),
                    actions: [
                      TextButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: Text(LocaleKeys.yes.tr(),style: TextStyle(color: Colors.green, fontSize: 16.sp),),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(LocaleKeys.no.tr(), style: TextStyle(color: Colors.red, fontSize: 16.sp),),
                      ),
                    ],
                  ),
            );
            return shouldPop ?? false;
          },
          child: Scaffold(
            drawer: const CustomDrawer(),
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            extendBody: true,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changebottomAdminNavIndex(1);
              },
              child: Container(
                height: 65.w,
                width: 65.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondray,
                ),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: child,
                      );
                    },
                    child: Icon(Icons.paid, color: Colors.white, size: 40.w),
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
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      child: AnimatedBuilder(
                        animation: _animation2,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(_animation2.value, 0),
                            child: child,
                          );
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
                        AppCubit.get(context).changebottomAdminNavIndex(0);
                      },
                      child: AnimatedBuilder(
                        animation: _animation2,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(_animation2.value, 0),
                            child: child,
                          );
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.directions_car_rounded,
                              color:
                                  AppCubit.get(context).bottomAdminNavIndex == 0
                                      ? AppColors.secondray
                                      : AppColors.third,
                            ),
                            AppText(
                              text: LocaleKeys.drivers.tr(),
                              size: 10.sp,
                              color:
                                  AppCubit.get(context).bottomAdminNavIndex == 0
                                      ? AppColors.secondray
                                      : AppColors.third,
                              family: FontFamily.tajawalBold,
                            ),
                          ],
                        ),
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
                        AppCubit.get(context).changebottomAdminNavIndex(2);
                      },
                      child: AnimatedBuilder(
                        animation: _animation3,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(_animation3.value, 0),
                            child: child,
                          );
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.list_alt_rounded,
                              color:
                                  AppCubit.get(context).bottomAdminNavIndex == 2
                                      ? AppColors.secondray
                                      : AppColors.third,
                            ),
                            AppText(
                              text: LocaleKeys.complaints.tr(),
                              size:
                                  CacheHelper.getLang() == 'en' ? 11.sp : 11.sp,
                              color:
                                  AppCubit.get(context).bottomAdminNavIndex == 2
                                      ? AppColors.secondray
                                      : AppColors.third,
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
                        AppCubit.get(context).changebottomAdminNavIndex(3);
                      },
                      child: AnimatedBuilder(
                        animation: _animation3,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(_animation3.value, 0),
                            child: child,
                          );
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Assets.svg.chats,
                              height: 24.w,
                              width: 24.w,
                              fit: BoxFit.cover,
                              color:
                                  AppCubit.get(context).bottomAdminNavIndex == 3
                                      ? AppColors.secondray
                                      : AppColors.third,
                            ),
                            AppText(
                              text: LocaleKeys.chats.tr(),
                              size: 12.sp,
                              color:
                                  AppCubit.get(context).bottomAdminNavIndex == 3
                                      ? AppColors.secondray
                                      : AppColors.third,
                              family: FontFamily.tajawalBold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body:
                AppCubit.get(context).bottomAdminNavScreens[AppCubit.get(
                  context,
                ).bottomAdminNavIndex],
          ),
        );
      },
    );
  }
}
