import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sathuh/core/cache/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../admin_screens/home_layout/admin_home_layout.dart';
import '../../../driver_screens/home_layout/home_layout.dart';
import '../../../user_screens/home_layout/home_layout.dart';
import '../../data/auth_cubit.dart';
import '../confirm_email/confirm_email.dart';
import '../forget_pass/forget_pass.dart';
import '../register/register.dart';
import '../widgets/auth_header.dart';
import 'widgets/login_fields.dart';

final _formKey = GlobalKey<FormState>();
final _phoneController = TextEditingController();
final _passController = TextEditingController();
String phoneCode = "";

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final auth = LocalAuthentication();

  Future<bool> authenticateWithBiometrics() async {
    final isAvailable = await auth.canCheckBiometrics;
    if (!isAvailable) return false;
    final availableBiometrics = await auth.getAvailableBiometrics();
    final didAuthenticate = await auth.authenticate(
      localizedReason:
          availableBiometrics.contains(BiometricType.face)
              ? LocaleKeys.login_with_face_id.tr()
              : LocaleKeys.login_with_fingerprint.tr(),
      options: const AuthenticationOptions(biometricOnly: true),
    );

    return didAuthenticate;
  }

  @override
  void initState() {
    _phoneController.clear();
    _passController.clear();
    super.initState();
  }

  static Future<bool> saveData({
    required String key,
    required String value,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (value.isEmpty) {
      return false;
    } else {
      return prefs.setString(key, value);
    }
  }

  static Future<String?> getData({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const CustomAuthHeader(),
            CustomLoginFields(
              formKey: _formKey,
              phoneController: _phoneController,
              passController: _passController,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LogInSuccess) {
                  saveData(key: 'phone', value: _phoneController.text);
                  saveData(key: 'password', value: _passController.text);

                  if (CacheHelper.getUserType() == "admin") {
                    AppCubit.get(context).changebottomAdminNavIndex(1);
                    AppRouter.navigateAndFinish(
                      context,
                      const AdminHomeLayout(),
                    );
                  } else if (CacheHelper.getUserType() == "driver") {
                    AppCubit.get(context).changebottomDriverNavIndex(1);
                    AppRouter.navigateAndFinish(
                      context,
                      const DriverHomeLayout(),
                    );
                  } else {
                    AppCubit.get(context).changebottomNavIndex(1);
                    AppRouter.navigateAndFinish(context, const HomeLayout());
                  }

                  _phoneController.clear();
                  _passController.clear();
                  showFlashMessage(
                    context: context,
                    type: FlashMessageType.success,
                    message: LocaleKeys.welcome_dear_customer.tr(),
                  );
                } else if (state is LogInFailure) {
                  showFlashMessage(
                    context: context,
                    type: FlashMessageType.error,
                    message: state.error,
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  top: 24.h,
                  bottom: 20.h,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await AuthCubit.get(context).logIn(
                        phone: _phoneController.text,
                        password: _passController.text,
                        deviceToken: CacheHelper.getDeviceToken(),
                      );
                    }
                  },
                  child:
                      state is LogInLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : AppText(
                            text: LocaleKeys.signin.tr(),
                            color: Colors.white,
                            family: FontFamily.tajawalBold,
                          ),
                );
              },
            ),
            InkWell(
              onTap: () async {
                final availableBiometrics = await auth.getAvailableBiometrics();
                bool authenticated = await authenticateWithBiometrics();
                if (authenticated) {
                  final cachedPhone = await getData(key: 'phone');
                  final cachedPass = await getData(key: 'password');
                  debugPrint("phone : $cachedPhone , pass : $cachedPass");

                  if (cachedPhone != null && cachedPass != null) {
                    saveData(key: 'phone', value: _phoneController.text);
                    saveData(key: 'password', value: _passController.text);

                    await AuthCubit.get(context).logIn(
                      phone: cachedPhone,
                      password: cachedPass,
                      deviceToken: CacheHelper.getDeviceToken(),
                    );
                  } else {
                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.error,
                      message:
                          LocaleKeys.no_saved_data_login_manually_first.tr(),
                    );
                  }
                } else {
                  showFlashMessage(
                    context: context,
                    type: FlashMessageType.error,
                    message:
                        availableBiometrics.contains(BiometricType.face)
                            ? LocaleKeys.face_id_authentication_failed.tr()
                            : LocaleKeys.fingerprint_authentication_failed.tr(),
                  );
                }
              },
              child: SvgPicture.asset(
                Assets.svg.faceId,
                height: 86.w,
                width: 86.w,
                color: AppColors.secondray,
                fit: BoxFit.cover,
              ),
            ),
            CacheHelper.getUserType() == "admin"
                ? Container()
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: LocaleKeys.dontHaveAccount.tr(),
                      size: 14.sp,
                      color: AppColors.secondray,
                    ),
                    TextButton(
                      onPressed: () {
                        AppRouter.navigateTo(context, const Register());
                      },
                      child: AppText(
                        text: LocaleKeys.newUser.tr(),
                        size: 14.sp,
                        color: AppColors.darkRed,
                      ),
                    ),
                  ],
                ),
            // Container(height: 16.h),
            CacheHelper.getUserType() == "admin"
                ? Container()
                : TextButton(
                  onPressed:
                      () => AppRouter.navigateTo(context, const ForgetPass()),
                  child: AppText(
                    text: LocaleKeys.forgetPass.tr(),
                    size: 14.sp,
                    color: AppColors.darkRed,
                  ),
                ),
            CacheHelper.getUserType() == "admin"
                ? Container()
                : TextButton(
                  onPressed:
                      () => AppRouter.navigateTo(
                        context,
                        const AuthConfirmEmail(),
                      ),
                  child: AppText(
                    text: 'تأكيد البريد الألكتروني',
                    size: 14.sp,
                    color: Colors.cyan,
                  ),
                ),
            Container(height: 10.h),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (CacheHelper.getUserType() == "admin") {
                  AppCubit.get(context).changebottomAdminNavIndex(1);
                  AppRouter.navigateAndFinish(context, const AdminHomeLayout());
                } else if (CacheHelper.getUserType() == "driver") {
                  AppCubit.get(context).changebottomDriverNavIndex(1);
                  AppRouter.navigateAndFinish(
                    context,
                    const DriverHomeLayout(),
                  );
                } else {
                  AppCubit.get(context).changebottomNavIndex(1);
                  AppRouter.navigateAndFinish(context, const HomeLayout());
                }
              },
              child: SizedBox(
                width: 150.w,
                child: AppText(
                  textAlign: TextAlign.center,
                  text: LocaleKeys.skiptohome.tr(),
                  size: 14.sp,
                  color: AppColors.secondray,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(height: 60.h),
          ],
        ),
      ),
    );
  }
}
