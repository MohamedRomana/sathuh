import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class EditNamePhone extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController phoneController;

  const EditNamePhone({
    super.key,
    required this.fullNameController,
    required this.phoneController,
  });

  @override
  State<EditNamePhone> createState() => _EditNamePhoneState();
}

class _EditNamePhoneState extends State<EditNamePhone> {
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  @override
  void initState() {
    lastNameFocus.addListener(() => setState(() {}));
    phoneFocus.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    lastNameFocus.dispose();
    phoneFocus.dispose();
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: LocaleKeys.editprofile.tr()),
                Center(
                  child: AppText(
                    text: LocaleKeys.edit_name_and_phone.tr(),
                    size: 20.sp,
                    color: AppColors.secondray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(height: 16),
                AppText(
                  text: LocaleKeys.username.tr(),
                  size: 16.sp,
                  start: 16.w,
                  fontWeight: FontWeight.bold,
                ),
                AppInput(
                  focusNode: lastNameFocus,
                  top: 16.h,
                  bottom: 16.h,
                  filled: true,
                  enabledBorderColor: Colors.grey,
                  hint: AppCubit.get(context).showProfileMap["userName"] ?? "",
                  controller: widget.fullNameController,
                  prefixIcon: Container(
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

                AppText(
                  text: LocaleKeys.phone.tr(),
                  size: 16.sp,
                  start: 16.w,
                  fontWeight: FontWeight.bold,
                  bottom: 16.h,
                ),

                AppInput(
                  focusNode: phoneFocus,
                  bottom: 16.h,
                  filled: true,
                  enabledBorderColor: Colors.grey,
                  hint: AppCubit.get(context).showProfileMap["phone"] ?? "",
                  controller: widget.phoneController,
                  inputType: TextInputType.phone,
                  prefixIcon: Container(
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
                BlocConsumer<AppCubit, AppState>(
                  listener: (context, state) {
                    if (state is UpdateProfileSuccess) {
                      AppRouter.pop(context);
                      AppRouter.pop(context);

                      showFlashMessage(
                        message: state.message,
                        type: FlashMessageType.success,
                        context: context,
                      );

                      widget.fullNameController.clear();
                      widget.phoneController.clear();
                    } else if (state is UpdateProfileFailure) {
                      showFlashMessage(
                        message: state.error,
                        type: FlashMessageType.error,
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child: AppButton(
                        top: 10.h,
                        onPressed: () async {
                          AppCubit.get(context).updateProfile(
                            userName:
                                widget.fullNameController.text.isEmpty
                                    ? AppCubit.get(
                                      context,
                                    ).showProfileMap["userName"]
                                    : widget.fullNameController.text,

                            phone:
                                widget.phoneController.text.isEmpty
                                    ? AppCubit.get(
                                      context,
                                    ).showProfileMap["phone"]
                                    : widget.phoneController.text,
                          );
                        },
                        child:
                            state is UpdateProfileLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : AppText(
                                  text: LocaleKeys.save.tr(),
                                  color: Colors.white,
                                ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
