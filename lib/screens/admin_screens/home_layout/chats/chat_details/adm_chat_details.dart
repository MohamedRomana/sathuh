import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/models/chat_models.dart';
import '../../../../../core/service/socket/sockey_service.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'widgets/custom_chat_with_container.dart';
import 'widgets/custom_send_messages.dart';

final _replayMessageController = TextEditingController();

class AdmChatDetails extends StatefulWidget {
  final String id;
  const AdmChatDetails({super.key, required this.id});

  @override
  State<AdmChatDetails> createState() => _AdmChatDetailsState();
}

class _AdmChatDetailsState extends State<AdmChatDetails> {
  final List<ChatMessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    SocketService().initSocket(CacheHelper.getUserId());

    SocketService().socket.on("successMessage", (data) {
      print("SuccessMessage: $data");
      final msgText = data['message'];
      final senderId = CacheHelper.getUserId(); // انت المرسل
      final newMsg = ChatMessageModel(
        fromId: senderId,
        message: msgText,
        createdAt: DateTime.now().toString(),
      );

      setState(() => messages.insert(0, newMsg));
    });

    SocketService().socket.on("receiveMessage", (data) {
      print("ReceiveMessage: $data");
      final msgText = data['message'];
      final senderId = widget.id; // المستقبل أرسلك
      final newMsg = ChatMessageModel(
        fromId: senderId,
        message: msgText,
        createdAt: DateTime.now().toString(),
      );

      setState(() => messages.insert(0, newMsg));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: LocaleKeys.chat.tr()),
          const CustomChatWithAdminContainer(),
          Expanded(
            child: Container(
              width: 343.w,
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
                reverse: true, // أو false حسب الترتيب اللي تريده
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
                        AppText(text: msg.message, size: 16.sp),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          CustomAdminSendMessage(
            replayMessageController: _replayMessageController,
            id: widget.id,
          ),
        ],
      ),
    );
  }
}
