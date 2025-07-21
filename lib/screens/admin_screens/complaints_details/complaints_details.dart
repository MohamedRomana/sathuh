import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/constants/contsants.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../home_layout/chats/chat_details/adm_chat_details.dart';

class ComplaintsDetails extends StatelessWidget {
  final int index;
  const ComplaintsDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
                    CustomAppBar(title: LocaleKeys.complaint_details.tr()),
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
                            child: Container(
                              height: 100.w,
                              width: 100.w,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 3.w,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: Container(
                                  color: Colors.grey.withAlpha(100),
                                  child:
                                      (AppCubit.get(context)
                                                  .complaintsList[index]['userId']['image']
                                                  ?.isNotEmpty ??
                                              false)
                                          ? AppCachedImage(
                                            image:
                                                AppCubit.get(
                                                  context,
                                                ).complaintsList[index]['userId']['image'],
                                            height: 100.w,
                                            width: 100.w,
                                            fit: BoxFit.fill,
                                          )
                                          : Image.asset(
                                            Assets.img.unphoto.path,
                                            height: 100.w,
                                            width: 100.w,
                                            fit: BoxFit.fill,
                                          ),
                                ),
                              ),
                            ),
                          ),
                          Container(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  makePhoneCall(
                                    AppCubit.get(
                                          context,
                                        ).complaintsList[index]['userId']['phone'] ??
                                        "",
                                  );
                                },
                                child: const Icon(
                                  Icons.phone,
                                  color: Colors.red,
                                ),
                              ),
                              Container(width: 20.w),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  AppRouter.navigateTo(
                                    context,
                                    AdmChatDetails(
                                      id:
                                          AppCubit.get(
                                            context,
                                          ).complaintsList[index]['userId']['_id'],
                                      name: '',
                                      image: '',
                                      oldMessages: const [],
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.chat,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AppText(
                                text: LocaleKeys.customer_name.tr(),
                                size: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 170.w,
                                child: AppText(
                                  textAlign: TextAlign.end,
                                  text:
                                      AppCubit.get(
                                        context,
                                      ).complaintsList[index]['userId']['userName'] ??
                                      "",
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
                                text: LocaleKeys.phone.tr(),
                                size: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              const Spacer(),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  makePhoneCall(
                                    AppCubit.get(
                                          context,
                                        ).complaintsList[index]['userId']['phone'] ??
                                        "",
                                  );
                                },
                                child: SizedBox(
                                  width: 170.w,
                                  child: AppText(
                                    textAlign: TextAlign.end,
                                    text:
                                        AppCubit.get(
                                          context,
                                        ).complaintsList[index]['userId']['phone'] ??
                                        "",
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
                                text: LocaleKeys.email.tr(),
                                size: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onLongPress: () {
                                  // Clipboard.setData(ClipboardData(text: AppCubit.get(context).complaintsList[index]['userId']['email'] ?? ""));
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        insetPadding: EdgeInsets.all(0.r),
                                        backgroundColor: Colors.transparent,
                                        content: Container(
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: AppText(
                                            textAlign: TextAlign.end,
                                            text:
                                                AppCubit.get(
                                                  context,
                                                ).complaintsList[index]['userId']['email'] ??
                                                "",
                                            size: 16.sp,
                                            family: FontFamily.tajawalBold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: SizedBox(
                                  width: 170.w,
                                  child: AppText(
                                    textAlign: TextAlign.end,
                                    text:
                                        AppCubit.get(
                                          context,
                                        ).complaintsList[index]['userId']['email'] ??
                                        "",
                                    size: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
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
                          AppText(
                            text: '${LocaleKeys.complaint.tr()}:',
                            size: 18.sp,
                            bottom: 8.h,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            width: 343.w,
                            child: AppText(
                              text:
                                  AppCubit.get(
                                    context,
                                  ).complaintsList[index]['message'] ??
                                  "",
                              size: 18.sp,
                              lines: 100,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 120.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
