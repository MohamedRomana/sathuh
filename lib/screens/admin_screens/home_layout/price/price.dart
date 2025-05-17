import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/edit_price.dart';

class Price extends StatefulWidget {
  const Price({super.key});

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  @override
  initState() {
    super.initState();
    AppCubit.get(context).count = 0;
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
              Column(
                children: [
                  SizedBox(height: 61.h),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(
                          start: 16.w,
                          end: 5.w,
                        ),
                        height: 50.w,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 3.w),
                          image: DecorationImage(
                            image: AssetImage(Assets.img.client.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: AppText(
                              text: LocaleKeys.welcome_dear_customer.tr(),
                              size: 12.sp,
                              color: AppColors.secondray,
                              family: FontFamily.tajawalBold,
                            ),
                          ),
                          SizedBox(
                            width: 150.w,
                            child: AppText(
                              text:
                                  LocaleKeys.thank_you_for_your_preference.tr(),
                              size: 10.sp,
                              color: AppColors.secondray,
                              family: FontFamily.tajawalBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  const EditPrice(),
                  AppButton(
                    top: 30.h,
                    onPressed: () {},
                    child: AppText(
                      text: LocaleKeys.save.tr(),
                      color: Colors.white,
                      size: 21.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
