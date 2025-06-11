// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/edit_cover_photo.dart';
import 'widgets/edit_name_phone.dart';
import 'widgets/edit_profile_photo.dart';
import 'widgets/update_email_profile.dart';
import 'widgets/update_password.dart';

final _formKey = GlobalKey<FormState>();
final _fullNameController = TextEditingController();
final _emailController = TextEditingController();
final _phoneController = TextEditingController();
final _passController = TextEditingController();
final _cityController = TextEditingController();

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  void initState() {
    _fullNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passController.clear();
    _cityController.clear();
    AppCubit.get(context).showProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          body: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return Stack(
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomAppBar(title: LocaleKeys.editprofile.tr()),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              AppRouter.navigateTo(
                                context,
                                const EditProfilePhoto(),
                              );
                            },
                            child: Container(
                              width: 343.w,
                              padding: EdgeInsets.all(16.r),
                              margin: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.w,
                                ),
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
                                  AppText(
                                    text: LocaleKeys.edit_profile_picture.tr(),
                                    size: 20.sp,
                                    color: AppColors.secondray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                           InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              AppRouter.navigateTo(
                                context,
                                const EditCoverPhoto(),
                              );
                            },
                            child: Container(
                              width: 343.w,
                              padding: EdgeInsets.all(16.r),
                              margin: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.w,
                                ),
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
                                  AppText(
                                    text: LocaleKeys.edit_cover_picture.tr(),
                                    size: 20.sp,
                                    color: AppColors.secondray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              AppRouter.navigateTo(
                                context,
                                EditNamePhone(
                                  fullNameController: _fullNameController,
                                  phoneController: _phoneController,
                                ),
                              );
                            },
                            child: Container(
                              width: 343.w,
                              padding: EdgeInsets.all(16.r),
                              margin: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.w,
                                ),
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
                                  AppText(
                                    text: LocaleKeys.edit_name_and_phone.tr(),
                                    size: 20.sp,
                                    color: AppColors.secondray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              AppRouter.navigateTo(
                                context,
                                UpdateEmailProfile(
                                  emailController: _emailController,
                                ),
                              );
                            },
                            child: Container(
                              width: 343.w,
                              padding: EdgeInsets.all(16.r),
                              margin: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.w,
                                ),
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
                                  AppText(
                                    text: LocaleKeys.change_email.tr(),
                                    size: 20.sp,
                                    color: AppColors.secondray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              AppRouter.navigateTo(
                                context,
                                const UpdatePassword(),
                              );
                            },
                            child: Container(
                              width: 343.w,
                              padding: EdgeInsets.all(16.r),
                              margin: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.w,
                                ),
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
                                  AppText(
                                    text: LocaleKeys.changePassword.tr(),
                                    size: 20.sp,
                                    color: AppColors.secondray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(height: 150.h),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
