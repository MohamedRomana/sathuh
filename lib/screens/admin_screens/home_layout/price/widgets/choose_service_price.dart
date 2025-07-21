import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class ChooseServicePrice extends StatefulWidget {
  final TextEditingController priceController;
  final TextEditingController? priceController2;
  final bool isEdit;
  const ChooseServicePrice({
    super.key,
    required this.priceController,
    this.isEdit = false,
    this.priceController2,
  });

  @override
  State<ChooseServicePrice> createState() => _ChooseServicePriceState();
}

class _ChooseServicePriceState extends State<ChooseServicePrice> {
  @override
  void initState() {
    AppCubit.get(context).changePaymentIndex(index: -1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppText(
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
                        // SvgPicture.asset(
                        //   Assets.svg.,
                        //   height: 24.w,
                        //   width: 24.w,

                        //   color:
                        //       AppCubit.get(context).paymentIndex == 1
                        //           ? AppColors.third
                        //           : Colors.grey,
                        //   fit: BoxFit.cover,
                        // ),
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
            BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if (widget.isEdit) {
                  if (state is UpdatePriceSuccess) {
                    AppRouter.pop(context);
                    widget.priceController2!.clear();
                    AppCubit.get(context).changePaymentIndex(index: -1);
                    showFlashMessage(
                      message: state.message,
                      type: FlashMessageType.success,
                      context: context,
                    );
                  } else if (state is UpdatePriceFailure) {
                    AppRouter.pop(context);
                    showFlashMessage(
                      message: state.error,
                      type: FlashMessageType.error,
                      context: context,
                    );
                  }
                } else if (state is AddPriceSuccess) {
                  AppRouter.pop(context);
                  widget.priceController.clear();
                  AppCubit.get(context).changePaymentIndex(index: -1);
                  showFlashMessage(
                    message: state.message,
                    type: FlashMessageType.success,
                    context: context,
                  );
                } else if (state is AddPriceFailure) {
                  AppRouter.pop(context);
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
                    widget.isEdit
                        ? AppCubit.get(context).updatePrice(
                          serviceId:
                              AppCubit.get(context).paymentIndex == 0
                                  ? "6832d41daaf83e5694854d65"
                                  : "6832d5248f9c209682024b47",
                          pricePerMeter: widget.priceController2!.text,
                        )
                        : AppCubit.get(context).addPrice(
                          serviceId:
                              AppCubit.get(context).paymentIndex == 0
                                  ? "6832d41daaf83e5694854d65"
                                  : "6832d5248f9c209682024b47",
                          pricePerMeter: widget.priceController.text,
                        );
                  },
                  child:
                      state is AddPriceLoading || state is UpdatePriceLoading
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
