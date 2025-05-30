import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/auth_cubit.dart';
import '../otp/otp.dart';
import '../widgets/auth_header.dart';

final _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();

class AuthConfirmEmail extends StatefulWidget {
  const AuthConfirmEmail({super.key});

  @override
  State<AuthConfirmEmail> createState() => _AuthConfirmEmailState();
}

class _AuthConfirmEmailState extends State<AuthConfirmEmail> {
  final FocusNode emailFocus = FocusNode();
  @override
  void initState() {
    emailFocus.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const CustomAuthHeader(),

              Align(
                alignment: AlignmentDirectional.centerStart,
                child: AppText(
                  text: LocaleKeys.email.tr(),
                  size: 18.sp,
                  color: AppColors.secondray,
                  bottom: 10.h,
                  start: 16.w,
                  family: FontFamily.tajawalBold,
                ),
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
                controller: _emailController,
                inputType: TextInputType.emailAddress,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.yourEmailValidate.tr();
                  } else {
                    return null;
                  }
                },
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ResendCodeFailure) {
                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.error,
                      message: state.error,
                    );
                  } else if (state is ResendCodeSuccess) {
                    AppRouter.navigateAndPop(
                      context,
                      OTPscreen(emailController: _emailController),
                    );

                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.success,
                      message: LocaleKeys.activatedSuccessfully.tr(),
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    top: 32.h,
                    bottom: 29.h,
                    onPressed: () async {
                      AuthCubit.get(
                        context,
                      ).resendCode(email: _emailController.text);
                    },
                    child:
                        state is ResendCodeLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : AppText(
                              text: LocaleKeys.confirm.tr(),
                              color: Colors.white,
                              family: FontFamily.tajawalBold,
                            ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
