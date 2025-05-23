import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/cache/cache_helper.dart';
import 'package:sathuh/core/constants/colors.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_input.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'confirm_bank_transfer/confirm_bank_transfer.dart';

final _formKey = GlobalKey<FormState>();
final _accountController = TextEditingController();
final _nameController = TextEditingController();
final _ibanController = TextEditingController();
final _amountController = TextEditingController();
final _messageController = TextEditingController();

class BankTransferPage extends StatefulWidget {
  const BankTransferPage({super.key});

  @override
  State<BankTransferPage> createState() => _BankTransferPageState();
}

class _BankTransferPageState extends State<BankTransferPage> {
  @override
  void initState() {
    _accountController.clear();
    _nameController.clear();
    _ibanController.clear();
    _amountController.text =
        CacheHelper.getUserType() == "driver"
            ? '1000 ${LocaleKeys.sar.tr()}'
            : '20 ${LocaleKeys.sar.tr()}';
    _messageController.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Stack(
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
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(title: LocaleKeys.bankTransfer.tr()),
                      AppText(
                        text: LocaleKeys.from_account.tr(),
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          hintText: LocaleKeys.main_account.tr(),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: "main",
                            child: Text(LocaleKeys.main_account.tr()),
                          ),
                          DropdownMenuItem(
                            value: "savings",
                            child: Text(LocaleKeys.savings_account.tr()),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _accountController.text = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.please_select_account.tr();
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      Text(
                        LocaleKeys.beneficiary_name.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppInput(
                        hint: LocaleKeys.enter_beneficiary_name.tr(),
                        filled: true,
                        enabledBorderColor: AppColors.borderColor,
                        border: 8.r,
                        start: 0,
                        end: 0,
                        controller: _nameController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.please_enter_beneficiary_name
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Text(
                        LocaleKeys.account_number_iban.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppInput(
                        hint: LocaleKeys.iban_example.tr(),
                        filled: true,
                        enabledBorderColor: AppColors.borderColor,
                        border: 8.r,
                        start: 0,
                        end: 0,
                        controller: _ibanController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.please_enter_iban.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Text(
                        LocaleKeys.amount.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppInput(
                        inputType: TextInputType.number,
                        hint: LocaleKeys.enter_amount.tr(),
                        filled: true,
                        enabledBorderColor: AppColors.borderColor,
                        border: 8.r,
                        start: 0,
                        end: 0,
                        controller: _amountController,
                        read: true,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.please_enter_amount.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Text(
                        LocaleKeys.note_optional.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppInput(
                        maxLines: 2,
                        hint: LocaleKeys.note_with_transfer.tr(),
                        filled: true,
                        enabledBorderColor: AppColors.borderColor,
                        border: 8.r,
                        start: 0,
                        end: 0,
                        controller: _messageController,
                      ),
                      const SizedBox(height: 24),

                      Center(
                        child: AppButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AppRouter.navigateTo(
                                context,
                                ConfirmTransferPage(
                                  fromAccount: _accountController.text,
                                  beneficiaryName: _nameController.text,
                                  accountNumber: _ibanController.text,
                                  amount: _amountController.text,
                                  note: _messageController.text,
                                ),
                              );
                            }
                          },
                          child: AppText(
                            text: LocaleKeys.next.tr(),
                            size: 21.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
