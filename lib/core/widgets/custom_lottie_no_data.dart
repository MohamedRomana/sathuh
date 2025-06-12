import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../gen/assets.gen.dart';
import '../constants/colors.dart';
import 'app_text.dart';
import 'custom_lottie_widget.dart';

class CustomLottieNoData extends StatelessWidget {
  final String lottieTitle;
  const CustomLottieNoData({super.key, required this.lottieTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 120.h),
        Center(child: CustomLottieWidget(lottieName: Assets.img.emptyorder)),
        AppText(
          text: lottieTitle,
          size: 24.sp,
          color: AppColors.primary,
          fontStyle: FontStyle.italic,
        ),
      ],
    );
  }
}

