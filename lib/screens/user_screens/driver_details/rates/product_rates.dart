import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/cache/cache_helper.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/alert_dialog.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/reviews_dialog.dart';
import 'widgets/users_reviews.dart';

final _formKey = GlobalKey<FormState>();
final _commentController = TextEditingController();

class ProductRates extends StatefulWidget {
  const ProductRates({super.key});

  @override
  State<ProductRates> createState() => _ProductRatesState();
}

class _ProductRatesState extends State<ProductRates> {
  double value = 1.0;
  @override
  void initState() {
    _commentController.clear();
    value = 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  start: 16.w,
                  text: LocaleKeys.rates.tr(),
                  size: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                CacheHelper.getUserType() == 'client'
                    ? SizedBox(
                      height: 40.h,
                      child: AppButton(
                        width: 100.w,
                        end: 16.w,
                        onPressed: () {
                          customAlertDialog(
                            alertDialogWidth: 300.w,
                            alertDialogHeight: 360.h,
                            context: context,
                            child: ReviewsDialog(
                              formKey: _formKey,
                              commentController: _commentController,
                            ),
                          );
                        },
                        child: AppText(
                          text: LocaleKeys.confirmRating.tr(),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    : Container(),
              ],
            ),
            Container(height: 10.h),
            const UsersReviews(),
          ],
        );
      },
    );
  }
}
