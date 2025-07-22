import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import 'package:sathuh/core/widgets/app_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_cached.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'profile_edit/profile_edit.dart';
import 'widgets/delete_admin_profile.dart';

final _controller = TextEditingController();
final _formKey = GlobalKey<FormState>();

class AdmProfile extends StatefulWidget {
  const AdmProfile({super.key});

  @override
  State<AdmProfile> createState() => _AdmProfileState();
}

class _AdmProfileState extends State<AdmProfile> {
  @override
  void initState() {
    AppCubit.get(context).showProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CustomAppBar(title: LocaleKeys.profile.tr()),
                    Container(
                      height: 150.w,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 3.w),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child:
                            (AppCubit.get(
                                      context,
                                    ).showProfileMap['image']?.isNotEmpty ??
                                    false)
                                ? AppCachedImage(
                                  image:
                                      AppCubit.get(
                                        context,
                                      ).showProfileMap['image'],
                                  fit: BoxFit.cover,
                                )
                                : Image.asset(
                                  Assets.img.unphoto.path,
                                  fit: BoxFit.cover,
                                ),
                      ),
                    ),
                    Container(height: 30.h),
                    Container(
                      width: 343.w,
                      padding: EdgeInsets.all(16.r),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.r,
                            spreadRadius: 1.r,
                            offset: Offset(0, 5.r),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              AppText(
                                text: LocaleKeys.name.tr(),
                                size: 16.sp,
                                family: FontFamily.tajawalBold,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 180.w,
                                child: AppText(
                                  textAlign: TextAlign.end,
                                  text:
                                      AppCubit.get(
                                        context,
                                      ).showProfileMap['userName'] ??
                                      "",
                                  size: 16.sp,
                                  family: FontFamily.tajawalBold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 8.h),
                          const Divider(color: Colors.grey),
                          Container(height: 8.h),
                          Row(
                            children: [
                              AppText(
                                text: LocaleKeys.phone.tr(),
                                size: 16.sp,
                                family: FontFamily.tajawalBold,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 180.w,
                                child: AppText(
                                  textAlign: TextAlign.end,
                                  text:
                                      AppCubit.get(
                                        context,
                                      ).showProfileMap['phone'] ??
                                      "",
                                  size: 16.sp,
                                  color: Colors.blue,
                                  family: FontFamily.tajawalBold,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 8.h),
                          const Divider(color: Colors.grey),
                          Container(height: 8.h),

                          Row(
                            children: [
                              AppText(
                                text: LocaleKeys.email.tr(),
                                size: 16.sp,
                                family: FontFamily.tajawalBold,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 190.w,
                                child: AppText(
                                  textAlign: TextAlign.end,
                                  text:
                                      AppCubit.get(
                                        context,
                                      ).showProfileMap['email'] ??
                                      "",
                                  size: 12.sp,
                                  family: FontFamily.tajawalBold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 8.h),
                          const Divider(color: Colors.grey),
                          Container(height: 8.h),
                          Row(
                            children: [
                              AppText(
                                text: LocaleKeys.country.tr(),
                                size: 16.sp,
                                family: FontFamily.tajawalBold,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 180.w,
                                child: AppText(
                                  textAlign: TextAlign.end,
                                  text:
                                      AppCubit.get(
                                                    context,
                                                  ).showProfileMap['address'] !=
                                                  null &&
                                              AppCubit.get(
                                                    context,
                                                  ).showProfileMap['address']['country'] !=
                                                  null
                                          ? AppCubit.get(
                                            context,
                                          ).showProfileMap['address']['country']
                                          : "",
                                  size: 16.sp,
                                  color: Colors.grey,
                                  family: FontFamily.tajawalBold,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 8.h),
                          const Divider(color: Colors.grey),
                          Container(height: 8.h),
                          Row(
                            children: [
                              AppText(
                                text: LocaleKeys.city.tr(),
                                size: 16.sp,
                                family: FontFamily.tajawalBold,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 180.w,
                                child: AppText(
                                  textAlign: TextAlign.end,
                                  text:
                                      AppCubit.get(
                                                    context,
                                                  ).showProfileMap['address'] !=
                                                  null &&
                                              AppCubit.get(
                                                    context,
                                                  ).showProfileMap['address']['city'] !=
                                                  null
                                          ? AppCubit.get(
                                            context,
                                          ).showProfileMap['address']['city']
                                          : "",
                                  size: 16.sp,
                                  color: Colors.grey,
                                  family: FontFamily.tajawalBold,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 8.h),
                          const Divider(color: Colors.grey),
                          Container(height: 8.h),
                          Row(
                            children: [
                              AppText(
                                text: LocaleKeys.area.tr(),
                                size: 16.sp,
                                family: FontFamily.tajawalBold,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 180.w,
                                child: AppText(
                                  textAlign: TextAlign.end,
                                  text:
                                      AppCubit.get(
                                                    context,
                                                  ).showProfileMap['address'] !=
                                                  null &&
                                              AppCubit.get(
                                                    context,
                                                  ).showProfileMap['address']['area'] !=
                                                  null
                                          ? AppCubit.get(
                                            context,
                                          ).showProfileMap['address']['area']
                                          : "",
                                  size: 16.sp,
                                  color: Colors.grey,
                                  family: FontFamily.tajawalBold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppButton(
                      top: 24.h,
                      onPressed: () {
                        AppRouter.navigateTo(context, const ProfileEditAdmin());
                      },
                      child: AppText(
                        text: LocaleKeys.editprofile.tr(),
                        color: Colors.white,
                        family: FontFamily.tajawalBold,
                        size: 21.sp,
                      ),
                    ),
                    AppButton(
                      top: 24.h,
                      onPressed: () {
                        AppRouter.navigateTo(
                          context,
                          const DeleteAdminProfile(),
                        );
                      },
                      color: AppColors.secondray,
                      child: AppText(
                        text: LocaleKeys.deleteAccount.tr(),
                        color: Colors.white,
                        family: FontFamily.tajawalBold,
                        size: 21.sp,
                      ),
                    ),
                    AppButton(
                      top: 24.h,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder:
                              (context) => ChangeWhatsAppNumber(
                                controller: _controller,
                                formKey: _formKey,
                              ),
                        );
                      },
                      color: AppColors.third,
                      child: AppText(
                        text: 'تغيير رقم الواتساب',
                        color: Colors.black,
                        family: FontFamily.tajawalBold,
                        size: 21.sp,
                      ),
                    ),
                    Container(height: 124.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChangeWhatsAppNumber extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  const ChangeWhatsAppNumber({
    super.key,
    required this.controller,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 500.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.secondray,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  Assets.img.logo.path,
                  height: 200.w,
                  width: 200.w,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: LocaleKeys.phone.tr(),
                      color: Colors.white,
                      family: FontFamily.tajawalBold,
                      bottom: 16.h,
                      start: 16.w,
                    ),
                    AppInput(
                      filled: true,
                      color: AppColors.third,
                      bottom: 30.h,
                      hint: LocaleKeys.phone.tr(),
                      controller: controller,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.phoneValidate.tr();
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                AppButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString(
                        'whatsapp_number',
                        controller.text.trim(),
                      );
                      Navigator.pop(context);
                    }
                  },
                  width: 300.w,
                  child: AppText(
                    text: LocaleKeys.save.tr(),
                    size: 18.sp,
                    color: Colors.white,
                    family: FontFamily.tajawalBold,
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String?> getWhatsAppNumber() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('whatsapp_number');
}
