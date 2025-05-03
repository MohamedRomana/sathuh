// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class EditProfileFields extends StatefulWidget {
  final TextEditingController passController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController cityController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  const EditProfileFields({
    super.key,
    required this.passController,
    required this.phoneController,
    required this.firstNameController,
    required this.lastNameController,
    required this.cityController, required this.emailController,
  });

  @override
  State<EditProfileFields> createState() => _EditProfileFieldsState();
}

class _EditProfileFieldsState extends State<EditProfileFields> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode passFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    nameFocus.addListener(() => setState(() {}));
    lastNameFocus.addListener(() => setState(() {}));
    phoneFocus.addListener(() => setState(() {}));
    emailFocus.addListener(() => setState(() {}));
    cityFocus.addListener(() => setState(() {}));
    passFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameFocus.dispose();
    lastNameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    cityFocus.dispose();
    passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              start: 18.w,
              text: LocaleKeys.edit_personal_information.tr(),
              size: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            Container(
              width: 343.w,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.sp),
              margin: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1.r,
                    blurRadius: 5.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: Column(
                children: [
                  AppInput(
                    focusNode: nameFocus,
                    filled: true,
                    enabledBorderColor: Colors.grey,
                    hint: 'Ahmed',
                    controller: widget.firstNameController,
                    prefixIcon: SizedBox(
                      height: 28.w,
                      width: 28.w,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.drawerProfile,
                          height: 28.w,
                          width: 28.w,
                          color:
                              nameFocus.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  AppInput(
                    focusNode: lastNameFocus,
                    top: 16.h,
                    bottom: 16.h,
                    filled: true,
                    enabledBorderColor: Colors.grey,
                    hint: 'Ali',
                    controller: widget.lastNameController,
                    prefixIcon: SizedBox(
                      height: 28.w,
                      width: 28.w,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.drawerProfile,
                          height: 28.w,
                          width: 28.w,
                          color:
                              lastNameFocus.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  AppInput(
                    focusNode: phoneFocus,
                    bottom: 16.h,
                    filled: true,
                    enabledBorderColor: Colors.grey,
                    hint: '+20112312554',
                    controller: widget.phoneController,
                    inputType: TextInputType.phone,
                    prefixIcon: SizedBox(
                      height: 28.w,
                      width: 28.w,
                      child: Center(
                        child: SvgPicture.asset(
                          height: 28.w,
                          width: 28.w,
                          Assets.svg.call,
                          color:
                              phoneFocus.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  AppInput(
                    focusNode: phoneFocus,
                    bottom: 16.h,
                    filled: true,
                    enabledBorderColor: Colors.grey,
                    hint: 'Ahmed@gmail.com',
                    controller: widget.emailController,
                    prefixIcon: SizedBox(
                      height: 28.w,
                      width: 28.w,
                      child: Center(
                        child: SvgPicture.asset(
                          height: 28.w,
                          width: 28.w,
                          Assets.svg.drawerSms,
                          color:
                              phoneFocus.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  AppInput(
                    focusNode: cityFocus,
                    enabledBorderColor: Colors.grey,
                    bottom: 16.h,
                    filled: true,
                    hint: 'المنصورة',
                    controller: widget.cityController,
                    prefixIcon: SizedBox(
                      height: 25.w,
                      width: 25.w,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.location,
                          height: 25.w,
                          width: 25.w,
                          color:
                              cityFocus.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                        ),
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color:
                          cityFocus.hasFocus ? AppColors.primary : Colors.grey,
                      size: 25.sp,
                    ),
                    read: true,
                    onTap: () async {
                      // String? value = await showDialog<String>(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return SimpleDialog(
                      //       backgroundColor: AppColors.borderColor,
                      //       title: AppText(
                      //         text: LocaleKeys.chooseCity.tr(),
                      //         size: 21.sp,
                      //       ),
                      //       children: AppCubit.get(context).citiesList.map(
                      //         (value) {
                      //           return SimpleDialogOption(
                      //             onPressed: () {
                      //               AppCubit.get(context).cityId =
                      //                   value['id'].toString();
                      //               Navigator.pop(context, value['title']);
                      //             },
                      //             child: AppText(
                      //               text: value['title'] ?? "",
                      //               size: 18.sp,
                      //               color: AppColors.primary,
                      //             ),
                      //           );
                      //         },
                      //       ).toList(),
                      //     );
                      //   },
                      // );
                      // if (value != null) {
                      //   widget.cityController.text = value;
                      // }
                    },
                  ),
                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      return AppInput(
                        focusNode: passFocus,
                        filled: true,
                        hint: LocaleKeys.password.tr(),
                        enabledBorderColor: Colors.grey,
                        controller: widget.passController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.passwordValidate.tr();
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: SizedBox(
                          height: 28.w,
                          width: 28.w,
                          child: Center(
                            child: Icon(
                              Icons.lock,
                              color:
                                  passFocus.hasFocus
                                      ? AppColors.primary
                                      : Colors.grey,
                            ),
                          ),
                        ),
                        secureText: AppCubit.get(context).isSecureLogIn,
                        suffixIcon:
                            AppCubit.get(context).isSecureLogIn
                                ? InkWell(
                                  onTap: () {
                                    AppCubit.get(
                                      context,
                                    ).isSecureLogInIcon(false);
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.h),
                                    child: Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                      size: 21.sp,
                                    ),
                                  ),
                                )
                                : InkWell(
                                  onTap: () {
                                    AppCubit.get(
                                      context,
                                    ).isSecureLogInIcon(true);
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.h),
                                    child: Icon(
                                      Icons.visibility,
                                      color: AppColors.primary,
                                      size: 21.sp,
                                    ),
                                  ),
                                ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
