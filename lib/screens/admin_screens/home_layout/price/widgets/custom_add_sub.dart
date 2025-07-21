import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomAddSub extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController subTypeController;
  const CustomAddSub({
    super.key,
    required this.subType,
    required this.priceController,
    required this.subTypeController,
  });

  final List subType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: 343.w,
              padding: EdgeInsetsDirectional.all(16.r),
              margin: EdgeInsetsDirectional.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'سعر الاشتراك',
                    size: 18.sp,
                    family: FontFamily.tajawalBold,
                  ),
                  AppInput(
                    top: 16.h,
                    bottom: 16.h,
                    start: 0,
                    end: 0,
                    controller: priceController,
                    hint: "سعر الاشتراك",
                    prefixIcon: const Icon(Icons.price_change_outlined),
                    inputType: TextInputType.number,
                  ),
                  AppText(
                    text: 'نوع الاشتراك',
                    size: 18.sp,
                    family: FontFamily.tajawalBold,
                  ),
                  SizedBox(height: 10.h),
                  AppInput(
                    bottom: 16.h,
                    start: 0,
                    end: 0,
                    controller: subTypeController,
                    hint: 'نوع الاشتراك',
                    prefixIcon: const Icon(Icons.price_change_outlined),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primary,

                      size: 25.sp,
                    ),
                    read: true,
                    onTap: () async {
                      String? value = await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            backgroundColor: AppColors.third,
                            title: AppText(text: 'نوع الاشتراك', size: 21.sp),
                            children:
                                subType.map((value) {
                                  return SimpleDialogOption(
                                    onPressed: () {
                                      // AuthCubit.get(context).cityId = value['id']
                                      //     .toString();
                                      Navigator.pop(context, value['title']);
                                    },
                                    child: AppText(
                                      text: value['title'] ?? "",
                                      size: 18.sp,
                                      color: AppColors.primary,
                                    ),
                                  );
                                }).toList(),
                          );
                        },
                      );
                      if (value != null) {
                        subTypeController.text = value;
                      }
                    },
                  ),
                  AppText(
                    bottom: 16.h,
                    text: LocaleKeys.choose_service.tr(),
                    size: 20.sp,
                    family: FontFamily.tajawalBold,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (AppCubit.get(context).paymentIndex == 0) {
                        AppCubit.get(context).changePaymentIndex(index: -1);
                      } else {
                        AppCubit.get(context).changePaymentIndex(index: 0);
                      }
                    },
                    child: Container(
                      width: 343.w,
                      padding: EdgeInsets.all(12.r),
                      // margin: EdgeInsetsDirectional.only(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.secondray,
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              AppText(
                                text: LocaleKeys.regular_flatbed.tr(),
                                start: 12.w,
                                color:
                                    AppCubit.get(context).paymentIndex == 0
                                        ? Colors.white
                                        : Colors.grey,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 22.w,
                            width: 22.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    AppCubit.get(context).paymentIndex == 0
                                        ? AppColors.primary
                                        : Colors.grey,
                                width: 1.w,
                              ),
                            ),
                            child: Container(
                              height: 12.w,
                              width: 12.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppCubit.get(context).paymentIndex == 0
                                        ? AppColors.primary
                                        : Colors.transparent,
                              ),
                              child: Icon(
                                Icons.done,
                                color:
                                    AppCubit.get(context).paymentIndex == 0
                                        ? Colors.white
                                        : Colors.transparent,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (AppCubit.get(context).paymentIndex == 1) {
                        AppCubit.get(context).changePaymentIndex(index: -1);
                      } else {
                        AppCubit.get(context).changePaymentIndex(index: 1);
                      }
                    },
                    child: Container(
                      width: 343.w,
                      padding: EdgeInsets.all(12.r),
                      // margin: EdgeInsetsDirectional.only(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.secondray,
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              AppText(
                                text: LocaleKeys.hydraulic_flatbed.tr(),
                                start: 12.w,
                                color:
                                    AppCubit.get(context).paymentIndex == 1
                                        ? Colors.white
                                        : Colors.grey,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 22.w,
                            width: 22.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    AppCubit.get(context).paymentIndex == 1
                                        ? AppColors.primary
                                        : Colors.grey,
                                width: 1.w,
                              ),
                            ),
                            child: Container(
                              height: 12.w,
                              width: 12.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppCubit.get(context).paymentIndex == 1
                                        ? AppColors.primary
                                        : Colors.transparent,
                              ),
                              child: Icon(
                                Icons.done,
                                color:
                                    AppCubit.get(context).paymentIndex == 1
                                        ? Colors.white
                                        : Colors.transparent,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if (state is AddSubscriptionSuccess) {
                  showFlashMessage(
                    message: state.message,
                    type: FlashMessageType.success,
                    context: context,
                  );
                  priceController.clear();
                  subTypeController.clear();
                  AppCubit.get(context).changePaymentIndex(index: -1);
                } else if (state is AddSubscriptionFailure) {
                  showFlashMessage(
                    message: state.error,
                    type: FlashMessageType.error,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  onPressed: () {
                    AppCubit.get(context).addSubscription(
                      price: priceController.text,
                      type: subTypeController.text,
                      serviceId:
                          AppCubit.get(context).paymentIndex == 0
                              ? "6832d41daaf83e5694854d65"
                              : "6832d5248f9c209682024b47",
                    );
                  },
                  child:
                      state is AddSubscriptionLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : AppText(
                            text: LocaleKeys.save.tr(),
                            color: Colors.white,
                            size: 21.sp,
                            family: FontFamily.tajawalBold,
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
