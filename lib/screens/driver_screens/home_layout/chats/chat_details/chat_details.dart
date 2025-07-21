import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/models/chat_models.dart';
import '../../../../../core/service/socket/sockey_service.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

final _replayMessageController = TextEditingController();

class DrivChatDetails extends StatefulWidget {
  final String id;
  const DrivChatDetails({super.key, required this.id});

  @override
  State<DrivChatDetails> createState() => _DrivChatDetailsState();
}

class _DrivChatDetailsState extends State<DrivChatDetails> {
  final List<ChatMessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    SocketService().initSocket(CacheHelper.getUserId());

    SocketService().socket.on("successMessage", (data) {
      print("✅ successMessage: $data");

      final chat = data["chat"];
      final messageMap = chat["messages"].last;

      final confirmedMsg = ChatMessageModel(
        fromId: messageMap["senderId"],
        message: messageMap["message"],
        createdAt: messageMap["createdAt"],
        isPending: false,
      );

      // حدّث الرسالة المعلقة لو لقيتها بنفس النص والمرسل
      final index = messages.indexWhere(
        (msg) =>
            msg.isPending &&
            msg.message == confirmedMsg.message &&
            msg.fromId == confirmedMsg.fromId,
      );

      if (index != -1) {
        setState(() {
          messages[index] = confirmedMsg;
        });
      } else {
        // فقط أضفها لو مش موجودة فعلاً
        final exists = messages.any(
          (msg) =>
              msg.message == confirmedMsg.message &&
              msg.fromId == confirmedMsg.fromId,
        );

        if (!exists) {
          setState(() => messages.insert(0, confirmedMsg));
        }
      }
    });

    SocketService().socket.on("receiveMessage", (data) {
      print("📩 receiveMessage: $data");

      final chat = data["chat"];
      final messageMap = chat["messages"].last;

      final newMsg = ChatMessageModel(
        fromId: messageMap["senderId"],
        message: messageMap["message"],
        createdAt: messageMap["createdAt"],
        isPending: false,
      );

      setState(() => messages.insert(0, newMsg));
    });
  }

  void _sendMessage() {
    final text = _replayMessageController.text.trim();
    if (text.isEmpty) return;

    final localId = UniqueKey().toString();

    final tempMsg = ChatMessageModel(
      fromId: CacheHelper.getUserId(),
      message: text,
      createdAt: DateTime.now().toIso8601String(),
      isPending: true,
      localId: localId,
    );

    setState(() => messages.insert(0, tempMsg));

    SocketService().sendMessage(message: text, destId: widget.id);

    _replayMessageController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomAppBar(title: LocaleKeys.chat.tr()),
            Container(
              width: 343.w,
              padding: EdgeInsets.all(16.r),
              margin: EdgeInsetsDirectional.only(
                top: 16.h,
                start: 16.w,
                end: 16.w,
                bottom: 21.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondray,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 36.w,
                    width: 36.w,
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(1000.r),
                    ),
                    child: SvgPicture.asset(
                      Assets.svg.user,
                      color: Colors.white,
                      height: 40.w,
                      width: 40.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  AppText(
                    text: LocaleKeys.chat_with.tr(),
                    size: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              height: 350.h,
              width: 343.w,
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.all(16.r),
              margin: EdgeInsets.only(bottom: 30.h),
              decoration: BoxDecoration(
                color: AppColors.third,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: ListView.separated(
                itemCount: messages.length,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 5.h),
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isMine = msg.fromId == CacheHelper.getUserId();

                  return Align(
                    alignment:
                        isMine
                            ? AlignmentDirectional.centerStart
                            : AlignmentDirectional.centerEnd,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.svg.user,
                          height: 40.w,
                          width: 40.w,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 7.w),
                        AppText(
                          text: msg.message + (msg.isPending ? " ⏳" : ""),
                          size: 16.sp,
                          color: msg.isPending ? Colors.grey : Colors.black,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            AppInput(
              border: 1000.r,
              controller: _replayMessageController,
              filled: true,
              color: const Color(0xffF5F5F5),
              enabledBorderColor: Colors.transparent,
              hint: LocaleKeys.yourMessage.tr(),
              onSubmitted: (_) => _sendMessage(),
              suffixIcon: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _sendMessage,
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
            ),
          ],
        ),
      ),
    );
  }
}
