import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';

import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../auth/views/login/login.dart';

class ConfirmAdmEmail extends StatefulWidget {
  const ConfirmAdmEmail({super.key});

  @override
  State<ConfirmAdmEmail> createState() => _ConfirmAdmEmailState();
}

class _ConfirmAdmEmailState extends State<ConfirmAdmEmail> {
  String otpCode = "";

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
          Column(
            children: [
              CustomAppBar(title: LocaleKeys.editprofile.tr()),
              AppText(
                top: 23.h,
                text: LocaleKeys.enterActivationCodeEmail.tr(),
                color: AppColors.secondray,
                bottom: 32.h,
                family: FontFamily.tajawalBold,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  cursorColor: AppColors.primary,
                  textStyle: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10.r),
                    fieldHeight: 60.h,
                    fieldWidth: 60.h,
                    activeColor: Colors.white,
                    inactiveColor: AppColors.primary,
                    inactiveFillColor: Colors.white,
                    activeFillColor: AppColors.primary,
                    selectedColor: AppColors.primary,
                    selectedFillColor: Colors.transparent,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (code) {
                    otpCode = code;
                    debugPrint("Completed");
                  },
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
              ),
              BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (state is OTPEmailFailure) {
                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.error,
                      message: state.error,
                    );
                  } else if (state is OTPEmailSuccess) {
                    CacheHelper.setUserType('administration');
                    AppRouter.navigateAndFinish(context, const LogIn());
                    otpCode = "";
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
                      AppCubit.get(context).otpEmail(code: otpCode);
                    },
                    child:
                        state is OTPEmailLoading
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
        ],
      ),
    );
  }
}
