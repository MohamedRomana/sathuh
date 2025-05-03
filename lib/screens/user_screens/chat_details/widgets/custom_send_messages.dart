import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomSendMessage extends StatelessWidget {
  final TextEditingController replayMessageController;
  const CustomSendMessage({super.key, required this.replayMessageController});

  @override
  Widget build(BuildContext context) {
    return AppInput(
      controller: replayMessageController,
      filled: true,
      color: const Color(0xffF5F5F5),
      enabledBorderColor: Colors.grey,
      hint: LocaleKeys.yourMessage.tr(),
      onSubmitted: (p0) {
        // AppCubit.get(context)
        //     .sendMessage(message: replayMessageController.text);
        replayMessageController.clear();
        FocusScope.of(context).unfocus();
      },
      suffixIcon: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          // AppCubit.get(context)
          //     .sendMessage(message: replayMessageController.text);
          replayMessageController.clear();
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: SvgPicture.asset(
            Assets.svg.send,
            color: AppColors.primary,
            height: 24.w,
            width: 24.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
