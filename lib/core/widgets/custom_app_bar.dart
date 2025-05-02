// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../cache/cache_helper.dart';
import '../constants/colors.dart';

// final _searchController = TextEditingController();
// final _formKey = GlobalKey<FormState>();

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool? isHomeLayout;
  const CustomAppBar({
    super.key,
    required this.title,
    this.isHomeLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 16.w,
        end: 16.w,
        top: 50.h,
        bottom: 20.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(text: title, size: 24.sp, family: FontFamily.tajawalBold),
          if (isHomeLayout!) ...{
            CacheHelper.getUserType() == "client"
                ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: Container(
                    height: 32.w,
                    width: 32.w,
                    decoration: BoxDecoration(
                      color: AppColors.third.withOpacity(0.52.r),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.search, color: Colors.white, size: 20.sp),
                  ),
                )
                : const SizedBox.shrink(),
          } else ...{
            Row(
              children: [
                CacheHelper.getUserType() == "client"
                    ? InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Container(
                        height: 32.w,
                        width: 32.w,
                        decoration: BoxDecoration(
                          color: AppColors.third.withOpacity(0.52.r),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    )
                    : const SizedBox.shrink(),
                SizedBox(width: 6.w),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 32.w,
                    width: 32.w,
                    decoration: BoxDecoration(
                      color: AppColors.third.withOpacity(0.52.r),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.identity()..scale(
                              CacheHelper.getLang() == 'en' ? -1.0 : 1.0,
                              1.0,
                            ),
                        child: SvgPicture.asset(
                          Assets.svg.arrow,
                          color: Colors.white,
                          height: 20.w,
                          width: 20.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          },
        ],
      ),
    );
  }
}
