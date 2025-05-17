import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/constants/contsants.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../home_layout/chats/chat_details/adm_chat_details.dart';

class ComplaintsDetails extends StatelessWidget {
  const ComplaintsDetails({super.key});

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
                const CustomAppBar(title: 'تفاصيل الشكوى'),
                Container(
                  width: 343.w,
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(100),
                        blurRadius: 5.r,
                        spreadRadius: 1.r,
                        offset: Offset(0, 5.r),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Container(
                            color: Colors.grey.withAlpha(100),
                            child: Image.asset(
                              Assets.img.client.path,
                              height: 100.w,
                              width: 100.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              makePhoneCall('01000000000');
                            },
                            child: const Icon(Icons.phone, color: Colors.red),
                          ),
                          SizedBox(width: 20.w),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              AppRouter.navigateTo(
                                context,
                                const AdmChatDetails(),
                              );
                            },
                            child: const Icon(Icons.chat, color: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AppText(
                            text: 'اسم العميل',
                            size: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 170.w,
                            child: AppText(
                              textAlign: TextAlign.end,
                              text: 'محمد احمد',
                              size: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withAlpha(100),
                        ),
                      ),
                      Row(
                        children: [
                          AppText(
                            text: 'الهاتف',
                            size: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          const Spacer(),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              makePhoneCall('010000000');
                            },
                            child: SizedBox(
                              width: 170.w,
                              child: AppText(
                                textAlign: TextAlign.end,
                                text: '010000000',
                                size: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withAlpha(100),
                        ),
                      ),
                      Row(
                        children: [
                          AppText(
                            text: 'البريد الالكتروني',
                            size: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 170.w,
                            child: AppText(
                              textAlign: TextAlign.end,
                              text: 'mohamed@info.com',
                              size: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withAlpha(100),
                        ),
                      ),
                      AppText(
                        text: 'الشكوى:',
                        size: 18.sp,
                        bottom: 8.h,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 343.w,
                        child: AppText(
                          text:
                              'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test ',
                          size: 18.sp,
                          lines: 100,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 120.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
