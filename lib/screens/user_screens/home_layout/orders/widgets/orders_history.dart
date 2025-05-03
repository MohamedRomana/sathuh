import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_text.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    // AppCubit.get(context).getOrders(status: 'finish');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            top: 24.h,
            bottom: 120.h,
          ),
          separatorBuilder:
              (BuildContext context, int index) => SizedBox(height: 16.h),
          itemCount: 10,
          itemBuilder:
              (BuildContext context, int index) => InkWell(
                onTap: () {
                  // AppRouter.navigateTo(
                  //     context,
                  //     OrderDetails(
                  //       id: AppCubit.get(context).ordersList[index]['id'],
                  //     ));
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
                            AppText(
                              text: 'رقم الطلب: #45454',
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
                                  text: "10/10/2022",
                                  size: 14.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        AppText(
                          text: 'اسم الخدمة: خدمة سطحة',
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
                                text: 'مكتمل',
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
