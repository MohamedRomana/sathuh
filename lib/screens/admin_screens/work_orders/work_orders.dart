import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/constants/colors.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import '../../../core/constants/contsants.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../home_layout/chats/chat_details/adm_chat_details.dart';
import '../work_order_details/work_order_details.dart';

class WorkOrders extends StatelessWidget {
  const WorkOrders({super.key});

  @override
  Widget build(BuildContext context) {
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
                const CustomAppBar(title: 'طلبات العمل'),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: 15,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Container(height: 16.h),
                  itemBuilder:
                      (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppRouter.navigateTo(
                            context,
                            const WorkOrderDetails(),
                          );
                        },
                        child: Container(
                          width: 343.w,
                          padding: EdgeInsets.all(16.r),
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withAlpha(50),
                                blurRadius: 5.r,
                                spreadRadius: 1.r,
                                offset: Offset(0, 5.r),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: Container(
                                  color: Colors.grey,
                                  child: Image.asset(
                                    Assets.img.driver.path,
                                    height: 50.w,
                                    width: 50.w,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 180.w,
                                    child: AppText(
                                      text: 'محمد احمد السيد',
                                      size: 16.sp,
                                      start: 10.w,
                                    ),
                                  ),
                                  Container(
                                    width: 180.w,
                                    child: AppText(
                                      text: 'سائق',
                                      size: 14.sp,
                                      start: 10.w,
                                      color: AppColors.secondray,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      makePhoneCall('01000000000');
                                    },
                                    child: const Icon(
                                      Icons.phone,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Container(width: 16.w),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      AppRouter.navigateTo(
                                        context,
                                        const AdmChatDetails(),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.chat,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                ),
                Container(height: 120.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
