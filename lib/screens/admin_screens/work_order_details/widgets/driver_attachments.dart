import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sathuh/generated/locale_keys.g.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class DriverAttachments extends StatelessWidget {
  const DriverAttachments({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: LocaleKeys.attachments.tr(),
          size: 18.sp,
          fontWeight: FontWeight.bold,
          bottom: 16.h,
          start: 16.w,
          top: 24.h,
        ),
        Container(
          width: 343.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      AppText(
                        text: LocaleKeys.identityImage.tr(),
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 10.h,
                      ),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    height: 300.w,
                                    width: 300.w,
                                    child: PhotoView(
                                      backgroundDecoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      imageProvider:
                                          Image.asset(
                                            Assets.img.driver.path,
                                            height: 100.h,
                                            width: 300.w,
                                            fit: BoxFit.fill,
                                          ).image,
                                    ),
                                  ),
                                ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Container(
                            color: Colors.grey,
                            child: Image.asset(
                              Assets.img.driver.path,
                              height: 90.w,
                              width: 90.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppText(
                        text: LocaleKeys.licenseImage.tr(),
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 10.h,
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    height: 300.w,
                                    width: 300.w,
                                    child: PhotoView(
                                      backgroundDecoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      imageProvider:
                                          Image.asset(
                                            Assets.img.driver.path,
                                            height: 100.h,
                                            width: 300.w,
                                            fit: BoxFit.fill,
                                          ).image,
                                    ),
                                  ),
                                ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Container(
                            color: Colors.grey,
                            child: Image.asset(
                              Assets.img.driver.path,
                              height: 90.w,
                              width: 90.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppText(
                        text: LocaleKeys.carImage.tr(),
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 10.h,
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    height: 300.w,
                                    width: 300.w,
                                    child: PhotoView(
                                      backgroundDecoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      imageProvider:
                                          Image.asset(
                                            Assets.img.driver.path,
                                            height: 100.h,
                                            width: 300.w,
                                            fit: BoxFit.fill,
                                          ).image,
                                    ),
                                  ),
                                ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Container(
                            color: Colors.grey,
                            child: Image.asset(
                              Assets.img.driver.path,
                              height: 90.w,
                              width: 90.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppText(
                      top: 24.h,
                      text: LocaleKeys.subscription_payment_image.tr(),
                      size: 14.sp,
                      fontWeight: FontWeight.bold,
                      bottom: 10.h,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                height: 300.w,
                                width: 300.w,
                                child: PhotoView(
                                  backgroundDecoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  imageProvider:
                                      Image.asset(
                                        Assets.img.driver.path,
                                        height: 100.h,
                                        width: 300.w,
                                        fit: BoxFit.fill,
                                      ).image,
                                ),
                              ),
                            ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Container(
                        color: Colors.grey,
                        child: Image.asset(
                          Assets.img.driver.path,
                          height: 300.w,
                          width: 300.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
