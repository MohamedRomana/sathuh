import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/colors.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/service/models/chat_models.dart';
import '../../../core/service/socket/sockey_service.dart';
import '../../../core/widgets/app_cached.dart';
import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

final _replayMessageController = TextEditingController();

class ChatDetails extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final List oldMessages;

  const ChatDetails({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.oldMessages,
  });

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> with WidgetsBindingObserver {
  Timer? _chatRefreshTimer;
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessageModel> messages = [];
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _refreshChatMessages() async {
    final allChats = await AppCubit.get(context).getChats();

    final currentChat = allChats.firstWhere(
      (chat) =>
          chat['mainUser']['\$__']['parent']['mainUser']['_id'] ==
          widget.id,
      orElse: () => null,
    );

    if (currentChat == null) return;

    final updatedMessages = List<ChatMessageModel>.from(
      (currentChat['messages'] as List).map(
        (msg) => ChatMessageModel(
          fromId: msg['senderId'],
          message: msg['message'],
          createdAt: msg['createdAt'],
          isPending: false,
        ),
      ),
    );

    // تحويل أي رسالة عندك من pending لـ confirmed لو اتقبلت
    setState(() {
      messages =
          messages.map((msg) {
            if (msg.isPending &&
                updatedMessages.any((m) => m.message == msg.message)) {
              return msg.copyWith(
                isPending: false,
              ); // لازم تعمل copyWith في الموديل
            }
            return msg;
          }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _chatRefreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _refreshChatMessages();
    });
    SocketService().initSocket(CacheHelper.getUserId());

    // تحميل الرسائل القديمة
    messages =
        widget.oldMessages.map((msg) {
          return ChatMessageModel(
            fromId: msg["senderId"],
            message: msg["message"],
            createdAt: msg["createdAt"],
            isPending: false,
          );
        }).toList();

    // اسكرول لآخر رسالة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // استقبال الرسائل الجديدة من السوكيت
    SocketService().socket.on("successMessage", (data) {
      final messageMap = data["chat"]["messages"].last;
      final confirmedMsg = ChatMessageModel(
        fromId: messageMap["senderId"],
        message: messageMap["message"],
        createdAt: messageMap["createdAt"],
        isPending: false,
      );

      setState(() {
        messages.add(confirmedMsg);
      });

      _scrollToBottom(); // عشان ينزل بعد إضافة رسالة جديدة
    });
  }

  void _sendMessage(String text) {
    if (text.isEmpty) return;

    final pendingMsg = ChatMessageModel(
      fromId: CacheHelper.getUserId(),
      message: text,
      createdAt: DateTime.now().toIso8601String(),
      isPending: true,
    );

    setState(() {
      messages.add(pendingMsg);
    });

    SocketService().sendMessage(destId: widget.id, message: text);

    _replayMessageController.clear();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _chatRefreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: AppCachedImage(
                          image: widget.image,
                          height: 36.w,
                          width: 36.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      AppText(
                        text: "${LocaleKeys.chat_with.tr()} ",
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 150.w,
                        child: AppText(
                          text: widget.name,
                          size: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isMe = msg.fromId == CacheHelper.getUserId();

                      return Row(
                        mainAxisAlignment:
                            isMe
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          if (!isMe)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: AppCachedImage(
                                image: widget.image,
                                height: 40.w,
                                width: 40.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color:
                                  isMe ? Colors.grey[300] : AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              msg.message + (msg.isPending ? ' ⏳' : ''),
                              style: TextStyle(
                                color: isMe ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ],
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
                  onSubmitted: (_) {
                    final text = _replayMessageController.text.trim();
                    if (text.isEmpty) return;
                    _sendMessage(text);
                    _replayMessageController.clear();
                    _scrollToBottom();
                  },

                  suffixIcon: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      final text = _replayMessageController.text.trim();
                      if (text.isEmpty) return;
                      _sendMessage(text);
                      _replayMessageController.clear();
                      _scrollToBottom();
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
