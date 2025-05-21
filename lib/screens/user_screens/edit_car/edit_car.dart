import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';

class EditCar extends StatefulWidget {
  const EditCar({super.key});

  @override
  State<EditCar> createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  final _formKey = GlobalKey<FormState>();
  final _carTypeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _carColorController = TextEditingController();
  final _carNumberController = TextEditingController();
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  final _thirdController = TextEditingController();

  @override
  void dispose() {
    _carTypeController.dispose();
    _carModelController.dispose();
    _carYearController.dispose();
    _carColorController.dispose();
    _carNumberController.dispose();
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: CustomBottomNav(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(title: LocaleKeys.edit_car_details.tr()),
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
                    hint: 'سيدان',
                    controller: _carTypeController,
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
                    hint: 'bmw',
                    controller: _carModelController,
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
                    hint: '2000',
                    controller: _carYearController,
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
                    hint: 'زرقاء',
                    controller: _carColorController,
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
                          hint: 'ا',
                          controller: _firstController,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 90.w,
                        child: AppInput(
                          filled: true,
                          border: 10.r,
                          end: 0,
                          enabledBorderColor: Colors.grey,
                          hint: 'ب',
                          controller: _secondController,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 90.w,
                        child: AppInput(
                          end: 0,
                          filled: true,
                          border: 10.r,
                          enabledBorderColor: Colors.grey,
                          hint: 'ج',
                          controller: _thirdController,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 90.w,
                        child: AppInput(
                          end: 0,
                          filled: true,
                          hint: '55454',
                          controller: _carNumberController,
                          textAlign: TextAlign.center,
                          border: 10.r,
                          enabledBorderColor: Colors.grey,
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
          ],
        ),
      ),
    );
  }
}
