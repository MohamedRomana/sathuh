import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_input.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';

class EditPrice extends StatefulWidget {
  final TextEditingController priceController;
  final TextEditingController priceController2;
  final TextEditingController percentageController;
  const EditPrice({
    super.key,
    required this.priceController,
    required this.priceController2,
    required this.percentageController,
  });

  @override
  State<EditPrice> createState() => _EditPriceState();
}

class _EditPriceState extends State<EditPrice> {
  int selectedValue = 1;
  int selectedPercentage = 0;
  final TextEditingController priceController = TextEditingController(
    text: '1',
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
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
                      text: LocaleKeys.flatbed_meter_price.tr(),
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
                              priceController.text = selectedValue.toString();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.r),
                            decoration: BoxDecoration(
                              color: AppColors.borderColor,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: AppInput(
                            hint: '1',
                            filled: true,
                            controller: priceController,
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
                              priceController.text = selectedValue.toString();
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
                              priceController.text = selectedValue.toString();
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
                      text: LocaleKeys.hydraulic_flatbed_meter_price.tr(),
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
                              widget.priceController2.text =
                                  selectedValue.toString();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.r),
                            decoration: BoxDecoration(
                              color: AppColors.borderColor,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: AppInput(
                            hint: '1',
                            filled: true,
                            controller: widget.priceController2,
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
                              widget.priceController2.text =
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
                              widget.priceController2.text =
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
                      text: LocaleKeys.admin_percentage.tr(),
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (selectedPercentage > 0) {
                              selectedPercentage--;
                              widget.percentageController.text =
                                  selectedPercentage.toString();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.r),
                            decoration: BoxDecoration(
                              color: AppColors.borderColor,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 100.w,
                          child: AppInput(
                            hint: '0',
                            filled: true,
                            controller: widget.percentageController,
                            border: 10.r,
                            enabledBorderColor: Colors.grey,
                            inputType: TextInputType.number,
                            onChanged: (value) {
                              final num = int.tryParse(value!);
                              if (num != null && num >= 0 && num <= 100) {
                                selectedPercentage = num;
                              }
                            },
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            if (selectedPercentage < 100) {
                              selectedPercentage++;
                              widget.percentageController.text =
                                  selectedPercentage.toString();
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
                          value: selectedPercentage,
                          items: List.generate(101, (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text('$index%'),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              selectedPercentage = value;
                              widget.percentageController.text =
                                  selectedPercentage.toString();
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
          ),
        );
      },
    );
  }
}
