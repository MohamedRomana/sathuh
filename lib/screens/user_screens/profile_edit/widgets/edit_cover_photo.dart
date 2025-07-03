import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_cached.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class EditCoverPhoto extends StatefulWidget {
  const EditCoverPhoto({super.key});

  @override
  State<EditCoverPhoto> createState() => _EditCoverPhotoState();
}

class _EditCoverPhotoState extends State<EditCoverPhoto> {
  @override
  void initState() {
    AppCubit.get(context).profileImage.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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

              Center(
                child: Column(
                  children: [
                    CustomAppBar(title: LocaleKeys.editprofile.tr()),
                    AppText(
                      text: LocaleKeys.edit_cover_picture.tr(),
                      size: 20.sp,
                      color: Colors.black,
                      family: FontFamily.tajawalBold,
                      bottom: 24.h,
                    ),
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
                                  borderRadius: BorderRadius.circular(15.r),
                                  child:
                                      (AppCubit.get(context)
                                                  .showProfileMap['coverImage']
                                                  ?.isNotEmpty ??
                                              false)
                                          ? AppCachedImage(
                                            image:
                                                AppCubit.get(
                                                  context,
                                                ).showProfileMap['coverImage'],
                                            height: 190.w,
                                            width: 343.w,
                                            fit: BoxFit.cover,
                                          )
                                          : Image.asset(
                                            Assets.img.unphoto.path,
                                            height: 190.w,
                                            width: 343.w,
                                            fit: BoxFit.cover,
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
                              height: 190.w,
                              width: 343.w,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15.r),
                                image: DecorationImage(
                                  image: FileImage(
                                    AppCubit.get(context).profileImage.first,
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
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 25.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                    BlocConsumer<AppCubit, AppState>(
                      listener: (context, state) {
                        if (state is UploadProfileImageSuccess) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          AppCubit.get(context).profileImage.clear();
                          showFlashMessage(
                            message: state.message,
                            type: FlashMessageType.success,
                            context: context,
                          );
                        } else if (state is UploadProfileImageFailure) {
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
                          onPressed: () {
                            AppCubit.get(context).uploadProfileImage(
                              AppCubit.get(context).profileImage.first,
                              type: 'cover',
                            );
                          },
                          child:
                              state is UploadProfileImageLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : AppText(
                                    text: LocaleKeys.save.tr(),
                                    size: 21.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
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
      },
    );
  }
}
