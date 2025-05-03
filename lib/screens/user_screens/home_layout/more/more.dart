import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sathuh/screens/user_screens/notifications/notifications.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/contsants.dart' show baseUrl;
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/alert_dialog.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../auth/views/login/login.dart';
import '../../drawer/about_us/about_us.dart';
import '../../drawer/contact_us/contact_us.dart';
import '../../drawer/privacy_policy/privacy_policy.dart';
import '../home_layout.dart';
import 'widgets/logout_dialog.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late Animation<double> _animation4;
  late Animation<double> _animation5;
  late Animation<double> _animation6;
  late Animation<double> _animation7;
  late Animation<double> _animation8;
  late Animation<double> _animation9;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    AppCubit.get(context).drawerIndex = -1;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(
        CacheHelper.getLang() == 'en' ? -1.0 : 1.0,
        0,
      ), // يبدأ من خارج الشاشة
      end: Offset.zero, // يدخل للشاشة
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeInOut));

    _animation = Tween<double>(
      begin: -40.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation2 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? -200.0 : 200.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation3 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? -400.0 : 400.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation4 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? -600.0 : 600.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation5 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? -800.0 : 800.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation6 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? -1000.0 : 1000.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation7 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? -1200.0 : 1200.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation8 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? -1600.0 : 1600.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation9 = Tween<double>(
      begin: CacheHelper.getLang() == 'en' ? -1800.0 : 1800.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _controller2.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SlideTransition(
          position: _slideAnimation,
          child: Container(
            width: 300.w,
            margin: EdgeInsets.only(top: 37.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(75.r),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 150.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: AppColors.secondray,
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(75.r),
                    ),
                  ),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: child,
                      );
                    },
                    child: Center(
                      child: Image.asset(
                        height: 126.w,
                        width: 126.w,
                        Assets.img.logo.path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                AnimatedBuilder(
                  animation: _animation2,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation2.value, 0),
                      child: child,
                    );
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).changedrawerIndex(index: 0);
                      if (CacheHelper.getUserType() == "client") {
                        AppCubit.get(context).changebottomNavIndex(1);
                        AppRouter.navigateAndFinish(
                          context,
                          const HomeLayout(),
                        );
                      } else {
                        // AppCubit.get(context).changebottomProviderNavIndex(1);
                        // AppRouter.navigateTo(
                        //   context,
                        //   const ProviderHomeLayout(),
                        // );
                      }
                    },
                    child: Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      margin: EdgeInsetsDirectional.only(
                        top: 35.h,
                        bottom: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).drawerIndex == 0
                                ? AppColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.drawerHome,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).drawerIndex == 0
                                    ? Colors.white
                                    : AppColors.secondray,
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            start: 6.w,
                            text: LocaleKeys.home.tr(),
                            color:
                                AppCubit.get(context).drawerIndex == 0
                                    ? Colors.white
                                    : Colors.black,
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                AnimatedBuilder(
                  animation: _animation3,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation3.value, 0),
                      child: child,
                    );
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).changedrawerIndex(index: 1);
                      if (CacheHelper.getUserType() == "client") {
                        // AppRouter.pop(context);
                        // AppRouter.navigateTo(context, const Profile());
                      } else {
                        // AppRouter.pop(context);
                        // AppRouter.navigateTo(context, const ProviderProfile());
                      }
                    },
                    child: Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      margin: EdgeInsetsDirectional.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).drawerIndex == 1
                                ? AppColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.drawerProfile,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).drawerIndex == 1
                                    ? Colors.white
                                    : AppColors.secondray,
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            start: 6.w,
                            text: LocaleKeys.profile.tr(),
                            color:
                                AppCubit.get(context).drawerIndex == 1
                                    ? Colors.white
                                    : Colors.black,
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                AnimatedBuilder(
                  animation: _animation4,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation4.value, 0),
                      child: child,
                    );
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).changedrawerIndex(index: 2);
                      AppRouter.pop(context);
                      AppRouter.navigateTo(context, const AboutUs());
                    },
                    child: Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      margin: EdgeInsetsDirectional.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).drawerIndex == 2
                                ? AppColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.drawerPeople,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).drawerIndex == 2
                                    ? Colors.white
                                    : AppColors.secondray,
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            start: 6.w,
                            text: LocaleKeys.aboutus.tr(),
                            color:
                                AppCubit.get(context).drawerIndex == 2
                                    ? Colors.white
                                    : Colors.black,
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                AnimatedBuilder(
                  animation: _animation5,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation5.value, 0),
                      child: child,
                    );
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).changedrawerIndex(index: 3);
                      AppRouter.pop(context);
                      AppRouter.navigateTo(context, const ContactUs());
                    },
                    child: Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      margin: EdgeInsetsDirectional.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).drawerIndex == 3
                                ? AppColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.drawerSms,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).drawerIndex == 3
                                    ? Colors.white
                                    : AppColors.secondray,
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            start: 6.w,
                            text: LocaleKeys.contactUs.tr(),
                            color:
                                AppCubit.get(context).drawerIndex == 3
                                    ? Colors.white
                                    : Colors.black,
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                AnimatedBuilder(
                  animation: _animation6,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation6.value, 0),
                      child: child,
                    );
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).changedrawerIndex(index: 4);
                      AppRouter.pop(context);
                      AppRouter.navigateTo(context, const PrivacyPolicy());
                    },
                    child: Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      margin: EdgeInsetsDirectional.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).drawerIndex == 4
                                ? AppColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.drawerPrivacy,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).drawerIndex == 4
                                    ? Colors.white
                                    : AppColors.secondray,
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            start: 6.w,
                            text: LocaleKeys.privacyPolicy.tr(),
                            color:
                                AppCubit.get(context).drawerIndex == 4
                                    ? Colors.white
                                    : Colors.black,
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                AnimatedBuilder(
                  animation: _animation7,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation7.value, 0),
                      child: child,
                    );
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).changedrawerIndex(index: 5);
                      Share.share(baseUrl);
                    },
                    child: Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      margin: EdgeInsetsDirectional.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).drawerIndex == 5
                                ? AppColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.drawerShare,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).drawerIndex == 5
                                    ? Colors.white
                                    : AppColors.secondray,
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            start: 6.w,
                            text: LocaleKeys.share_app.tr(),
                            color:
                                AppCubit.get(context).drawerIndex == 5
                                    ? Colors.white
                                    : Colors.black,
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animation7,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation7.value, 0),
                      child: child,
                    );
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).changedrawerIndex(index: 6);
                      AppRouter.navigateTo(context, const Notifications());
                    },
                    child: Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      margin: EdgeInsetsDirectional.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).drawerIndex == 6
                                ? AppColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.notifications,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).drawerIndex == 6
                                    ? Colors.white
                                    : AppColors.secondray,
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            start: 6.w,
                            text: LocaleKeys.notifications.tr(),
                            color:
                                AppCubit.get(context).drawerIndex == 6
                                    ? Colors.white
                                    : Colors.black,
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animation9,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation9.value, 0),
                      child: child,
                    );
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).changedrawerIndex(index: 7);
                      if (CacheHelper.getUserType() == "client") {
                        CacheHelper.setUserType('saler');
                        AppRouter.navigateTo(context, const LogIn());
                      } else {
                        CacheHelper.setUserType('client');
                        AppRouter.navigateTo(context, const LogIn());
                      }
                    },
                    child: Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      margin: EdgeInsetsDirectional.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).drawerIndex == 7
                                ? AppColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.drawerLogout,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).drawerIndex == 7
                                    ? Colors.white
                                    : AppColors.secondray,
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            start: 6.w,
                            text: 'تسجيل كسائق',
                            color:
                                AppCubit.get(context).drawerIndex == 7
                                    ? Colors.white
                                    : Colors.black,
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                AnimatedBuilder(
                  animation: _animation8,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation8.value, 0),
                      child: child,
                    );
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).changedrawerIndex(index: 8);
                      customAlertDialog(
                        context: context,
                        dialogBackGroundColor: Colors.white,
                        child: const LogoutDialog(),
                      );
                    },
                    child: Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).drawerIndex == 8
                                ? AppColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.drawerLogout,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).drawerIndex == 8
                                    ? Colors.white
                                    : AppColors.secondray,
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            start: 6.w,
                            text: LocaleKeys.logout.tr(),
                            color:
                                AppCubit.get(context).drawerIndex == 8
                                    ? Colors.white
                                    : Colors.black,
                            size: 16.sp,
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
        );
      },
    );
  }
}
