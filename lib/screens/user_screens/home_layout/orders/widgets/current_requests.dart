import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/custom_list_shimmer.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_lottie_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../order_details/order_details.dart';

class CurrentRequests extends StatefulWidget {
  const CurrentRequests({super.key});

  @override
  State<CurrentRequests> createState() => _CurrentRequestsState();
}

class _CurrentRequestsState extends State<CurrentRequests> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).pendingRequest();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state is PendingRequestLoading &&
                AppCubit.get(context).pendingRequestsList.isEmpty
            ? const CustomListShimmer()
            : AppCubit.get(context).pendingRequestsList.isEmpty
            ? Center(
              child: CustomLottieWidget(lottieName: Assets.img.emptyorder),
            )
            : NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.reverse) {
                  AppCubit.get(context).pendingRequest(loadMore: true);
                }
                return true;
              },
              child: ListView.separated(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 16.w,
                  top: 24.h,
                  bottom: 120.h,
                ),
                separatorBuilder:
                    (BuildContext context, int index) =>
                        Container(height: 16.h),
                itemCount: AppCubit.get(context).pendingRequestsList.length,
                itemBuilder:
                    (BuildContext context, int index) => InkWell(
                      onTap: () {
                        AppRouter.navigateTo(
                          context,
                          OrderDetails(index: index, isPending: true),
                        );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        width: 343.w,
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
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200.w,
                                    child: AppText(
                                      text:
                                          '${LocaleKeys.orderNumber.tr()} ${AppCubit.get(context).pendingRequestsList[index]['id']}',
                                      size: 16.sp,
                                      family: 'DINArabic-Medium',
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.grey,
                                        size: 14.sp,
                                      ),
                                      AppText(
                                        text: _formatDate(
                                          AppCubit.get(
                                                context,
                                              ).pendingRequestsList[index]['createdAt'] ??
                                              "",
                                        ),
                                        size: 14.sp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              AppText(
                                text:
                                    '${LocaleKeys.serviceName.tr()}: ${AppCubit.get(context).pendingRequestsList[index]['serviceId'] == '6832d41daaf83e5694854d65' ? 'سطحه عاديه' : 'سطحه هيدروليك'}',
                                size: 16.sp,
                                family: 'DINArabic-Light',
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Container(
                                  height: 24.h,
                                  width: 83.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(30.r),
                                    border: Border.all(
                                      color: const Color(0xffFF8800),
                                    ),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: 50.w,
                                      child: AppText(
                                        text:
                                            AppCubit.get(
                                              context,
                                            ).pendingRequestsList[index]['status'] ??
                                            "",
                                        size: 13.sp,
                                        color: const Color(0xffFF8800),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              ),
            );
      },
    );
  }
}

String _formatDate(String? isoDate) {
  if (isoDate == null) return '';
  final date = DateTime.parse(isoDate);
  return DateFormat('dd/MM/yyyy').format(date);
}
