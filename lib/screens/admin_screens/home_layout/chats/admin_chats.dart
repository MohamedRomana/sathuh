import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/adm_current_chats.dart';
import 'widgets/adm_previous_chats.dart';

class AdminChats extends StatelessWidget {
  const AdminChats({super.key});

  @override
  Widget build(BuildContext context) {
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
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                CustomAppBar(title: LocaleKeys.chats.tr()),
                Container(
                  width: 343.w,
                  margin: EdgeInsetsDirectional.only(
                    top: 16.h,
                    start: 16.w,
                    end: 16.w,
                    bottom: 16.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.secondray,
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: AppColors.primary,
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: [
                      Tab(text: LocaleKeys.previous_chats.tr()),
                      Tab(text: LocaleKeys.current_chats.tr()),
                    ],
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [AdmPreviousChats(), AdmCurrentChats()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


