import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/add_images.dart';
import 'widgets/admin_top_bar.dart';
import 'widgets/edit_price.dart';
import 'widgets/sub_price.dart';

final _priceController = TextEditingController();
final _monthPriceController = TextEditingController();
final _yearPriceController = TextEditingController();
final _priceController2 = TextEditingController();
final _percentageController = TextEditingController();

class Price extends StatefulWidget {
  const Price({super.key});

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  @override
  initState() {
    super.initState();
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
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(height: 61.h),
                    const AdminTopBar(),
                    const AddImages(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: AppText(
                                text: LocaleKeys.pricing_settings.tr(),
                                size: 20.sp,
                                top: 16.h,
                                start: 16.w,
                                color: AppColors.secondray,
                                family: FontFamily.tajawalBold,
                                bottom: 16.h,
                              ),
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
                                  Tab(text: LocaleKeys.flatbed_pricing.tr()),
                                  Tab(
                                    text: LocaleKeys.subscription_pricing.tr(),
                                  ),
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
                                  ),
                                  SubscribePrice(
                                    monthPriceController2:
                                        _monthPriceController,
                                    yearspriceController: _yearPriceController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
