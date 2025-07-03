import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'confirm_email.dart';

class UpdateEmailProfile extends StatefulWidget {
  final TextEditingController emailController;

  const UpdateEmailProfile({super.key, required this.emailController});

  @override
  State<UpdateEmailProfile> createState() => _UpdateEmailProfileState();
}

class _UpdateEmailProfileState extends State<UpdateEmailProfile> {
  final FocusNode emailFocus = FocusNode();

  @override
  void initState() {
    emailFocus.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  dispose() {
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: LocaleKeys.editprofile.tr()),
              Center(
                child: AppText(
                  text: LocaleKeys.change_email.tr(),
                  size: 20.sp,
                  color: AppColors.secondray,
                  fontWeight: FontWeight.bold,
                  bottom: 24.h,
                ),
              ),
              AppText(
                text: LocaleKeys.email.tr(),
                size: 16.sp,
                color: Colors.black,
                family: FontFamily.tajawalBold,
                start: 16.w,
                bottom: 16.h,
              ),
              AppInput(
                focusNode: emailFocus,
                bottom: 16.h,
                filled: true,
                enabledBorderColor: Colors.grey,
                hint: AppCubit.get(context).showProfileMap["email"] ?? "",
                controller: widget.emailController,
                inputType: TextInputType.emailAddress,
                prefixIcon: SizedBox(
                  height: 28.w,
                  width: 28.w,
                  child: Center(
                    child: SvgPicture.asset(
                      height: 28.w,
                      width: 28.w,
                      Assets.svg.drawerSms,
                      color:
                          emailFocus.hasFocus ? AppColors.primary : Colors.grey,
                    ),
                  ),
                ),
              ),
              Center(
                child: BlocConsumer<AppCubit, AppState>(
                  listener: (context, state) {
                    if (state is UpdateProfileSuccess) {
                      AppRouter.navigateAndPop(context, const ConfirmEmail());
                      showFlashMessage(
                        message: state.message,
                        type: FlashMessageType.success,
                        context: context,
                      );
                    } else if (state is UpdateProfileFailure) {
                      showFlashMessage(
                        message: state.error,
                        type: FlashMessageType.error,
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      onPressed: () async {
                        await AppCubit.get(context).updateProfileEmail(
                          email:
                              widget.emailController.text.isEmpty
                                  ? AppCubit.get(
                                    context,
                                  ).showProfileMap["email"]
                                  : widget.emailController.text,
                        );
                      },
                      top: 24.h,
                      child:
                          state is UpdateProfileLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : AppText(
                                text: LocaleKeys.save.tr(),
                                color: Colors.white,
                                family: FontFamily.tajawalBold,
                                size: 21.sp,
                              ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
