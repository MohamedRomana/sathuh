import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import '../../../../core/constants/contsants.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../complaints_details/complaints_details.dart';
import '../chats/chat_details/adm_chat_details.dart';

class Complaints extends StatelessWidget {
  const Complaints({super.key});

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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomAppBar(
                  title: LocaleKeys.complaints.tr(),
                  isHomeLayout: true,
                ),
                ListView.separated(
                  padding: EdgeInsets.only(bottom: 120.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 15,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder:
                      (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppRouter.navigateTo(
                            context,
                            const ComplaintsDetails(),
                          );
                        },
                        child: Container(
                          width: 343.w,
                          padding: EdgeInsetsDirectional.all(16.r),
                          margin: EdgeInsetsDirectional.only(
                            start: 16.w,
                            end: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.r,
                                spreadRadius: 1.r,
                                offset: Offset(0, 5.r),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 50.w,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150.r),
                                  color: Colors.black.withAlpha(50),
                                  image: DecorationImage(
                                    image: AssetImage(Assets.img.client.path),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    start: 16.w,
                                    text: 'محمد احمد',
                                    size: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    top: 16.h,
                                    bottom: 8.h,
                                  ),
                                  AppText(
                                    start: 16.w,
                                    text: "12/12/2023",
                                    size: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  AppText(
                                    start: 16.w,
                                    text: 'عميل',
                                    size: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              const Spacer(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
