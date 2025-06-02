import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../../core/constants/colors.dart';
import '../../../core/widgets/app_input.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/chat_message.dart';
import 'widgets/custom_chat_with_container.dart';

final _messageSendController = TextEditingController();

class ChatDetails extends StatefulWidget {
  const ChatDetails({super.key});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> with WidgetsBindingObserver {
  late IO.Socket socket;
  List<ChatMessageModel> messages = [];

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _connectToSocket();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    final userId = AppCubit.get(context).showProfileMap['_id'];

    messages =
        messages
            .map((msg) => ChatMessageModel(fromId: userId, message: ''))
            .toList();
  }

  void _connectToSocket() {
    socket = IO.io(
      'https://towtruck.cloud:3000', // غيّر ده بالرابط الصحيح
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      debugPrint('✅ Connected to socket');
    });

    // ✅ عند إرسال رسالة والتأكد إنها وصلت
    socket.on('successMessage', (data) {
      debugPrint('✅ successMessage: ${data['message']}');
      setState(() {
        messages.add(
          ChatMessageModel(
            fromId:
                AppCubit.get(
                  context,
                ).showProfileMap['_id'], // المرسل هو المستخدم الحالي
            message: data['message'],
          ),
        );
      });
    });

    // ✅ عند استلام رسالة من الآخر
    socket.on('receiveMessage', (data) {
      debugPrint('📩 receiveMessage: ${data['message']}');
      setState(() {
        messages.add(
          ChatMessageModel(
            fromId: data['fromId'], // المرسل شخص آخر
            message: data['message'],
          ),
        );
      });
    });

    // ✅ عند حدوث خطأ
    socket.on('socket_Error', (error) {
      debugPrint('❌ Socket Error: $error');
    });

    socket.onDisconnect((_) => debugPrint('❌ Disconnected'));
  }

  void _sendMessage(String message, String destId) {
    if (message.trim().isEmpty) return;

    // إرسال الرسالة للسيرفر
    socket.emit('sendMessage', {'message': message, 'destId': destId});

    // إضافة الرسالة محلياً مع تحديث الشاشة والتمرير لآخر الرسالة
    setState(() {
      messages.add(
        ChatMessageModel(
          fromId: AppCubit.get(context).showProfileMap['_id'],
          message: message,
        ),
      );
    });

    // تمرير الشاشة لآخر الرسائل بعد انتهاء الـ build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    _messageSendController.clear();
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
              _sendMessage(_messageSendController.text, "destId");
              _messageSendController.clear();
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
              CustomAppBar(title: LocaleKeys.chat.tr()),
              const CustomChatWithContainer(),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 120.h),
                  itemCount: messages.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (_, __) => SizedBox(height: 18.h),
                  itemBuilder:
                      (context, index) =>
                          ChatMessage(chatMessages: messages[index]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
