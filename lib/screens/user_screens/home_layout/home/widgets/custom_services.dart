import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import 'package:sathuh/core/widgets/custom_shimmer.dart';
import 'package:sathuh/screens/user_screens/satha_service/satha_service.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomServices extends StatefulWidget {
  const CustomServices({super.key});

  @override
  State<CustomServices> createState() => _CustomServicesState();
}

class _CustomServicesState extends State<CustomServices> {
  @override
  void initState() {
    AppCubit.get(context).services();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: LocaleKeys.flatbed_services.tr(),
              start: 16.w,
              family: FontFamily.tajawalBold,
              size: 21.sp,
            ),
            state is GetServicesLoading &&
                    AppCubit.get(context).servicesList.isEmpty
                ? CustomShimmer(
                  child: SizedBox(
                    height: 150.h,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder:
                          (context, index) => Container(
                            height: 150.h,
                            width: 160.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                      separatorBuilder:
                          (context, index) => SizedBox(width: 16.w),
                      itemCount: 5,
                    ),
                  ),
                )
                : SizedBox(
                  height: 150.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: AppCubit.get(context).servicesList.length,
                    separatorBuilder: (context, index) => SizedBox(width: 16.w),
                    itemBuilder:
                        (context, index) => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppRouter.navigateTo(
                              context,
                              SathaService(
                                serviceId:
                                    AppCubit.get(
                                      context,
                                    ).servicesList[index]['_id'],
                              ),
                            );
                          },
                          child: Container(
                            height: 150.h,
                            width: 160.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child:
                                      (AppCubit.get(
                                                context,
                                              ).servicesList[index]['image'] !=
                                              null)
                                          ? AppCachedImage(
                                            image:
                                                AppCubit.get(
                                                  context,
                                                ).servicesList[index]['image'] ??
                                                "",
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          )
                                          : Image.asset(
                                            Assets.img.logo.path,
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                ),
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(100),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 30.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                            bottomEnd: Radius.circular(15.r),
                                            bottomStart: Radius.circular(15.r),
                                          ),
                                    ),
                                    child: Center(
                                      child: AppText(
                                        text:
                                            AppCubit.get(
                                              context,
                                            ).servicesList[index]['type'] ??
                                            "",
                                        family: FontFamily.tajawalBold,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ),
                ),
          ],
        );
      },
    );
  }
}
