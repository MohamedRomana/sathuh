import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../generated/locale_keys.g.dart';
import '../bank_transfer/bank_transfer.dart';
import '../home_layout/home_layout.dart';

class PaymentSheet extends StatefulWidget {
  const PaymentSheet({super.key});

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  @override
  void initState() {
    AppCubit.get(context).changePaymentIndex(index: -1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          height: 350.h,
          padding: EdgeInsets.all(16.r),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: LocaleKeys.choosePaymentMethod.tr(),
                size: 18.sp,
                fontWeight: FontWeight.w500,
                top: 16.h,
              ),
              SizedBox(height: 8.w),
              const Divider(thickness: 1, color: Colors.grey),
              Column(
                children: [
                  SizedBox(height: 18.h),
                  InkWell(
                    onTap: () {
                      if (AppCubit.get(context).paymentIndex == 0) {
                        AppCubit.get(context).changePaymentIndex(index: -1);
                      } else {
                        AppCubit.get(context).changePaymentIndex(index: 0);
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 5.r,
                            spreadRadius: 1.r,
                            offset: Offset(0, 5.r),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.payment,
                            size: 25.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 8.w),
                          AppText(
                            text: LocaleKeys.cash.tr(),
                            size: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          const Spacer(),
                          Container(
                            height: 25.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  AppCubit.get(context).paymentIndex == 0
                                      ? AppColors.primary
                                      : Colors.transparent,
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: Icon(
                              Icons.done,
                              color:
                                  AppCubit.get(context).paymentIndex == 0
                                      ? Colors.white
                                      : Colors.transparent,
                              size: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 21.h),
                  InkWell(
                    onTap: () {
                      if (AppCubit.get(context).paymentIndex == 1) {
                        AppCubit.get(context).changePaymentIndex(index: -1);
                      } else {
                        AppCubit.get(context).changePaymentIndex(index: 1);
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 5.r,
                            spreadRadius: 1.r,
                            offset: Offset(0, 5.r),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.payments,
                            size: 25.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 8.w),
                          AppText(
                            text: LocaleKeys.onlinePayment.tr(),
                            size: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          const Spacer(),
                          Container(
                            height: 25.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  AppCubit.get(context).paymentIndex == 1
                                      ? AppColors.primary
                                      : Colors.transparent,
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: Icon(
                              Icons.done,
                              color:
                                  AppCubit.get(context).paymentIndex == 1
                                      ? Colors.white
                                      : Colors.transparent,
                              size: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: AppButton(
                  onPressed: () {
                    if (AppCubit.get(context).paymentIndex == -1) {
                      showFlashMessage(
                        message: LocaleKeys.choosePaymentMethod.tr(),
                        type: FlashMessageType.warning,
                        context: context,
                      );
                    } else if (AppCubit.get(context).paymentIndex == 0) {
                      AppCubit.get(context).changebottomNavIndex(1);
                      AppRouter.navigateAndFinish(context, const HomeLayout());
                    } else if (AppCubit.get(context).paymentIndex == 1) {
                      AppRouter.navigateTo(context, const BankTransferPage());
                    }
                  },
                  top: 30.h,
                  child: AppText(
                    text: LocaleKeys.confirm.tr(),
                    size: 21.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
