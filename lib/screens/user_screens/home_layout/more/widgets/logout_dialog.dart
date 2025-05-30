import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_lottie_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../auth/data/auth_cubit.dart';
import '../../../../auth/views/login/login.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomLottieWidget(
          height: 90.w,
          width: 90.w,
          lottieName: Assets.img.alert,
        ),
        AppText(
          text: LocaleKeys.logout.tr(),
          size: 20.sp,
          color: AppColors.primary,
          family: FontFamily.tajawalBold,
        ),
        AppText(
          top: 16.h,
          bottom: 16.h,
          text: LocaleKeys.logOutSubtitle.tr(),
          size: 20.sp,
          color: AppColors.primary,
          family: FontFamily.tajawalBold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                AppRouter.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(90.w, 40.h),
              ),
              child: AppText(
                text: LocaleKeys.cancel.tr(),
                color: Colors.white,
                family: FontFamily.tajawalBold,
                size: 18.sp,
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LogOutSuccess) {
                  AppRouter.navigateAndFinish(context, const LogIn());
                  showFlashMessage(
                    message: state.message,
                    type: FlashMessageType.success,
                    context: context,
                  );
                } else if (state is LogOutFailure) {
                  showFlashMessage(
                    message: state.error,
                    type: FlashMessageType.error,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    AuthCubit.get(context).logOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(90.w, 40.h),
                  ),
                  child:
                      state is LogOutLoading
                          ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : AppText(
                            text: LocaleKeys.yes.tr(),
                            color: Colors.white,
                            family: FontFamily.tajawalBold,
                            size: 18.sp,
                          ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
