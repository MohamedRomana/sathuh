import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_input.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
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
  List<int> selectedValues = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).services().then((_) {
      final length = AppCubit.get(context).servicesList.length;

      selectedValues = List.generate(length, (_) => 1);
      controllers = List.generate(
        length,
        (_) => TextEditingController(text: '1'),
      );

      setState(() {}); // عشان يحدث بعد ما جهزت القوائم
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (selectedValues.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return Column(
          children: [
            SizedBox(height: 24.h),

            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppCubit.get(context).servicesList.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder:
                  (context, index) => Container(
                    width: 343.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
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
                          text:
                              "${LocaleKeys.pricePerMeter.tr()} ${AppCubit.get(context).servicesList[index]['type'] ?? ""}",
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(height: 10.h),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (selectedValues[index] > 1) {
                                  setState(() {
                                    selectedValues[index]--;
                                    controllers[index].text =
                                        selectedValues[index].toString();
                                  });
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
                                filled: true,
                                controller: controllers[index],
                                border: 10.r,
                                enabledBorderColor: Colors.grey,
                                inputType: TextInputType.number,
                                onChanged: (value) {
                                  final num = int.tryParse(value!);
                                  if (num != null && num >= 1 && num <= 100) {
                                    setState(() {
                                      selectedValues[index] = num;
                                    });
                                  }
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (selectedValues[index] < 100) {
                                  setState(() {
                                    selectedValues[index]++;
                                    controllers[index].text =
                                        selectedValues[index].toString();
                                  });
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
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),

                            Column(
                              children: [
                                DropdownButton<int>(
                                  value: selectedValues[index],
                                  items: List.generate(100, (index) {
                                    final val = index + 1;
                                    return DropdownMenuItem(
                                      value: val,
                                      child: Text(val.toString()),
                                    );
                                  }),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedValues[index] = value;
                                        controllers[index].text =
                                            value.toString();
                                      });
                                    }
                                  },
                                ),
                                SizedBox(height: 20.h),
                                SizedBox(
                                  width: 50.w,
                                  height: 30.h,
                                  child: BlocConsumer<AppCubit, AppState>(
                                    listener: (context, state) {
                                      if (state is UpdatePriceSuccess) {
                                        showFlashMessage(
                                          context: context,
                                          message: state.message,
                                          type: FlashMessageType.success,
                                        );
                                      } else if (state is UpdatePriceFailure) {
                                        showFlashMessage(
                                          context: context,
                                          message: state.error,
                                          type: FlashMessageType.error,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return AppButton(
                                        radius: 5.r,
                                        onPressed: () {
                                          AppCubit.get(context).updatePrice(
                                            serviceId:
                                                AppCubit.get(
                                                  context,
                                                ).servicesList[index]['_id'],
                                            pricePerMeter:
                                                controllers[index].text,
                                          );
                                        },
                                        child:
                                            state is UpdatePriceLoading
                                                ? SizedBox(
                                                  height: 10.w,
                                                  width: 10.w,
                                                  child: CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2.w,
                                                  ),
                                                )
                                                : AppText(
                                                  text: LocaleKeys.save.tr(),
                                                  color: Colors.white,
                                                  size: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            ),

            // AppButton(
            //   top: 30.h,
            //   onPressed: () {
            //     AppCubit.get(context).updatePrice(serviceId: AppCubit.get(context).servicesList[index]['id'], pricePerMeter: pricePerMeter)
            //   },
            //   child: AppText(
            //     text: LocaleKeys.save.tr(),
            //     color: Colors.white,
            //     size: 21.sp,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 120.h),
          ],
        );
      },
    );
  }
}
