import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class ChatMessage extends StatelessWidget {
  final int index;
  final String chatMessage;
  const ChatMessage({
    super.key,
    required this.index,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            index.isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          index.isEven
              ? Container(
                height: 40.w,
                width: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.third,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.asset(
                    Assets.img.client.path,
                    height: 40.w,
                    width: 40.w,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              : Container(),
          Container(
            padding: EdgeInsets.all(12.r),
            margin: EdgeInsetsDirectional.only(start: 6.w, end: 6.w),
            decoration: BoxDecoration(
              color: index.isEven ? AppColors.primary : const Color(0xffD7E4F9),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: index.isEven ? Radius.circular(8.r) : Radius.zero,
                topStart: index.isEven ? Radius.zero : Radius.circular(8.r),
                bottomEnd: Radius.circular(8.r),
                bottomStart: Radius.circular(8.r),
              ),
            ),
            child: Container(
              width: 190.w,
              child: AppText(
                text:
                    'حسنًا، لنبدأ! أنا سأقول كلمة وأريدك أن تكررها  حسنًا، لنبدأ! أنا سأقول كلمة وأريدك أن تكررها بعدي، حسنا؟بعدي، حسنا؟ ',
                lines: 5,
                size: 14.sp,
                color: index.isEven ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          index.isOdd
              ? Container(
                height: 40.w,
                width: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.secondray,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.asset(
                    Assets.img.driver.path,
                    height: 40.w,
                    width: 40.w,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              : Container(),
        ],
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