import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../data/auth_cubit.dart';

class CustomUserRegisterFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController townController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;

  const CustomUserRegisterFields({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.passController,
    required this.confirmPassController,
    required this.emailController,
    required this.fullNameController,
    required this.countryController,
    required this.cityController,
    required this.townController,
  });

  @override
  State<CustomUserRegisterFields> createState() =>
      _CustomUserRegisterFieldsState();
}

class _CustomUserRegisterFieldsState extends State<CustomUserRegisterFields> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode townFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode confirmPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    nameFocus.addListener(() => setState(() {}));
    phoneFocus.addListener(() => setState(() {}));
    emailFocus.addListener(() => setState(() {}));
    countryFocus.addListener(() => setState(() {}));
    cityFocus.addListener(() => setState(() {}));
    townFocus.addListener(() => setState(() {}));
    passFocus.addListener(() => setState(() {}));
    confirmPassFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    countryFocus.dispose();
    cityFocus.dispose();
    townFocus.dispose();
    passFocus.dispose();
    confirmPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: AppText(
                  bottom: 35.h,
                  text: LocaleKeys.create_new_account.tr(),
                  size: 24.sp,
                  color: AppColors.secondray,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppText(
                start: 16.w,
                bottom: 8.h,
                text: LocaleKeys.username.tr(),
                color: AppColors.secondray,
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              AppInput(
                focusNode: nameFocus,
                prefixIcon: Icon(
                  Icons.person_outline,
                  size: 24.sp,
                  color: nameFocus.hasFocus ? AppColors.primary : Colors.grey,
                ),
                enabledBorderColor: Colors.grey,
                bottom: 16.h,
                filled: true,
                hint: LocaleKeys.fullName.tr(),
                controller: widget.fullNameController,
                inputType: TextInputType.name,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.usernameValidate.tr();
                  } else {
                    return null;
                  }
                },
              ),
              AppText(
                start: 16.w,
                bottom: 8.h,
                text: LocaleKeys.phone.tr(),
                color: AppColors.secondray,
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              AppInput(
                focusNode: phoneFocus,
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  size: 24.sp,
                  color: phoneFocus.hasFocus ? AppColors.primary : Colors.grey,
                ),
                enabledBorderColor: Colors.grey,
                bottom: 16.h,
                filled: true,
                hint: LocaleKeys.phone.tr(),
                controller: widget.phoneController,
                inputType: TextInputType.phone,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.phoneValidate.tr();
                  } else {
                    return null;
                  }
                },
              ),
              AppText(
                start: 16.w,
                bottom: 8.h,
                text: LocaleKeys.email.tr(),
                color: AppColors.secondray,
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              AppInput(
                focusNode: emailFocus,
                enabledBorderColor: Colors.grey,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 24.sp,
                  color: emailFocus.hasFocus ? AppColors.primary : Colors.grey,
                ),
                bottom: 16.h,
                filled: true,
                hint: LocaleKeys.email.tr(),
                controller: widget.emailController,
                inputType: TextInputType.emailAddress,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.yourEmailValidate.tr();
                  } else {
                    return null;
                  }
                },
              ),
              AppText(
                start: 16.w,
                bottom: 8.h,
                text: 'الدوله',
                color: AppColors.secondray,
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              AppInput(
                focusNode: countryFocus,
                enabledBorderColor: Colors.grey,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 24.sp,
                  color:
                      countryFocus.hasFocus ? AppColors.primary : Colors.grey,
                ),
                bottom: 16.h,
                filled: true,
                hint: 'الدوله',
                controller: widget.countryController,
                inputType: TextInputType.emailAddress,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'ادخل الدوله';
                  } else {
                    return null;
                  }
                },
              ),
              AppText(
                start: 16.w,
                bottom: 8.h,
                text: 'المدينه',
                color: AppColors.secondray,
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              AppInput(
                focusNode: cityFocus,
                enabledBorderColor: Colors.grey,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 24.sp,
                  color: cityFocus.hasFocus ? AppColors.primary : Colors.grey,
                ),
                bottom: 16.h,
                filled: true,
                hint: 'المدينه',
                controller: widget.cityController,
                inputType: TextInputType.emailAddress,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'ادخل المدينه';
                  } else {
                    return null;
                  }
                },
              ),
              AppText(
                start: 16.w,
                bottom: 8.h,
                text: 'المنطقه',
                color: AppColors.secondray,
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              AppInput(
                focusNode: townFocus  ,
                enabledBorderColor: Colors.grey,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 24.sp,
                  color: townFocus  .hasFocus ? AppColors.primary : Colors.grey,
                ),
                bottom: 16.h,
                filled: true,
                hint: 'المنطقه',
                controller: widget.townController,
                inputType: TextInputType.emailAddress,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'ادخل المنطقه';
                  } else {
                    return null;
                  }
                },
              ),
              AppText(
                start: 16.w,
                bottom: 8.h,
                text: LocaleKeys.password.tr(),
                color: AppColors.secondray,
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return AppInput(
                    focusNode: passFocus,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 24.sp,
                      color:
                          passFocus.hasFocus ? AppColors.primary : Colors.grey,
                    ),
                    enabledBorderColor: Colors.grey,
                    filled: true,
                    bottom: 16.h,
                    hint: LocaleKeys.password.tr(),
                    controller: widget.passController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.passwordValidate.tr();
                      } else {
                        return null;
                      }
                    },

                    secureText: AuthCubit.get(context).isSecureRegister1,
                    suffixIcon:
                        AuthCubit.get(context).isSecureRegister1
                            ? InkWell(
                              onTap: () {
                                AuthCubit.get(
                                  context,
                                ).isSecureRegisterIcon1(false);
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
                                AuthCubit.get(
                                  context,
                                ).isSecureRegisterIcon1(true);
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
              AppText(
                start: 16.w,
                bottom: 8.h,
                text: LocaleKeys.confirmPassword.tr(),
                color: AppColors.secondray,
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return AppInput(
                    focusNode: confirmPassFocus,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 24.sp,
                      color:
                          confirmPassFocus.hasFocus
                              ? AppColors.primary
                              : Colors.grey,
                    ),
                    enabledBorderColor: Colors.grey,
                    filled: true,
                    hint: LocaleKeys.confirmPassword.tr(),
                    controller: widget.confirmPassController,
                    validate: (value) {
                      if (widget.passController.text !=
                          widget.confirmPassController.text) {
                        return LocaleKeys.passwordDoesNotMatch.tr();
                      } else {
                        return null;
                      }
                    },

                    secureText: AuthCubit.get(context).isSecureRegister2,
                    suffixIcon:
                        AuthCubit.get(context).isSecureRegister2
                            ? InkWell(
                              onTap: () {
                                AuthCubit.get(
                                  context,
                                ).isSecureRegisterIcon2(false);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(8.h),
                                child: Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.grey,
                                  size: 21.sp,
                                ),
                              ),
                            )
                            : InkWell(
                              onTap: () {
                                AuthCubit.get(
                                  context,
                                ).isSecureRegisterIcon2(true);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(8.h),
                                child: Icon(
                                  Icons.visibility_outlined,
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
        );
      },
    );
  }
}
