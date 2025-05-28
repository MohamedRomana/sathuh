import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_input.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';

final _formKey = GlobalKey<FormState>();
final _carTypeController = TextEditingController();
final _carModelController = TextEditingController();
final _carYearController = TextEditingController();
final _carColorController = TextEditingController();
final _chasseController = TextEditingController();
final _carNumberController = TextEditingController();

class AddCars extends StatefulWidget {
  const AddCars({super.key});

  @override
  State<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends State<AddCars> {
  @override
  void initState() {
    _carTypeController.clear();
    _carModelController.clear();
    _carYearController.clear();
    _carColorController.clear();
    _chasseController.clear();
    _carNumberController.clear();
    AppCubit.get(context).carImage.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          resizeToAvoidBottomInset: true,
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(title: LocaleKeys.add_car.tr()),

                      Center(
                        child: AppText(
                          top: 10.h,
                          text: LocaleKeys.carImage.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(height: 10.h),
                      AppCubit.get(context).carImage.isNotEmpty
                          ? Center(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Container(
                                    height: 150.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          AppCubit.get(context).carImage.first,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                PositionedDirectional(
                                  end: 0,
                                  child: InkWell(
                                    onTap: () {
                                      AppCubit.get(context).removeCarImage();
                                    },
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Center(
                            child: InkWell(
                              onTap: () {
                                AppCubit.get(context).getCarImage(context);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(10.r),
                                color: Colors.grey,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: SizedBox(
                                    height: 150.h,
                                    width: 150.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add_a_photo,
                                          color: Colors.grey,
                                        ),
                                        AppText(
                                          text: LocaleKeys.attach_photo.tr(),
                                          size: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      AppText(
                        text: LocaleKeys.car_type.tr(),
                        bottom: 8.h,
                        start: 16.w,
                        family: FontFamily.tajawalBold,
                        size: 16.sp,
                      ),
                      AppInput(
                        filled: true,
                        enabledBorderColor: Colors.grey,
                        hint: LocaleKeys.car_type.tr(),
                        controller: _carTypeController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.car_type.tr();
                          }
                          return null;
                        },
                      ),
                      AppText(
                        text: LocaleKeys.car_model.tr(),
                        bottom: 8.h,
                        top: 8.h,
                        start: 16.w,
                        family: FontFamily.tajawalBold,
                        size: 16.sp,
                      ),
                      AppInput(
                        filled: true,
                        enabledBorderColor: Colors.grey,
                        hint: LocaleKeys.car_model.tr(),
                        controller: _carModelController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.car_model.tr();
                          }
                          return null;
                        },
                      ),
                      AppText(
                        text: LocaleKeys.manufacture_year.tr(),
                        start: 16.w,
                        bottom: 8.h,
                        top: 8.h,
                        family: FontFamily.tajawalBold,
                        size: 16.sp,
                      ),
                      AppInput(
                        filled: true,
                        enabledBorderColor: Colors.grey,
                        inputType: TextInputType.number,
                        hint: LocaleKeys.manufacture_year.tr(),
                        controller: _carYearController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.manufacture_year.tr();
                          }
                          return null;
                        },
                      ),
                      AppText(
                        text: LocaleKeys.color.tr(),
                        start: 16.w,
                        bottom: 8.h,
                        top: 8.h,
                        family: FontFamily.tajawalBold,
                        size: 16.sp,
                      ),
                      AppInput(
                        filled: true,
                        enabledBorderColor: Colors.grey,
                        hint: LocaleKeys.color.tr(),
                        controller: _carColorController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.color.tr();
                          }
                          return null;
                        },
                      ),
                      AppText(
                        text: LocaleKeys.chassis_number.tr(),
                        start: 16.w,
                        bottom: 8.h,
                        top: 8.h,
                        family: FontFamily.tajawalBold,
                        size: 16.sp,
                      ),
                      AppInput(
                        filled: true,
                        enabledBorderColor: Colors.grey,
                        hint: LocaleKeys.chassis_number.tr(),
                        controller: _chasseController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.color.tr();
                          }
                          return null;
                        },
                      ),
                      AppText(
                        text: LocaleKeys.car_plate_number.tr(),
                        bottom: 8.h,
                        top: 8.h,
                        start: 16.w,
                        family: FontFamily.tajawalBold,
                        size: 16.sp,
                      ),
                      AppInput(
                        filled: true,
                        enabledBorderColor: Colors.grey,
                        hint: LocaleKeys.car_plate_number.tr(),
                        controller: _carNumberController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.car_plate_number.tr();
                          }
                          return null;
                        },
                      ),
                      Center(
                        child: BlocConsumer<AppCubit, AppState>(
                          listener: (context, state) {
                            if (state is AddCarsSuccess) {
                              _carTypeController.clear();
                              _carModelController.clear();
                              _carYearController.clear();
                              _carColorController.clear();
                              _chasseController.clear();
                              _carNumberController.clear();
                              AppCubit.get(context).removeCarImage();

                              AppRouter.pop(context);
                              showFlashMessage(
                                message: state.message,
                                type: FlashMessageType.success,
                                context: context,
                              );
                            } else if (state is AddCarsFailure) {
                              showFlashMessage(
                                message: state.error,
                                type: FlashMessageType.error,
                                context: context,
                              );
                            }
                          },
                          builder: (context, state) {
                            return AppButton(
                              top: 24.h,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  AppCubit.get(context).addCars(
                                    type: _carTypeController.text,
                                    model: _carModelController.text,
                                    manufactureYear: _carYearController.text,
                                    color: _carColorController.text,
                                    chassisNumber: _chasseController.text,
                                    carPlateNumber: _carNumberController.text,
                                  );
                                }
                              },
                              child:
                                  state is AddCarsLoading
                                      ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : AppText(
                                        text: LocaleKeys.save.tr(),
                                        size: 21.sp,
                                        color: Colors.white,
                                        family: FontFamily.tajawalBold,
                                      ),
                            );
                          },
                        ),
                      ),

                      Container(height: 120.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
