import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../auth/views/login/login.dart';

final _formKey = GlobalKey<FormState>();
final _phoneController = TextEditingController();
final _passController = TextEditingController();

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final FocusNode phoneFocusNode1 = FocusNode();
  final FocusNode passFocusNode1 = FocusNode();
  @override
  void initState() {
    phoneFocusNode1.addListener(() => setState(() {}));
    passFocusNode1.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    phoneFocusNode1.dispose();
    passFocusNode1.dispose();
    super.dispose();
  }

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
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: LocaleKeys.deleteAccount.tr()),
                AppText(
                  start: 32.w,
                  bottom: 8.h,
                  text: LocaleKeys.phone.tr(),
                  color: Colors.black,
                  size: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                AppInput(
                  focusNode: phoneFocusNode1,
                  bottom: 16.h,
                  filled: true,
                  enabledBorderColor: Colors.grey,
                  hint: LocaleKeys.phone.tr(),
                  color: Colors.white,
                  controller: _phoneController,
                  inputType: TextInputType.phone,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.yourEmailValidate.tr();
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    size: 24.sp,
                    color:
                        phoneFocusNode1.hasFocus
                            ? AppColors.primary
                            : Colors.grey,
                  ),
                ),
                AppText(
                  start: 32.w,
                  bottom: 8.h,
                  text: LocaleKeys.password.tr(),
                  color: Colors.black,
                  size: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return AppInput(
                      focusNode: passFocusNode1,
                      enabledBorderColor: Colors.grey,
                      filled: true,
                      hint: LocaleKeys.password.tr(),
                      controller: _passController,
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
                            passFocusNode1.hasFocus
                                ? AppColors.primary
                                : Colors.grey,
                      ),
                      secureText: AppCubit.get(context).isSecureDelete,
                      suffixIcon:
                          AppCubit.get(context).isSecureDelete
                              ? InkWell(
                                onTap: () {
                                  AppCubit.get(
                                    context,
                                  ).isSecureDeleteIcon(false);
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
                                  ).isSecureDeleteIcon(true);
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
                      if (state is DeleteProfileSuccess) {
                        CacheHelper.setUserType('client');
                        AppRouter.navigateAndFinish(context, const LogIn());

                        showFlashMessage(
                          message: state.message,
                          type: FlashMessageType.success,
                          context: context,
                        );
                      } else if (state is DeleteProfileFailure) {
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
                            AppCubit.get(context).deleteProfile(
                              phone: _phoneController.text,
                              password: _passController.text,
                            );
                          }
                        },
                        child:
                            state is DeleteProfileLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : AppText(
                                  text: LocaleKeys.deleteAccount.tr(),
                                  color: Colors.white,
                                  size: 21.sp,
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
