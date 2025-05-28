import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../core/widgets/custom_lottie_widget.dart';

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomLottieWidget(lottieName: Assets.img.notiEmpty),
        AppText(
          top: 16.h,
          text: LocaleKeys.noNotifications.tr(),
          size: 24.sp,
          color: AppColors.primary,
          fontStyle: FontStyle.italic,
        ),
        Container(height: 140.h),
      ],
    );
  }
}
