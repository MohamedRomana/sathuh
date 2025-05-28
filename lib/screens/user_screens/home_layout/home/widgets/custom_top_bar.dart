import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../profile/profile.dart';

class CustomTopBar extends StatefulWidget {
  final String currentAddress;
  const CustomTopBar({super.key, required this.currentAddress});

  @override
  State<CustomTopBar> createState() => _CustomTopBarState();
}

class _CustomTopBarState extends State<CustomTopBar> {
  @override
  initState() {
    AppCubit.get(context).showProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppRouter.navigateTo(context, const Profile());
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 16.w, end: 5.w),
                    height: 50.w,
                    width: 50.w,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.w,
                        child: AppText(
                          text: LocaleKeys.welcome_dear_customer.tr(),
                          size: 12.sp,
                          color: AppColors.secondray,
                          family: FontFamily.tajawalBold,
                        ),
                      ),
                      Container(
                        width: 150.w,
                        child: AppText(
                          text: LocaleKeys.thank_you_for_your_preference.tr(),
                          size: 10.sp,
                          color: AppColors.secondray,
                          family: FontFamily.tajawalBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 100.w,
                  child: AppText(
                    textAlign: TextAlign.end,
                    text: widget.currentAddress,
                    size: 10.sp,
                    color: AppColors.primary,
                    family: FontFamily.tajawalBold,
                  ),
                ),
                Icon(Icons.location_on, color: AppColors.primary, size: 25.r),
              ],
            ),
            Container(width: 16.w),
          ],
        );
      },
    );
  }
}
