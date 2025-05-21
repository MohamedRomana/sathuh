import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_input.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
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
final _carNumberController = TextEditingController();
final _firstController = TextEditingController();
final _secondController = TextEditingController();
final _thirdController = TextEditingController();

class AddCars extends StatelessWidget {
  const AddCars({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
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
                    text: LocaleKeys.car_plate_number.tr(),
                    bottom: 8.h,
                    top: 8.h,
                    start: 16.w,
                    family: FontFamily.tajawalBold,
                    size: 16.sp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: AppInput(
                          filled: true,
                          border: 10.r,
                          end: 0,
                          enabledBorderColor: Colors.grey,
                          hint: '',
                          controller: _firstController,
                          textAlign: TextAlign.center,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.car_plate_number.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 90.w,
                        child: AppInput(
                          filled: true,
                          border: 10.r,
                          end: 0,
                          enabledBorderColor: Colors.grey,
                          hint: '',
                          controller: _secondController,
                          textAlign: TextAlign.center,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.car_plate_number.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 90.w,
                        child: AppInput(
                          end: 0,
                          filled: true,
                          border: 10.r,
                          enabledBorderColor: Colors.grey,
                          hint: '',
                          controller: _thirdController,
                          textAlign: TextAlign.center,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.car_plate_number.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 90.w,
                        child: AppInput(
                          end: 0,
                          filled: true,
                          hint: '',
                          controller: _carNumberController,
                          textAlign: TextAlign.center,
                          border: 10.r,
                          enabledBorderColor: Colors.grey,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.car_plate_number.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: AppButton(
                      top: 24.h,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AppRouter.pop(context);
                        }
                      },
                      child: AppText(
                        text: 'حفظ',
                        size: 21.sp,
                        color: Colors.white,
                        family: FontFamily.tajawalBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
