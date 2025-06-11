import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import 'package:sathuh/core/widgets/custom_shimmer.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../add_cars/add_cars.dart';
import '../../edit_car/edit_car.dart';

class MyCars extends StatefulWidget {
  const MyCars({super.key});

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  @override
  initState() {
    AppCubit.get(context).getCars();
    super.initState();
  }

  Future<void> _refresh() async {
    AppCubit.get(context).getCars();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {});
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
              RefreshIndicator(
                onRefresh: () => _refresh(),
                color: AppColors.primary,
                backgroundColor: Colors.white,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CustomAppBar(
                        title: LocaleKeys.my_cars.tr(),
                        isHomeLayout: true,
                      ),
                      state is GetCarsLoading
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
                                    AppRouter.navigateTo(context, EditCar(index: index,));
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
                                            child: AppCachedImage(
                                              image:
                                                  AppCubit.get(
                                                    context,
                                                  ).carsList[index]['image'] ??
                                                  "",
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
                                                    ' ${AppCubit.get(context).carsList[index]['type']} ${AppCubit.get(context).carsList[index]['manufactureYear']}',
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
                                                    ).carsList[index]['color'] ??
                                                    "",
                                                size: 12.sp,
                                                color: AppColors.secondray,
                                                family: FontFamily.tajawalBold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () {
                                                AppRouter.navigateTo(
                                                  context,
                                                  EditCar(index: index),
                                                );
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            Container(width: 16.w),

                                            BlocConsumer<AppCubit, AppState>(
                                              listener: (context, state) {
                                                if (state is DeleteCarSuccess) {
                                                  showFlashMessage(
                                                    message: state.message,
                                                    type:
                                                        FlashMessageType
                                                            .success,
                                                    context: context,
                                                  );
                                                } else if (state
                                                    is DeleteCarFailure) {
                                                  showFlashMessage(
                                                    message: state.error,
                                                    type:
                                                        FlashMessageType.error,
                                                    context: context,
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    AppCubit.get(
                                                      context,
                                                    ).deleteCar(
                                                      carId:
                                                          AppCubit.get(
                                                            context,
                                                          ).carsList[index]['_id'],
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          ),
                      state is GetCarsLoading
                          ? const SizedBox.shrink()
                          : AppButton(
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
                      SizedBox(height: 120.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
