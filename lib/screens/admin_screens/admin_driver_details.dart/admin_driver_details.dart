import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/admin_bottom_nav.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/contsants.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../user_screens/driver_details/rates/product_rates.dart';
import 'widgets/about_driver.dart';
import 'widgets/driver_header.dart';
import 'widgets/driver_orders.dart';

class AdminDriverDetails extends StatelessWidget {
  const AdminDriverDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminBottomNav(
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
                const DriverHeader(),
                const AboutDriver(),
                const CustomDriverOrders(),
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
                      Container(width: 8.w),
                      AppText(
                        text: LocaleKeys.contact_via_whatsapp.tr(),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
                Container(height: 120.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
