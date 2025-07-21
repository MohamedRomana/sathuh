import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import '../../../../core/constants/contsants.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_list_shimmer.dart';
import '../../../../core/widgets/custom_lottie_no_data.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../complaints_details/complaints_details.dart';
import '../chats/chat_details/adm_chat_details.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  void initState() {
    AppCubit.get(context).getComplaints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
                    state is GetComplaintsLoading
                        ? const CustomListShimmer()
                        : AppCubit.get(context).complaintsList.isEmpty
                        ? CustomLottieNoData(
                          lottieTitle: LocaleKeys.no_complaints.tr(),
                        )
                        : ListView.separated(
                          padding: EdgeInsets.only(bottom: 120.h),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              AppCubit.get(context).complaintsList.length,
                          separatorBuilder:
                              (context, index) => Container(height: 16.h),
                          itemBuilder:
                              (context, index) => InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  AppRouter.navigateTo(
                                    context,
                                    ComplaintsDetails(index: index),
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
                                        height: 60.w,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            150.r,
                                          ),
                                          color: Colors.black.withAlpha(50),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            150.r,
                                          ),
                                          child:
                                              (AppCubit.get(context)
                                                          .complaintsList[index]['userId']['image']
                                                          ?.isNotEmpty ??
                                                      false)
                                                  ? AppCachedImage(
                                                    image:
                                                        AppCubit.get(
                                                          context,
                                                        ).complaintsList[index]['userId']['image'] ??
                                                        "",
                                                    fit: BoxFit.cover,
                                                  )
                                                  : Image.asset(
                                                    Assets.img.unphoto.path,
                                                    fit: BoxFit.cover,
                                                  ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 170.w,
                                            child: AppText(
                                              start: 16.w,
                                              text:
                                                  AppCubit.get(
                                                    context,
                                                  ).complaintsList[index]['userId']['userName'] ??
                                                  "",
                                              size: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              top: 16.h,
                                              bottom: 5.h,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 170.w,
                                            child: AppText(
                                              start: 16.w,
                                              bottom: 5.h,
                                              text:
                                                  AppCubit.get(
                                                    context,
                                                  ).complaintsList[index]['userId']['email'] ??
                                                  "",
                                              size: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 170.w,
                                            child: AppText(
                                              start: 16.w,
                                              text:
                                                  AppCubit.get(
                                                    context,
                                                  ).complaintsList[index]['userId']['phone'] ??
                                                  "",
                                              size: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                              makePhoneCall(
                                                AppCubit.get(
                                                  context,
                                                ).complaintsList[index]['userId']['phone'],
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
                                    ],
                                  ),
                                ),
                              ),
                        ),
                    SizedBox(height: 120.h),
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
