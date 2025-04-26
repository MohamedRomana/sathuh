import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/auth_cubit.dart';
import '../widgets/auth_header.dart';

class OTPscreen extends StatelessWidget {
  const OTPscreen({super.key});

  @override
  Widget build(BuildContext context) {
    String otpCode = "";
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const CustomAuthHeader(),
            AppText(
              top: 23.h,
              text: LocaleKeys.enterActivationCode.tr(),
              color: AppColors.fontColor,
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
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is OTPFailure) {
                  showFlashMessage(
                    context: context,
                    type: FlashMessageType.error,
                    message: state.error,
                  );
                } else if (state is OTPSuccess) {
                  // AppCubit.get(context).changebottomNavIndex(2);
                  // AppRouter.navigateAndFinish(context, const HomeLayout());
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
                    await AuthCubit.get(context).otp(code: otpCode);
                  },
                  child:
                      state is OTPLoading
                          ? const CircularProgressIndicator(color: Colors.white)
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
    );
  }
}
