import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_shimmer.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../add_cars/add_cars.dart';
import '../proplem_type/problem_type.dart';

class SathaService extends StatefulWidget {
  final String serviceId;
  const SathaService({super.key, required this.serviceId});

  @override
  State<SathaService> createState() => _SathaServiceState();
}

class _SathaServiceState extends State<SathaService> {
  @override
  void initState() {
    AppCubit.get(context).changeSelectedCar(index: -1);
    AppCubit.get(context).getCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
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
                    CustomAppBar(title: LocaleKeys.flatbed_service.tr()),
                    state is GetCarsLoading &&
                            AppCubit.get(context).carsList.isEmpty
                        ? CustomShimmer(
                          child: ListView.separated(
                            padding: EdgeInsets.only(top: 20.h),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 13,
                            separatorBuilder:
                                (context, index) => Container(height: 16.h),
                            itemBuilder:
                                (context, index) => Container(
                                  height: 100.h,
                                  width: 343.w,
                                  padding: EdgeInsets.all(16.r),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
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
                                ),
                          ),
                        )
                        : ListView.separated(
                          padding: EdgeInsets.only(top: 20.h),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: AppCubit.get(context).carsList.length,
                          separatorBuilder:
                              (context, index) => Container(height: 16.h),
                          itemBuilder:
                              (context, index) => InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  if (AppCubit.get(
                                    context,
                                  ).selectedCarIndexes.contains(index)) {
                                    AppCubit.get(
                                      context,
                                    ).changeSelectedCar(index: -1);
                                  } else {
                                    AppRouter.navigateTo(
                                      context,
                                      ProblemType(
                                        carId:
                                            AppCubit.get(
                                              context,
                                            ).carsList[index]['_id'],
                                        serviceId: widget.serviceId,
                                      ),
                                    );
                                    AppCubit.get(
                                      context,
                                    ).changeSelectedCar(index: index);
                                  }
                                  debugPrint(
                                    'carId : ${AppCubit.get(context).carsList[index]['_id']}',
                                  );
                                },
                                child: Container(
                                  width: 343.w,
                                  padding: EdgeInsets.all(16.r),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
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
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 80.h,
                                        width: 80.w,
                                        margin: EdgeInsetsDirectional.only(
                                          end: 10.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            15.r,
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
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15.r,
                                          ),

                                          child:
                                              (AppCubit.get(context)
                                                          .carsList[index]['image']
                                                          .isNotEmpty ??
                                                      false)
                                                  ? AppCachedImage(
                                                    image:
                                                        AppCubit.get(
                                                          context,
                                                        ).carsList[index]['image'],
                                                    fit: BoxFit.cover,
                                                  )
                                                  : Image.asset(
                                                    Assets.img.logo.path,
                                                    fit: BoxFit.cover,
                                                  ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 150.w,
                                            child: AppText(
                                              text:
                                                  '${AppCubit.get(context).carsList[index]['type']} ${AppCubit.get(context).carsList[index]['manufactureYear']}',
                                              size: 12.sp,
                                              color: AppColors.secondray,
                                              family: FontFamily.tajawalBold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150.w,
                                            child: AppText(
                                              text:
                                                  AppCubit.get(
                                                    context,
                                                  ).carsList[index]['model'],
                                              size: 12.sp,
                                              color: AppColors.secondray,
                                              family: FontFamily.tajawalBold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150.w,
                                            child: AppText(
                                              text:
                                                  AppCubit.get(
                                                    context,
                                                  ).carsList[index]['color'],
                                              size: 12.sp,
                                              color: AppColors.secondray,
                                              family: FontFamily.tajawalBold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        height: 22.w,
                                        width: 22.w,
                                        margin: EdgeInsetsDirectional.only(
                                          end: 16.w,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(2.r),
                                          decoration: BoxDecoration(
                                            color:
                                                AppCubit.get(context)
                                                        .selectedCarIndexes
                                                        .contains(index)
                                                    ? AppColors.primary
                                                    : Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ),
                    AppButton(
                      top: 24.h,
                      onPressed: () {
                        AppRouter.navigateTo(context, const AddCars());
                      },
                      child: AppText(
                        text: LocaleKeys.add_car.tr(),
                        color: Colors.white,
                        family: FontFamily.tajawalBold,
                        size: 21.sp,
                      ),
                    ),
                    Container(height: 120.h),
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
