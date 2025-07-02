import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import '../../../../../core/constants/colors.dart';
import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/chat_message.dart';
import 'widgets/client_chat_with.dart';


final _messageSendController = TextEditingController();

class ChatDetails extends StatefulWidget {
  final String destId; // معرف المستخدم الآخر
  final String otherUserName; // اسم المستخدم الآخر لعرضه في الـ AppBar
  const ChatDetails({super.key, required this.destId, required this.otherUserName});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // استدعي دالة جلب الرسائل من الـ Cubit
    AppCubit.get(context).getChatMessages(widget.destId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0.0) {
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 12),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppInput(
        controller: _messageSendController,
        enabledBorderColor: Colors.grey,
        filled: true,
        suffixIcon: GestureDetector(
          onTap: () {
            if (_messageSendController.text.trim().isNotEmpty) {
              AppCubit.get(context).sendMessage(
                _messageSendController.text,
                widget.destId,
              );
              _messageSendController.clear();
              _scrollToBottom(); // تمرير الشاشة بعد الإرسال
            }
          },
          child: Icon(Icons.send, color: AppColors.primary, size: 30.sp),
        ),
        hint: LocaleKeys.write_message.tr(),
      ),
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(title: widget.otherUserName), // عرض اسم المستخدم الآخر
              const CustomClientChatWithContainer(),
              Expanded(
                child: BlocConsumer<AppCubit, AppState>( // استمع لتغييرات حالة الرسائل
                  listener: (context, state) {
                    if (state is GetChatMessagesSuccess || state is SendMessageSuccess) {
                      _scrollToBottom(); // تمرير الشاشة للأسفل عند تحديث الرسائل
                    }
                    if (state is GetChatMessagesError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    final messages = AppCubit.get(context).currentChatMessages;

                    if (state is GetChatMessagesLoading && messages.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (messages.isEmpty) {
                      return Center(child: AppText(text: 'لا توجد رسائل بعد.', size: 16.sp));
                    }

                    return ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: 120.h),
                      itemCount: messages.length,
                      physics:  const BouncingScrollPhysics(),
                      separatorBuilder: (_, __) => SizedBox(height: 18.h),
                      itemBuilder: (context, index) =>
                          ChatMessage(chatMessages: messages[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}