import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    AppCubit.get(context).aboutUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          body:
              state is AboutUsLoading
                  ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                  : Stack(
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
                            CustomAppBar(title: LocaleKeys.aboutus.tr()),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: Image.asset(
                                Assets.img.logo.path,
                                height: 300.h,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                            AppText(
                              start: 16.w,
                              end: 16.w,
                              textAlign: TextAlign.center,
                              text: AppCubit.get(context).aboutUsTitle,
                              lines: 100,
                              size: 16.sp,
                            ),
                            SizedBox(height: 120.h),
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
