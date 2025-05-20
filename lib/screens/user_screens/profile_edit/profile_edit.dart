// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/edit_profile_fields.dart';

final _formKey = GlobalKey<FormState>();
final _firstNameController = TextEditingController();
final _lastNameController = TextEditingController();
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
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passController.clear();
    _cityController.clear();
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
                          SizedBox(
                            height: 300.h,
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    AppCubit.get(
                                          context,
                                        ).profileCoverImage.isEmpty
                                        ? InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap:
                                              () => AppCubit.get(
                                                context,
                                              ).getProfileCoverImage(context),
                                          child: Image.asset(
                                            Assets.img.bmw.path,
                                          ),
                                        )
                                        : InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap:
                                              () =>
                                                  AppCubit.get(
                                                    context,
                                                  ).removeProfileCoverImage(),
                                          child: Image.file(
                                            AppCubit.get(
                                              context,
                                            ).profileCoverImage.first,
                                            height: 200.h,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                  ],
                                ),
                                PositionedDirectional(
                                  bottom: 40.h,
                                  start: 120.w,
                                  child: Column(
                                    children: [
                                      AppCubit.get(context).profileImage.isEmpty
                                          ? InkWell(
                                            onTap:
                                                () => AppCubit.get(
                                                  context,
                                                ).getProfileImage(context),
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                      width: 3.w,
                                                    ),
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          100.r,
                                                        ),
                                                    child: Image.asset(
                                                      Assets.img.client.path,
                                                      height: 120.h,
                                                      width: 120.w,
                                                    ),
                                                  ),
                                                ),
                                                PositionedDirectional(
                                                  end: 0,
                                                  child: Icon(
                                                    Icons.edit_square,
                                                    color: AppColors.primary,
                                                    size: 25.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          : Stack(
                                            children: [
                                              Container(
                                                height: 120.h,
                                                width: 120.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      AppCubit.get(
                                                        context,
                                                      ).profileImage.first,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              PositionedDirectional(
                                                child: InkWell(
                                                  onTap:
                                                      () =>
                                                          AppCubit.get(
                                                            context,
                                                          ).removeProfileImage(),
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  child: Icon(
                                                    Icons.cancel,
                                                    color: Colors.red,
                                                    size: 25.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          EditProfileFields(
                            passController: _passController,
                            phoneController: _phoneController,
                            firstNameController: _firstNameController,
                            lastNameController: _lastNameController,
                            cityController: _cityController,
                            emailController: _emailController,
                          ),
                          BlocConsumer<AppCubit, AppState>(
                            listener: (context, state) {
                              if (state is UpdateUserSuccess) {
                                AppRouter.pop(context);
                                showFlashMessage(
                                  message: state.message,
                                  type: FlashMessageType.success,
                                  context: context,
                                );
                                _firstNameController.clear();
                                _lastNameController.clear();
                                _phoneController.clear();
                                _emailController.clear();
                                _cityController.clear();
                                _passController.clear();
                              } else if (state is UpdateUserFailure) {
                                showFlashMessage(
                                  message: state.error,
                                  type: FlashMessageType.error,
                                  context: context,
                                );
                              }
                            },
                            builder: (context, state) {
                              return AppButton(
                                top: 10.h,
                                onPressed: () {
                                  // AppCubit.get(context).updateUser(
                                  //   password: _passController.text,
                                  //   firstName: _firstNameController.text.isEmpty
                                  //       ? AppCubit.get(context)
                                  //           .showUserMap["first_name"]
                                  //       : _firstNameController.text,
                                  //   lastName: _lastNameController.text.isEmpty
                                  //       ? AppCubit.get(context)
                                  //           .showUserMap["last_name"]
                                  //       : _lastNameController.text,
                                  //   phone: _phoneController.text.isEmpty
                                  //       ? AppCubit.get(context).showUserMap["phone"]
                                  //       : _phoneController.text,
                                  // );
                                },
                                child: AppText(
                                  text: LocaleKeys.save.tr(),
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 150.h),
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
