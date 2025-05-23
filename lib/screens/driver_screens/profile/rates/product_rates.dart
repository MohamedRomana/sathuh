import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/users_reviews.dart';

class DriverRates extends StatefulWidget {
  const DriverRates({super.key});

  @override
  State<DriverRates> createState() => _DriverRatesState();
}

class _DriverRatesState extends State<DriverRates> {
  double value = 1.0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  start: 16.w,
                  text: LocaleKeys.rates.tr(),
                  size: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            const DriverUsersReviews(),
          ],
        );
      },
    );
  }
}
