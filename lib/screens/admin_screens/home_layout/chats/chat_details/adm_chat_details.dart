import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/cache/cache_helper.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../widgets/custom_chat_with_container.dart';

class AdmChatDetails extends StatefulWidget {
  final Map<String, dynamic> user;
  const AdmChatDetails({super.key, required this.user});

  @override
  State<AdmChatDetails> createState() => _AdmChatDetailsState();
}

class _AdmChatDetailsState extends State<AdmChatDetails>
    with WidgetsBindingObserver {
  IO.Socket? socket;
  List<String> messages = [];
  TextEditingController? messageSendController;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    messageSendController = TextEditingController();
    initSocket();
    WidgetsBinding.instance.addObserver(this);
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

  void initSocket() {
    final token = CacheHelper.getUserToken();

    socket = IO.io("https://towtruck.cloud", {
      'transports': ['websocket'],
      'autoConnect': true,
    });

    debugPrint('📌 Token sent to socket: $token');

    socket!.connect();

    socket!.onConnect((_) {
      debugPrint('✅ Connected to socket');

      socket!.emit('Authorization', {'token': token});
    });

    socket!.on('socket_Error', (data) {
      debugPrint('❌ Socket Error: $data');
    });

    socket!.onDisconnect((_) {
      debugPrint('❌ Disconnected from socket');
    });

    socket!.on("successMessage", (data) {
      debugPrint('✅ Message Sent and Stored: $data');
      setState(() {
        messages.add(data['message']);
      });
    });

    socket!.on("receiveMessage", (data) {
      debugPrint('📩 Received Message: $data');
      setState(() {
        messages.add(data['message']);
      });
    });
  }

  void sendMessage() {
    final messageText = messageSendController!.text.trim();
    if (messageText.isEmpty) return;

    socket?.emit("sendMessage", {
      "message": messageText,
      "destId": widget.user['_id'],
    });

    messageSendController!.clear();
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

  // void _sendMessage() {
  //   Future.delayed(const Duration(milliseconds: 300), () {
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppInput(
        controller: messageSendController,
        enabledBorderColor: Colors.grey,
        filled: true,
        suffixIcon: GestureDetector(
          onTap: sendMessage,
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
              CustomChatWithContainer(user: widget.user),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 120.h),
                  itemCount: messages.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => Container(height: 18.h),
                  itemBuilder:
                      (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.r),
                              margin: EdgeInsetsDirectional.only(
                                start: 6.w,
                                end: 6.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.zero,
                                  topStart: Radius.circular(8.r),
                                  bottomEnd: Radius.circular(8.r),
                                  bottomStart: Radius.circular(8.r),
                                ),
                              ),
                              child: SizedBox(
                                width: 250.w,
                                child: AppText(
                                  text: messages[index],
                                  lines: 5,
                                  size: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 50.w,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.w,
                                ),
                                borderRadius: BorderRadius.circular(100.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(100),
                                    blurRadius: 5.r,
                                    spreadRadius: 1.r,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: Image.asset(
                                  Assets.img.driver.path,
                                  height: 50.w,
                                  width: 50.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
