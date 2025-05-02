import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../home_layout/home_layout.dart';

// final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _phoneController = TextEditingController();
final _messageController = TextEditingController();

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();

  @override
  void initState() {
    AppCubit.get(context).drawerIndex = 3;
    super.initState();
    phoneFocusNode.addListener(() => setState(() {}));
    nameFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.h),
            child: CustomAppBar(title: LocaleKeys.contactUs.tr()),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 45.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 208.h,
                      child: TweenAnimationBuilder(
                        curve: Curves.fastOutSlowIn,
                        tween: Tween<double>(begin: 0, end: 208.w),
                        duration: const Duration(seconds: 1),
                        builder:
                            (context, value, child) => Center(
                              child: SizedBox(
                                height: value.h,
                                width: value.w,
                                child: Image.asset(
                                  Assets.img.logo.path,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    AppInput(
                      filled: true,
                      bottom: 16.h,
                      focusNode: nameFocusNode,
                      color: const Color(0xffFBFBFB),
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: AppColors.primary,
                      hint: LocaleKeys.fullName.tr(),
                      start: 0,
                      end: 0,
                      controller: _nameController,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: SvgPicture.asset(
                          Assets.svg.user,
                          color:
                              nameFocusNode.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                        ),
                      ),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.nameValidate.tr();
                        } else {
                          return null;
                        }
                      },
                    ),

                    AppInput(
                      bottom: 16.h,
                      filled: true,
                      focusNode: phoneFocusNode,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: SvgPicture.asset(
                          Assets.svg.phone,
                          color:
                              phoneFocusNode.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                        ),
                      ),

                      color: const Color(0xffFBFBFB),
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: AppColors.primary,
                      hint: LocaleKeys.phone.tr(),
                      start: 0,
                      end: 0,
                      controller: _phoneController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.phoneValidate.tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    AppInput(
                      filled: true,
                      color: const Color(0xffFBFBFB),
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: AppColors.primary,
                      hint: LocaleKeys.yourMessage.tr(),
                      maxLines: 5,
                      start: 0,
                      end: 0,
                      controller: _messageController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.yourMessage.tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    BlocConsumer<AppCubit, AppState>(
                      listener: (context, state) {
                        if (state is ContactUsSuccess) {
                          AppCubit.get(context).changebottomNavIndex(0);
                          AppRouter.navigateAndFinish(
                            context,
                            const HomeLayout(),
                          );
                          _nameController.clear();
                          _phoneController.clear();
                          _messageController.clear();
                          showFlashMessage(
                            message: state.message,
                            type: FlashMessageType.success,
                            context: context,
                          );
                        } else if (state is ContactUsFailure) {
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
                          color: AppColors.secondray,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await AppCubit.get(context).contactUs(
                                name: _nameController.text,
                                phone: _phoneController.text,
                                message: _messageController.text,
                              );
                            }
                          },
                          width: 343.w,
                          child:
                              state is ContactUsLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : AppText(
                                    text: LocaleKeys.send.tr(),
                                    color: Colors.white,
                                    family: FontFamily.tajawalBold,
                                    size: 20.sp,
                                  ),
                        );
                      },
                    ),
                    SizedBox(height: 120.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
