import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class ConfirmTransferPage extends StatefulWidget {
  final String fromAccount;
  final String beneficiaryName;
  final String accountNumber;
  final String amount;
  final String note;

  const ConfirmTransferPage({
    super.key,
    required this.fromAccount,
    required this.beneficiaryName,
    required this.accountNumber,
    required this.amount,
    this.note = '',
  });

  @override
  State<ConfirmTransferPage> createState() => _ConfirmTransferPageState();
}

class _ConfirmTransferPageState extends State<ConfirmTransferPage> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomAppBar(title: LocaleKeys.transfer_confirmation.tr()),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          LocaleKeys.from_account.tr(),
                          widget.fromAccount,
                        ),
                        _buildDetailRow(
                          LocaleKeys.beneficiary_name.tr(),
                          widget.beneficiaryName,
                        ),
                        _buildDetailRow(
                          LocaleKeys.account_number_iban.tr(),
                          widget.accountNumber,
                        ),
                        _buildDetailRow(LocaleKeys.amount.tr(), widget.amount),
                        if (widget.note.isNotEmpty)
                          _buildDetailRow(
                            LocaleKeys.note_with_transfer.tr(),
                            widget.note,
                          ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () async {
                    bool canCheckBiometrics = await auth.canCheckBiometrics;
                    bool authenticated = false;

                    if (canCheckBiometrics) {
                      try {
                        authenticated = await auth.authenticate(
                          localizedReason:
                              LocaleKeys.please_confirm_identity.tr(),
                          options: const AuthenticationOptions(
                            biometricOnly: true,
                            stickyAuth: true,
                          ),
                        );
                      } catch (e) {
                        debugPrint('Error authenticating: $e');
                      }
                    }

                    if (authenticated) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text(LocaleKeys.transfer_successful.tr()),
                              content: Text(
                                LocaleKeys.transfer_sent_successfully.tr(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.popUntil(
                                        context,
                                        (route) => route.isFirst,
                                      ),
                                  child: Text(LocaleKeys.ok.tr()),
                                ),
                              ],
                            ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            LocaleKeys.fingerprint_verification_failed.tr(),
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.check, size: 30.sp, color: Colors.white),
                  label: AppText(
                    text: LocaleKeys.transfer_confirmation.tr(),
                    size: 21.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width: 120.w,
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
