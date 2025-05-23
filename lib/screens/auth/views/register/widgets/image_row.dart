import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../data/auth_cubit.dart';

class ImageRow extends StatelessWidget {
  const ImageRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                AppText(
                  top: 10.h,
                  text: LocaleKeys.identityImage.tr(),
                  size: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                SizedBox(height: 10.h),
                AuthCubit.get(context).identityImage.isNotEmpty
                    ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Container(
                            height: 90.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  AuthCubit.get(context).identityImage.first,
                                ),
                              ),
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
                          child: InkWell(
                            onTap: () {
                              AuthCubit.get(context).removeIdentityImage();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: const Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                      ],
                    )
                    : InkWell(
                      onTap: () {
                        AuthCubit.get(context).getIdentityImage();
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10.r),
                        color: Colors.grey,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: SizedBox(
                            height: 90.h,
                            width: 90.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey,
                                ),
                                AppText(
                                  text: LocaleKeys.attach_photo.tr(),
                                  size: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
            Column(
              children: [
                AppText(
                  top: 10.h,
                  text: LocaleKeys.licenseImage.tr(),
                  size: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                SizedBox(height: 10.h),
                AuthCubit.get(context).licenseImage.isNotEmpty
                    ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Container(
                            height: 90.h,
                            width: 90.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  AuthCubit.get(context).licenseImage.first,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
                          child: InkWell(
                            onTap: () {
                              AuthCubit.get(context).removeLicenseImage();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: const Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                      ],
                    )
                    : InkWell(
                      onTap: () {
                        AuthCubit.get(context).getLicenseImage();
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10.r),
                        color: Colors.grey,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: SizedBox(
                            height: 90.h,
                            width: 90.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey,
                                ),
                                AppText(
                                  text: LocaleKeys.attach_photo.tr(),
                                  size: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
            Column(
              children: [
                AppText(
                  top: 10.h,
                  text: LocaleKeys.carImage.tr(),
                  size: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                SizedBox(height: 10.h),
                AuthCubit.get(context).carImage.isNotEmpty
                    ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Container(
                            height: 90.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  AuthCubit.get(context).carImage.first,
                                ),
                              ),
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
                          child: InkWell(
                            onTap: () {
                              AuthCubit.get(context).removeCarImage();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: const Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                      ],
                    )
                    : InkWell(
                      onTap: () {
                        AuthCubit.get(context).getCarImage();
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10.r),
                        color: Colors.grey,
                        child: SizedBox(
                          height: 90.h,
                          width: 90.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey,
                                ),
                                AppText(
                                  text: LocaleKeys.attach_photo.tr(),
                                  size: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ],
        );
      },
    );
  }
}
