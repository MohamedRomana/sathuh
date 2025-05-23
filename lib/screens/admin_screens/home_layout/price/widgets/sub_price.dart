import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';

class SubscribePrice extends StatefulWidget {
  final TextEditingController monthPriceController2;
  final TextEditingController yearspriceController;
  const SubscribePrice({
    super.key,
    required this.monthPriceController2,
    required this.yearspriceController,
  });

  @override
  State<SubscribePrice> createState() => _SubscribePriceState();
}

class _SubscribePriceState extends State<SubscribePrice> {
  int selectedValue = 1;
  final TextEditingController priceController2 = TextEditingController(
    text: '1',
  );
  @override
  void initState() {
    widget.monthPriceController2.text = '1';
    widget.yearspriceController.text = '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        Container(
          width: 343.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: LocaleKeys.monthly_subscription_price.tr(),
                size: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (selectedValue > 1) {
                        selectedValue--;
                        widget.monthPriceController2.text =
                            selectedValue.toString();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: const Icon(Icons.remove, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: AppInput(
                      filled: true,
                      controller: widget.monthPriceController2,
                      border: 10.r,
                      enabledBorderColor: Colors.grey,
                      inputType: TextInputType.number,
                      onChanged: (value) {
                        final num = int.tryParse(value!);
                        if (num != null && num >= 1 && num <= 100) {
                          selectedValue = num;
                        }
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (selectedValue < 100) {
                        selectedValue++;
                        widget.monthPriceController2.text =
                            selectedValue.toString();
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                  const Spacer(),
    
                  DropdownButton<int>(
                    value: selectedValue,
                    items: List.generate(100, (index) {
                      final val = index + 1;
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val.toString()),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        selectedValue = value;
                        widget.monthPriceController2.text =
                            selectedValue.toString();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          width: 343.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: LocaleKeys.annual_subscription_price.tr(),
                size: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (selectedValue > 1) {
                        selectedValue--;
                        widget.yearspriceController.text =
                            selectedValue.toString();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: const Icon(Icons.remove, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: AppInput(
                      filled: true,
                      controller: widget.yearspriceController,
                      border: 10.r,
                      enabledBorderColor: Colors.grey,
                      inputType: TextInputType.number,
                      onChanged: (value) {
                        final num = int.tryParse(value!);
                        if (num != null && num >= 1 && num <= 100) {
                          selectedValue = num;
                        }
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (selectedValue < 100) {
                        selectedValue++;
                        widget.yearspriceController.text =
                            selectedValue.toString();
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                  const Spacer(),
    
                  DropdownButton<int>(
                    value: selectedValue,
                    items: List.generate(100, (index) {
                      final val = index + 1;
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val.toString()),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        selectedValue = value;
                        widget.yearspriceController.text =
                            selectedValue.toString();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
    
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
        SizedBox(height: 120.h),
      ],
    );
  }
}
