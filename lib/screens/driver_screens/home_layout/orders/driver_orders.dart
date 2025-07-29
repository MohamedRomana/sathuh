import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_list_shimmer.dart';
import '../../../../core/widgets/custom_lottie_widget.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../driv_order_details/driv_order_details.dart';
import 'widgets/driv_current_orders.dart';
import 'widgets/drive_orders_history.dart';

class DriverOrders extends StatelessWidget {
  const DriverOrders({super.key});

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
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    CustomAppBar(
                      title: LocaleKeys.orders.tr(),
                      isHomeLayout: true,
                    ),
                    Container(
                      width: 343.w,
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
                          Tab(text: LocaleKeys.currentOrders.tr()),
                          Tab(text: LocaleKeys.completedOrders.tr()),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [DrivCurrentOrders(), DriveOrdersHistory()],
                      ),
                    ),
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

class OnWayOrders extends StatefulWidget {
  const OnWayOrders({super.key});

  @override
  State<OnWayOrders> createState() => _OnWayOrdersState();
}

class _OnWayOrdersState extends State<OnWayOrders> {
  @override
  void initState() {
    AppCubit.get(context).inRoadRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state is InRoadRequestLoading &&
                AppCubit.get(context).inRoadRequestsList.isEmpty
            ? const CustomListShimmer()
            : AppCubit.get(context).inRoadRequestsList.isEmpty
            ? Center(
              child: CustomLottieWidget(lottieName: Assets.img.emptyorder),
            )
            : ListView.separated(
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 16.w,
                top: 24.h,
                bottom: 120.h,
              ),
              separatorBuilder:
                  (BuildContext context, int index) => Container(height: 16.h),
              itemCount: AppCubit.get(context).inRoadRequestsList.length,
              itemBuilder:
                  (BuildContext context, int index) => InkWell(
                    onTap: () {
                      AppRouter.navigateTo(
                        context,
                        DrivOrderDetails(index: index),
                      );
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      width: 343.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 120.w,
                                  child: AppText(
                                    text:
                                        '${LocaleKeys.order_number.tr()} ${AppCubit.get(context).inRoadRequestsList[index]['id'] ?? ""}',
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
                                            ).inRoadRequestsList[index]['createdAt'] ??
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
                                  '${LocaleKeys.serviceName.tr()}: ${AppCubit.get(context).inRoadRequestsList[index]['serviceId']['type'] ?? ""}',
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
                                    width: 83.w,
                                    child: AppText(
                                      text:
                                          AppCubit.get(
                                            context,
                                          ).inRoadRequestsList[index]['status'] ??
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
