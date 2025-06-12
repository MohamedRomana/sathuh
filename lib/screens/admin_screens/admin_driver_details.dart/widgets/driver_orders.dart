import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/custom_lottie_widget.dart';
import 'package:sathuh/gen/assets.gen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';
import 'driver_orders_details.dart';

class CustomDriverOrders extends StatelessWidget {
  final int index2;
  const CustomDriverOrders({super.key, required this.index2});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppText(
                start: 16.w,
                text: LocaleKeys.orders.tr(),
                size: 20.sp,
                fontWeight: FontWeight.bold,
                top: 24.h,
                bottom: 16.h,
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.all(16.r),
              width: 343.w,
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
              child:
                  AppCubit.get(
                        context,
                      ).driversList[index2]['completedRequests'].isEmpty
                      ? CustomLottieWidget(
                        height: 150.w,
                        width: 150.w,
                        lottieName: Assets.img.notiEmpty,
                      )
                      : ListView.separated(
                        padding: EdgeInsetsDirectional.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder:
                            (BuildContext context, int index) =>
                                Container(height: 16.h),
                        itemCount:
                            AppCubit.get(
                              context,
                            ).driversList[index2]['completedRequests'].length,
                        itemBuilder:
                            (BuildContext context, int index) => InkWell(
                              onTap: () {
                                AppRouter.navigateTo(
                                  context,
                                  DriverOrdersDetails(
                                    index: index,
                                    index2: index2,
                                  ),
                                );
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                width: 343.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withAlpha(70),
                                      spreadRadius: 1.r,
                                      blurRadius: 5.r,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 170.w,
                                            child: AppText(
                                              text:
                                                  '${LocaleKeys.order_number.tr()} ${AppCubit.get(context).driversList[index2]['completedRequests'][index]['_id'] ?? ""}',
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
                                                  ).driversList[index2]['completedRequests'][index]['createdAt'],
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
                                            '${LocaleKeys.serviceName.tr()}: خدمة سطحة',
                                        size: 16.sp,
                                        family: 'DINArabic-Light',
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: Container(
                                          height: 24.h,
                                          width: 83.w,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              30.r,
                                            ),
                                            border: Border.all(
                                              color: Colors.green,
                                            ),
                                          ),
                                          child: SizedBox(
                                            width: 83.w,
                                            child: Center(
                                              child: AppText(
                                                text:
                                                    AppCubit.get(
                                                      context,
                                                    ).driversList[index2]['completedRequests'][index]['status'] ??
                                                    "",
                                                size: 13.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
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
            ),
          ],
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
