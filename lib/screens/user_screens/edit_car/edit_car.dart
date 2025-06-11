import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';

class EditCar extends StatefulWidget {
  final int index;
  const EditCar({super.key, required this.index});

  @override
  State<EditCar> createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  final _formKey = GlobalKey<FormState>();
  final _carTypeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _carColorController = TextEditingController();
  final _chasseController = TextEditingController();
  final _carLetter1 = TextEditingController();
  final _carLetter2 = TextEditingController();
  final _carLetter3 = TextEditingController();
  final _carDigits = TextEditingController();
  final _carNumberController = TextEditingController();

  void _updateCarPlate() {
    _carNumberController.text =
        _carLetter1.text +
        _carLetter2.text +
        _carLetter3.text +
        _carDigits.text;
  }

  @override
  void initState() {
    AppCubit.get(context).carImage.clear();
    _carLetter1.addListener(_updateCarPlate);
    _carLetter2.addListener(_updateCarPlate);
    _carLetter3.addListener(_updateCarPlate);
    _carDigits.addListener(_updateCarPlate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: CustomBottomNav(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(title: LocaleKeys.edit_car_details.tr()),
                      AppCubit.get(context).carImage.isNotEmpty
                          ? Center(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Container(
                                    height: 150.w,
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
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: AppCachedImage(
                                      height: 150.w,
                                      width: 150.w,
                                      image:
                                          AppCubit.get(context).carsList[widget
                                              .index]['image'] ??
                                          "",
                                    ),
                                  ),
                                  PositionedDirectional(
                                    start: -5.w,
                                    top: -5.w,
                                    child: Icon(
                                      Icons.edit_square,
                                      color: Colors.red,
                                      size: 25.sp,
                                    ),
                                  ),
                                ],
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
                        hint:
                            AppCubit.get(context).carsList[widget
                                .index]['type'] ??
                            "",
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
                        start: 16.w,
                        family: FontFamily.tajawalBold,
                        size: 16.sp,
                      ),
                      AppInput(
                        filled: true,
                        enabledBorderColor: Colors.grey,
                        hint:
                            AppCubit.get(context).carsList[widget
                                .index]['model'] ??
                            "",
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
                        inputType: TextInputType.number,
                        hint:
                            AppCubit.get(context)
                                .carsList[widget.index]['manufactureYear']
                                .toString(),
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
                        hint:
                            AppCubit.get(context).carsList[widget
                                .index]['color'] ??
                            "",
                        controller: _carColorController,
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
                        hint:
                            AppCubit.get(context).carsList[widget
                                .index]['chassisNumber'] ??
                            "",
                        controller: _chasseController,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 16.w),
                          _buildPlateField(_carLetter1, 1, isLetter: true),
                          _buildPlateField(_carLetter2, 1, isLetter: true),
                          _buildPlateField(_carLetter3, 1, isLetter: true),
                          _buildPlateField(_carDigits, 4, isLetter: false),
                          SizedBox(width: 16.w),
                        ],
                      ),
                      Center(
                        child: BlocConsumer<AppCubit, AppState>(
                          listener: (context, state) {
                            if (state is EditCarSuccess) {
                              showFlashMessage(
                                message: state.message,
                                type: FlashMessageType.success,
                                context: context,
                              );
                              AppCubit.get(context).carImage.clear();
                              _carTypeController.clear();
                              _carModelController.clear();
                              _carYearController.clear();
                              _carColorController.clear();
                              _chasseController.clear();
                              _carLetter1.clear();
                              _carLetter2.clear();
                              _carLetter3.clear();
                              _carDigits.clear();
                              _carNumberController.clear();
                              Navigator.pop(context);
                            } else if (state is EditCarFailure) {
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
                                if (_carLetter1.text.isEmpty ||
                                    _carLetter2.text.isEmpty ||
                                    _carLetter3.text.isEmpty ||
                                    _carDigits.text.isEmpty) {
                                  showFlashMessage(
                                    message: LocaleKeys.car_plate_number.tr(),
                                    type: FlashMessageType.error,
                                    context: context,
                                  );
                                  return;
                                }

                                final carPlateNumber =
                                    "${_carLetter1.text} ${_carLetter2.text} ${_carLetter3.text} ${_carDigits.text}";

                                AppCubit.get(context).editCar(
                                  carId:
                                      (AppCubit.get(context).carsList[widget
                                                  .index]['_id'] ??
                                              "")
                                          .toString(),
                                  type:
                                      _carTypeController.text.isEmpty
                                          ? AppCubit.get(
                                            context,
                                          ).carsList[widget.index]['type']
                                          : _carTypeController.text,
                                  model:
                                      _carModelController.text.isEmpty
                                          ? AppCubit.get(
                                            context,
                                          ).carsList[widget.index]['model']
                                          : _carModelController.text,
                                  manufactureYear:
                                      _carYearController.text.isEmpty
                                          ? AppCubit.get(context)
                                              .carsList[widget
                                                  .index]['manufactureYear']
                                              .toString()
                                          : _carYearController.text,
                                  color:
                                      _carColorController.text.isEmpty
                                          ? AppCubit.get(
                                            context,
                                          ).carsList[widget.index]['color']
                                          : _carColorController.text,
                                  carPlateNumber:
                                      carPlateNumber.isEmpty
                                          ? AppCubit.get(
                                            context,
                                          ).carsList[widget
                                              .index]['carPlateNumber']
                                          : carPlateNumber,
                                  chassisNumber:
                                      _chasseController.text.isEmpty
                                          ? AppCubit.get(
                                            context,
                                          ).carsList[widget
                                              .index]['chassisNumber']
                                          : _chasseController.text,
                                );
                              },
                              child:
                                  state is EditCarLoading
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
                      SizedBox(height: 120.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildPlateField(
  TextEditingController controller,
  int maxLength, {
  required bool isLetter,
}) {
  return SizedBox(
    width: 60.w,
    child: TextFormField(
      controller: controller,
      maxLength: maxLength,
      textAlign: TextAlign.center,
      keyboardType: isLetter ? TextInputType.text : TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
        FilteringTextInputFormatter.allow(
          RegExp(isLetter ? r'[A-Za-z\u0600-\u06FF]' : r'[0-9]'),
        ),
      ],
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),
  );
}
