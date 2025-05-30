import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

final _formKey = GlobalKey<FormState>();
final _oldPassController = TextEditingController();
final _passController = TextEditingController();
final _confirmPassController = TextEditingController();

class UpdateAdmPass extends StatefulWidget {
  const UpdateAdmPass({super.key});

  @override
  State<UpdateAdmPass> createState() => _UpdateAdmPassState();
}

class _UpdateAdmPassState extends State<UpdateAdmPass>{
  final FocusNode oldPassFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode confirmPassFocus = FocusNode();

  @override
  void initState() {
    oldPassFocus.addListener(() => setState(() {}));
    passFocus.addListener(() => setState(() {}));
    confirmPassFocus.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    oldPassFocus.dispose();
    passFocus.dispose();
    confirmPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminBottomNav(
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
          Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: LocaleKeys.editprofile.tr()),
                Center(
                  child: AppText(
                    text: LocaleKeys.changePassword.tr(),
                    size: 20.sp,
                    color: AppColors.secondray,
                    fontWeight: FontWeight.bold,
                    bottom: 24.h,
                  ),
                ),
                AppText(
                  text: LocaleKeys.old_password.tr(),
                  start: 16.w,
                  bottom: 8.h,
                  color: AppColors.secondray,
                  fontWeight: FontWeight.bold,
                  size: 14.sp,
                ),
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return AppInput(
                      focusNode: oldPassFocus,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 24.sp,
                        color:
                            oldPassFocus.hasFocus
                                ? AppColors.primary
                                : Colors.grey,
                      ),
                      enabledBorderColor: Colors.grey,
                      filled: true,
                      bottom: 16.h,
                      hint: LocaleKeys.old_password.tr(),
                      controller: _oldPassController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.passwordValidate.tr();
                        } else {
                          return null;
                        }
                      },

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
                                  AppCubit.get(context).isSecureLogInIcon(true);
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
                  text: LocaleKeys.new_password.tr(),
                  color: AppColors.secondray,
                  fontWeight: FontWeight.bold,
                  size: 14.sp,
                ),
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return AppInput(
                      focusNode: passFocus,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 24.sp,
                        color:
                            passFocus.hasFocus
                                ? AppColors.primary
                                : Colors.grey,
                      ),
                      enabledBorderColor: Colors.grey,
                      filled: true,
                      bottom: 16.h,
                      hint: LocaleKeys.new_password.tr(),
                      controller: _passController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.passwordValidate.tr();
                        } else {
                          return null;
                        }
                      },

                      secureText: AppCubit.get(context).isSecureRegister1,
                      suffixIcon:
                          AppCubit.get(context).isSecureRegister1
                              ? InkWell(
                                onTap: () {
                                  AppCubit.get(
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
                                  AppCubit.get(
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
                  fontWeight: FontWeight.bold,
                  size: 14.sp,
                ),
                BlocBuilder<AppCubit, AppState>(
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
                      controller: _confirmPassController,
                      validate: (value) {
                        if (_passController.text !=
                            _confirmPassController.text) {
                          return LocaleKeys.passwordDoesNotMatch.tr();
                        } else {
                          return null;
                        }
                      },

                      secureText: AppCubit.get(context).isSecureRegister2,
                      suffixIcon:
                          AppCubit.get(context).isSecureRegister2
                              ? InkWell(
                                onTap: () {
                                  AppCubit.get(
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
                                  AppCubit.get(
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
                Center(
                  child: BlocConsumer<AppCubit, AppState>(
                    listener: (context, state) {
                      if (state is UpdatePasswordSuccess) {
                        Navigator.pop(context);
                        showFlashMessage(
                          message: state.message,
                          type: FlashMessageType.success,
                          context: context,
                        );
                      } else if (state is UpdatePasswordFailure) {
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await AppCubit.get(context).updatePassword(
                              oldPassword: _oldPassController.text,
                              password: _passController.text,
                              confirmPassword: _confirmPassController.text,
                            );
                          }
                        },
                        color: AppColors.primary,
                        child:
                            state is UpdatePasswordLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : AppText(
                                  text: LocaleKeys.update_password.tr(),
                                  size: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
