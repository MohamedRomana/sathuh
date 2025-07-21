import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/flash_message.dart';

import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomUploadNationalImage extends StatelessWidget {
  const CustomUploadNationalImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            AppText(
              text: LocaleKeys.national_id.tr(),
              size: 20.sp,
              top: 20.h,
              bottom: 16.h,
              fontWeight: FontWeight.bold,
              family: FontFamily.tajawalBold,
            ),
            AppCubit.get(context).nationalImage.isEmpty
                ? InkWell(
                  onTap: () {
                    AppCubit.get(context).getNationalImage(context);
                  },
                  child: DottedBorder(
                    radius: Radius.circular(20.r),
                    color: Colors.grey,
                    strokeWidth: 1,
                    child: SizedBox(
                      width: 100.w,
                      height: 150.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            size: 20.w,
                            color: Colors.grey,
                          ),
                          AppText(
                            text: LocaleKeys.attachImage.tr(),
                            size: 16.sp,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : Stack(
                  children: [
                    Container(
                      width: 100.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                          image: FileImage(
                            AppCubit.get(context).nationalImage.first,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      child: InkWell(
                        onTap: () {
                          AppCubit.get(context).removeNationalImage();
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          size: 30.w,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
            BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if (state is UploadDriverImageSuccess) {
                  showFlashMessage(
                    message: state.message,
                    type: FlashMessageType.success,
                    context: context,
                  );
                } else if (state is UploadDriverImageFailure) {
                  showFlashMessage(
                    message: state.error,
                    type: FlashMessageType.error,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  top: 20.h,
                  onPressed: () {
                    AppCubit.get(context).uploadDriverImage(
                      AppCubit.get(context).nationalImage.first,
                      type: 'nationalId',
                    );
                  },
                  child:
                      state is UploadDriverImageLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : AppText(
                            text: LocaleKeys.save.tr(),
                            size: 21.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
