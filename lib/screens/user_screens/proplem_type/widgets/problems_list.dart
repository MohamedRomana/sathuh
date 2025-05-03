import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';

class ProblemsList extends StatelessWidget {
  const ProblemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.only(top: 20.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder:
              (context, index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (AppCubit.get(
                    context,
                  ).selectedProblemIndexes.contains(index)) {
                    AppCubit.get(context).changeSelectedProblem(index: -1);
                  } else {
                    AppCubit.get(context).changeSelectedProblem(index: index);
                  }
                },
                child: Container(
                  width: 343.w,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.all(16.r),
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
                      AppText(
                        text: 'عطل سياره منتصف الطريق',
                        size: 16.sp,
                        family: FontFamily.tajawalBold,
                      ),
                      const Spacer(),
                      Container(
                        height: 22.w,
                        width: 22.w,
                        margin: EdgeInsetsDirectional.only(end: 16.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          margin: EdgeInsets.all(2.r),
                          decoration: BoxDecoration(
                            color:
                                AppCubit.get(
                                      context,
                                    ).selectedProblemIndexes.contains(index)
                                    ? AppColors.primary
                                    : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }
}
