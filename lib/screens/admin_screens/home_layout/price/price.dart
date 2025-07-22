import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/admin_top_bar.dart';
import 'widgets/edit_price.dart';
import 'widgets/sub_price.dart';

final _priceController = TextEditingController();
final _priceController2 = TextEditingController();
final _percentageController = TextEditingController();
final _percentageController2 = TextEditingController();

class Price extends StatelessWidget {
  const Price({super.key});

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
                    SizedBox(height: 50.h),
                    const AdminTopBar(),
                    SizedBox(height: 30.h),
                    // Align(
                    //   alignment: AlignmentDirectional.centerStart,
                    //   child: AppText(
                    //     text: LocaleKeys.pricing_settings.tr(),
                    //     size: 20.sp,
                    //     top: 16.h,
                    //     start: 16.w,
                    //     color: AppColors.secondray,
                    //     family: FontFamily.tajawalBold,
                    //     bottom: 16.h,
                    //   ),
                    // ),
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
                          Tab(text: LocaleKeys.flatbed_pricing.tr()),
                          Tab(text: LocaleKeys.subscription_pricing.tr()),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          EditPrice(
                            priceController: _priceController,
                            priceController2: _priceController2,
                            percentageController: _percentageController,
                            percentageController2: _percentageController2,
                          ),
                          const SubscribePrice(),
                        ],
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
