import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';

class EditCar extends StatelessWidget {
  const EditCar({super.key});

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(title: 'تعديل بيانات السياره'),
                AppText(
                  text: 'نوع السيارة',
                  bottom: 8.h,
                  start: 16.w,
                  family: FontFamily.tajawalBold,
                  size: 16.sp,
                ),
                const AppInput(
                  filled: true,
                  enabledBorderColor: Colors.grey,
                  hint: 'سيدان',
                ),
                AppText(
                  text: 'موديل السيارة',
                  bottom: 8.h,
                  top: 8.h,
                  start: 16.w,
                  family: FontFamily.tajawalBold,
                  size: 16.sp,
                ),
                const AppInput(
                  filled: true,
                  enabledBorderColor: Colors.grey,
                  hint: 'BMW',
                ),
                AppText(
                  text: 'سنة الصنع',
                  start: 16.w,
                  bottom: 8.h,
                  top: 8.h,
                  family: FontFamily.tajawalBold,
                  size: 16.sp,
                ),
                const AppInput(
                  filled: true,
                  enabledBorderColor: Colors.grey,
                  hint: '2022',
                ),
                AppText(
                  text: 'اللون',
                  start: 16.w,
                  bottom: 8.h,
                  top: 8.h,
                  family: FontFamily.tajawalBold,
                  size: 16.sp,
                ),
                const AppInput(
                  filled: true,
                  enabledBorderColor: Colors.grey,
                  hint: 'زرقاء',
                ),
                AppText(
                  text: 'رقم الشاسيه (كما هو مكتوب في الرخصه)',
                  bottom: 8.h,
                  top: 8.h,
                  start: 16.w,
                  family: FontFamily.tajawalBold,
                  size: 16.sp,
                ),
                const AppInput(
                  filled: true,
                  enabledBorderColor: Colors.grey,
                  hint: '01151515154515154',
                ),
                AppText(
                  text: 'رقم لوحة السياره',
                  bottom: 8.h,
                  top: 8.h,
                  start: 16.w,
                  family: FontFamily.tajawalBold,
                  size: 16.sp,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: AppInput(
                        filled: true,
                        border: 10.r,
                        end: 0,
                        enabledBorderColor: Colors.grey,
                        hint: 'ا',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 90.w,
                      child: AppInput(
                        filled: true,
                        border: 10.r,
                        end: 0,
                        enabledBorderColor: Colors.grey,
                        hint: 'ب',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 90.w,
                      child: AppInput(
                        end: 0,
                        filled: true,
                        border: 10.r,
                        enabledBorderColor: Colors.grey,
                        hint: 'ج',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 90.w,
                      child: AppInput(
                        end: 0,
                        filled: true,
                        hint: '123',
                        textAlign: TextAlign.center,
                        border: 10.r,
                        enabledBorderColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: AppButton(
                    top: 24.h,
                    onPressed: () {
                      AppRouter.pop(context);
                    },
                    child: AppText(
                      text: 'حفظ',
                      size: 21.sp,
                      color: Colors.white,
                      family: FontFamily.tajawalBold,
                    ),
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
