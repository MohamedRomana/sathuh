import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/alert_dialog.dart';
import 'package:sathuh/core/widgets/app_input.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'choose_service_price.dart';

class EditPrice extends StatefulWidget {
  final TextEditingController priceController;
  final TextEditingController priceController2;
  final TextEditingController percentageController;
  final TextEditingController percentageController2;
  const EditPrice({
    super.key,
    required this.priceController,
    required this.priceController2,
    required this.percentageController,
    required this.percentageController2,
  });

  @override
  State<EditPrice> createState() => _EditPriceState();
}

class _EditPriceState extends State<EditPrice> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppText(
                start: 16.w,
                top: 20.h,
                text: LocaleKeys.add_price_per_meter.tr(),
                size: 18.sp,
                family: FontFamily.tajawalBold,
              ),
            ),
            AppInput(
              top: 10.h,
              bottom: 16.h,
              filled: true,
              controller: widget.priceController,
              hint: LocaleKeys.add_price_per_meter.tr(),
              prefixIcon: const Icon(Icons.price_change_outlined),
              inputType: TextInputType.number,
              suffixIcon: IconButton(
                padding: EdgeInsetsDirectional.only(end: 16.w),
                icon: AppText(
                  text: LocaleKeys.save.tr(),
                  color: AppColors.primary,
                ),
                onPressed: () {
                  customAlertDialog(
                    context: context,
                    dialogBackGroundColor: AppColors.third,
                    alertDialogHeight: 270.h,
                    alertDialogWidth: 311.w,
                    child: ChooseServicePrice(
                      priceController: widget.priceController,
                    ),
                  );
                },
              ),
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.add_price_per_meter_required.tr();
                }
                return null;
              },
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppText(
                start: 16.w,
                text: LocaleKeys.edit_price_per_meter.tr(),
                size: 18.sp,
                family: FontFamily.tajawalBold,
              ),
            ),
            AppInput(
              top: 10.h,
              bottom: 16.h,
              filled: true,
              controller: widget.priceController2,
              hint: LocaleKeys.edit_price_per_meter.tr(),
              prefixIcon: const Icon(Icons.price_change_outlined),
              inputType: TextInputType.number,
              suffixIcon: IconButton(
                padding: EdgeInsetsDirectional.only(end: 16.w),
                icon: AppText(
                  text: LocaleKeys.save.tr(),
                  color: AppColors.primary,
                ),
                onPressed: () {
                  customAlertDialog(
                    context: context,
                    dialogBackGroundColor: AppColors.third,
                    alertDialogHeight: 270.h,
                    alertDialogWidth: 311.w,
                    child: ChooseServicePrice(
                      isEdit: true,
                      priceController2: widget.priceController2,
                      priceController: widget.priceController,
                    ),
                  );
                },
              ),
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.edit_price_per_meter_required.tr();
                }
                return null;
              },
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppText(
                start: 16.w,
                text: LocaleKeys.add_percentage.tr(),
                size: 18.sp,
                family: FontFamily.tajawalBold,
              ),
            ),
            AppInput(
              top: 10.h,
              bottom: 16.h,
              filled: true,
              controller: widget.percentageController,
              hint: LocaleKeys.add_percentage.tr(),
              prefixIcon: const Icon(Icons.price_change_outlined),
              inputType: TextInputType.number,
              suffixIcon: BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (state is AddPercentageSuccess) {
                    showFlashMessage(
                      message: state.message,
                      type: FlashMessageType.success,
                      context: context,
                    );
                    widget.percentageController.clear();
                  } else if (state is AddPercentageFailure) {
                    showFlashMessage(
                      message: state.error,
                      type: FlashMessageType.error,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    padding: EdgeInsetsDirectional.only(end: 16.w),
                    icon:
                        state is AddPercentageLoading
                            ? const CircularProgressIndicator(
                              color: AppColors.primary,
                            )
                            : AppText(
                              text: LocaleKeys.save.tr(),
                              color: AppColors.primary,
                            ),
                    onPressed: () {
                      AppCubit.get(context).addPercentage(
                        percentage: widget.percentageController.text,
                      );
                    },
                  );
                },
              ),
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.add_percentage_required.tr();
                }
                return null;
              },
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppText(
                start: 16.w,
                text: LocaleKeys.edit_percentage.tr(),
                size: 18.sp,
                family: FontFamily.tajawalBold,
              ),
            ),
            AppInput(
              top: 10.h,
              bottom: 16.h,
              filled: true,
              controller: widget.percentageController2,
              hint: LocaleKeys.edit_percentage.tr(),
              prefixIcon: const Icon(Icons.price_change_outlined),
              inputType: TextInputType.number,
              suffixIcon: BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (state is UpdatePercentageSuccess) {
                    showFlashMessage(
                      message: state.message,
                      type: FlashMessageType.success,
                      context: context,
                    );
                    widget.percentageController2.clear();
                  } else if (state is UpdatePercentageFailure) {
                    showFlashMessage(
                      message: state.error,
                      type: FlashMessageType.error,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    padding: EdgeInsetsDirectional.only(end: 16.w),
                    icon:
                        state is UpdatePercentageLoading
                            ? const CircularProgressIndicator(
                              color: AppColors.primary,
                            )
                            : AppText(
                              text: LocaleKeys.save.tr(),
                              color: AppColors.primary,
                            ),
                    onPressed: () {
                      AppCubit.get(context).updatePercentage(
                        percentage: widget.percentageController2.text,
                      );
                    },
                  );
                },
              ),
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.edit_percentage_required.tr();
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
