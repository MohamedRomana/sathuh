import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/service/socket/sockey_service.dart';
import '../../../../../../core/widgets/app_input.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../generated/locale_keys.g.dart';

class CustomAdminSendMessage extends StatelessWidget {
  final String id;
  final TextEditingController replayMessageController;
  const CustomAdminSendMessage({
    super.key,
    required this.replayMessageController,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return AppInput(
      border: 1000.r,
      controller: replayMessageController,
      filled: true,
      color: const Color(0xffF5F5F5),
      enabledBorderColor: Colors.transparent,
      hint: LocaleKeys.yourMessage.tr(),
      onSubmitted: (p0) {
        if (replayMessageController.text.trim().isNotEmpty) {
          SocketService().sendMessage(
            message: replayMessageController.text.trim(),
            destId: id,
          );
          replayMessageController.clear();
          FocusScope.of(context).unfocus();
        }
      },
      suffixIcon: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (replayMessageController.text.trim().isNotEmpty) {
            SocketService().sendMessage(
              message: replayMessageController.text.trim(),
              destId: id,
            );
            replayMessageController.clear();
            FocusScope.of(context).unfocus();
          }
        },
        child: Container(
          height: 48.w,
          width: 48.w,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(1000.r),
          ),
          child: SvgPicture.asset(
            Assets.svg.send,
            height: 24.w,
            width: 24.w,
            color: Colors.white,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
