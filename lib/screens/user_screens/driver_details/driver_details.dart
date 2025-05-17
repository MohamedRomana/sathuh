import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/constants/contsants.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'rates/product_rates.dart';
import 'widgets/custom_about_provider.dart';
import 'widgets/provider_header.dart';

class DriverDetails extends StatelessWidget {
  const DriverDetails({super.key});

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
              children: [
                CustomAppBar(title: LocaleKeys.driver.tr()),
                const ProviderHeader(),
                const CustomAboutProvider(),
                const ProductRates(),
                AppButton(
                  onPressed: () {
                    openWhatsApp('0100020202020');
                  },
                  color: AppColors.secondray,
                  top: 24.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.img.social.path,
                        height: 30.w,
                        width: 30.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 8.w),
                      AppText(
                        text: LocaleKeys.contact_via_whatsapp.tr(),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 120.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

