import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_text.dart';

class CurrentRequests extends StatefulWidget {
  const CurrentRequests({super.key});

  @override
  State<CurrentRequests> createState() => _CurrentRequestsState();
}

class _CurrentRequestsState extends State<CurrentRequests> {
  @override
  void initState() {
    // AppCubit.get(context).getOrders(status: 'current');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          separatorBuilder:
              (BuildContext context, int index) => SizedBox(height: 16.h),
          itemCount: 10,
          itemBuilder:
              (BuildContext context, int index) => InkWell(
                onTap: () {
                  // AppRouter.navigateTo(
                  //     context,
                  //     OrderDetails(

                  //     ));
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: 'رقم الطلب: #1234',
                              size: 16.sp,
                              family: 'DINArabic-Medium',
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                  size: 14.sp,
                                ),
                                AppText(
                                  text: "منذ 10 دقائق",
                                  size: 14.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        AppText(
                          text: 'اسم الخدمة: خدمة سطحه',
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
                              child: AppText(
                                text: 'في الطريق',
                                size: 13.sp,
                                color: const Color(0xffFF8800),
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
