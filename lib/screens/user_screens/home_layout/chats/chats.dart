import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../driver_screens/home_layout/chats/widgets/driv_current_chats.dart';
import 'widgets/custom_previous_chats.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(title: LocaleKeys.chats.tr(), isHomeLayout: true),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              indicatorColor: AppColors.primary,
              overlayColor: WidgetStateProperty.all(AppColors.primary),
              splashBorderRadius: BorderRadius.circular(15.r),
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.secondray,
              labelStyle: TextStyle(fontSize: 16.sp),
              tabs: [
                Tab(
                  child: Text(
                    LocaleKeys.current_chats.tr(),
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                Tab(
                  child: Text(
                    LocaleKeys.previous_chats.tr(),
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(children: [CustomChats(), DrivCusrrentChats()]),
            ),
          ],
        ),
      ),
    );
  }
}
