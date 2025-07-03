import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/driver_bottom_nav.dart';
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
import '../../user_screens/profile/profile.dart';
import '../../user_screens/profile/widgets/delete_account.dart';
import '../profile_edit/profile_driv_edit.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  @override
  void initState() {
    AppCubit.get(context).showProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return DriverBottomNav(
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
                    Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder:
                                  (context) => const CustomEditProfileImage(
                                    type: 'cover',
                                  ),
                            );
                          },
                          child: ClipRRect(
                            child:
                                (AppCubit.get(context)
                                            .showProfileMap['coverImage']
                                            ?.isNotEmpty ??
                                        false)
                                    ? Stack(
                                      children: [
                                        Container(
                                          height: 260.h,
                                          width: double.infinity,
                                          color: Colors.transparent,
                                        ),
                                        AppCachedImage(
                                          image:
                                              AppCubit.get(
                                                context,
                                              ).showProfileMap['coverImage'],
                                          height: 200.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    )
                                    : Stack(
                                      children: [
                                        Container(
                                          height: 260.h,
                                          width: double.infinity,
                                          color: Colors.transparent,
                                        ),
                                        Image.asset(
                                          Assets.img.unphoto.path,
                                          height: 200.h,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder:
                                  (context) => const CustomEditProfileImage(
                                    type: 'image',
                                  ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 150.w,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 3.w,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  child:
                                      (AppCubit.get(context)
                                                  .showProfileMap['image']
                                                  ?.isNotEmpty ??
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
                              PositionedDirectional(
                                start: 15.w,
                                child: Icon(
                                  Icons.edit_square,
                                  color: Colors.red,
                                  size: 25.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
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
                                text: LocaleKeys.email.tr(),
                                size: 16.sp,
                                family: FontFamily.tajawalBold,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onLongPress: () {
                                  // Clipboard.setData(ClipboardData(text: AppCubit.get(context).showProfileMap['email'] ?? ""));
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        insetPadding: EdgeInsets.all(0.r),
                                        backgroundColor: Colors.transparent,
                                        content: Container(
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: AppText(
                                            textAlign: TextAlign.end,
                                            text:
                                                AppCubit.get(
                                                  context,
                                                ).showProfileMap['email'] ??
                                                "",
                                            size: 16.sp,
                                            family: FontFamily.tajawalBold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: SizedBox(
                                  width: 190.w,
                                  child: AppText(
                                    textAlign: TextAlign.end,
                                    text:
                                        AppCubit.get(
                                          context,
                                        ).showProfileMap['email'] ??
                                        "",
                                    size: 16.sp,
                                    family: FontFamily.tajawalBold,
                                    color: Colors.grey,
                                  ),
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
                        AppRouter.navigateTo(
                          context,
                          const ProfileDrivEditFields(),
                        );
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
                        AppRouter.navigateTo(context, const DeleteAccount());
                      },
                      color: AppColors.secondray,
                      child: AppText(
                        text: LocaleKeys.deleteAccount.tr(),
                        color: Colors.white,
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
