import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_lottie_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70.h),
      child: Column(
        children: [
          CustomLottieWidget(lottieName: Assets.img.emptyorder),
          AppText(
            text: LocaleKeys.noOrdersAvailable.tr(),
            size: 35.sp,
            textAlign: TextAlign.center,
            color: AppColors.primary,
            fontStyle: FontStyle.italic,
            family: FontFamily.tajawalBold,
          )
        ],
      ),
    );
  }
}
