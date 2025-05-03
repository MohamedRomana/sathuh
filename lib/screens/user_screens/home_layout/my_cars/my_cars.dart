import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../add_cars/add_cars.dart';

class MyCars extends StatelessWidget {
  const MyCars({super.key});

  @override
  Widget build(BuildContext context) {
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomAppBar(
                  title: LocaleKeys.my_cars.tr(),
                  isHomeLayout: true,
                ),
                ListView.separated(
                  padding: EdgeInsets.only(top: 20.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder:
                      (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (AppCubit.get(
                            context,
                          ).selectedCarIndexes.contains(index)) {
                            AppCubit.get(context).changeSelectedCar(index: -1);
                          } else {
                            AppCubit.get(
                              context,
                            ).changeSelectedCar(index: index);
                          }
                        },
                        child: Container(
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
                          child: Row(
                            children: [
                              Container(
                                height: 80.h,
                                width: 80.w,
                                margin: EdgeInsetsDirectional.only(end: 10.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                  image: DecorationImage(
                                    image: AssetImage(Assets.img.bmw.path),
                                    fit: BoxFit.cover,
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
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: AppText(
                                      text: 'سيارة BMW 2022',
                                      size: 12.sp,
                                      color: AppColors.secondray,
                                      family: FontFamily.tajawalBold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: AppText(
                                      text: 'سيدان',
                                      size: 12.sp,
                                      color: AppColors.secondray,
                                      family: FontFamily.tajawalBold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: AppText(
                                      text: 'زرقاء',
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
                                margin: EdgeInsetsDirectional.only(end: 16.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(2.r),
                                  decoration: BoxDecoration(
                                    color:
                                        AppCubit.get(
                                              context,
                                            ).selectedCarIndexes.contains(index)
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
                    text: 'اضافة سياره',
                    color: Colors.white,
                    family: FontFamily.tajawalBold,
                    size: 21.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
