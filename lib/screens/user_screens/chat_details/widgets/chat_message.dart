import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class ChatMessageModel {
  final String fromId;
  final String message;

  ChatMessageModel({required this.fromId, required this.message});
}

class ChatMessage extends StatelessWidget {
  final ChatMessageModel chatMessages;
  const ChatMessage({super.key, required this.chatMessages});

  @override
  Widget build(BuildContext context) {
    final String? profileIdStr = CacheHelper.getdrawerProfileId();
    final int profileId = profileIdStr != null ? int.parse(profileIdStr) : -1;
    final bool isMine = chatMessages.fromId == profileId;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMine) _buildAvatar(Assets.img.client.path, AppColors.third),
          Container(
            padding: EdgeInsets.all(12.r),
            margin: EdgeInsetsDirectional.only(start: 6.w, end: 6.w),
            decoration: BoxDecoration(
              color: isMine ? const Color(0xffD7E4F9) : AppColors.primary,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: isMine ? Radius.zero : Radius.circular(8.r),
                topStart: isMine ? Radius.circular(8.r) : Radius.zero,
                bottomEnd: Radius.circular(8.r),
                bottomStart: Radius.circular(8.r),
              ),
            ),
            child: SizedBox(
              width: 190.w,
              child: AppText(
                text: chatMessages.message,
                lines: 5,
                size: 14.sp,
                color: isMine ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (isMine) _buildAvatar(Assets.img.driver.path, AppColors.secondray),
        ],
      ),
    );
  }

  Widget _buildAvatar(String imagePath, Color bgColor) {
    return Container(
      height: 40.w,
      width: 40.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child: Image.asset(
          imagePath,
          height: 40.w,
          width: 40.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}



//  Row(
//               mainAxisAlignment: chatMessage.fromId != int.parse(CacheHelper.getdrawerProfileId())
//               ? MainAxisAlignment.end
//               : MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 if(chatMessage.fromId == int.parse(CacheHelper.getdrawerProfileId()))
//                 SvgPicture.asset(Assets.svg.profilecircle, height: 50.w, width: 50.w, fit: BoxFit.cover),
//                 Flexible(child: AppText(text: chatMessage.message, size: 14.sp, color: Colors.black,),),
//                 if(chatMessage.fromId != int.parse(CacheHelper.getdrawerProfileId()))
//                 SvgPicture.asset(Assets.svg.profilecircle, height: 50.w, width: 50.w, fit: BoxFit.cover),
//                 Flexible(child: AppText(text: chatMessage.message, size: 14.sp, color: Colors.black,),),
//               ],
//             ),