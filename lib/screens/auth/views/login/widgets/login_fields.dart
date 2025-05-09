import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/gen/fonts.gen.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../data/auth_cubit.dart';

class CustomLoginFields extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController passController;
  final GlobalKey<FormState> formKey;

  const CustomLoginFields({
    super.key,
    required this.phoneController,
    required this.passController,
    required this.formKey,
  });

  @override
  State<CustomLoginFields> createState() => _CustomLoginFieldsState();
}

class _CustomLoginFieldsState extends State<CustomLoginFields> {
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(() => setState(() {}));
    passFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: AppText(
              bottom: 25.h,
              text: LocaleKeys.login.tr(),
              size: 24.sp,
              family: FontFamily.tajawalBold,
              color: AppColors.secondray,
            ),
          ),
          AppText(
            start: 32.w,
            bottom: 8.h,
            text: LocaleKeys.phone.tr(),
            color: Colors.black,
            size: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          AppInput(
            focusNode: phoneFocusNode,
            bottom: 16.h,
            filled: true,
            enabledBorderColor: Colors.grey,
            hint: LocaleKeys.email.tr(),
            color: Colors.white,
            controller: widget.phoneController,
            inputType: TextInputType.emailAddress,
            validate: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.yourEmailValidate.tr();
              } else {
                return null;
              }
            },
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 24.sp,
              color: phoneFocusNode.hasFocus ? AppColors.primary : Colors.grey,
            ),
          ),
          AppText(
            start: 32.w,
            bottom: 8.h,
            text: LocaleKeys.password.tr(),
            color: Colors.black,
            size: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return AppInput(
                focusNode: passFocusNode,
                enabledBorderColor: Colors.grey,
                filled: true,
                hint: LocaleKeys.password.tr(),
                controller: widget.passController,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.passwordValidate.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.lock_outlined,
                  size: 24.sp,
                  color:
                      passFocusNode.hasFocus ? AppColors.primary : Colors.grey,
                ),
                secureText: AuthCubit.get(context).isSecureLogIn,
                suffixIcon:
                    AuthCubit.get(context).isSecureLogIn
                        ? InkWell(
                          onTap: () {
                            AuthCubit.get(context).isSecureLogInIcon(false);
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
                            AuthCubit.get(context).isSecureLogInIcon(true);
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
  }
}
