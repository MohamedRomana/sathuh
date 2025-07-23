import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    AppCubit.get(context).drawerIndex = 4;
    AppCubit.get(context).privacyPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body:
          // state is PrivacyPolicyLoading
          //     ? const Center(
          //       child: CircularProgressIndicator(color: AppColors.primary),
          //     )
          //     :
          Stack(
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
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CustomAppBar(title: LocaleKeys.privacy_policy.tr()),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Image.asset(
                        Assets.img.logo.path,
                        height: 300.h,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    AppText(
                      start: 16.w,
                      end: 16.w,
                      textAlign: TextAlign.center,
                      text:
                          'نحن نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية، حيث نقوم بجمع معلومات مثل الموقع الجغرافي ورقم الهاتف وبيانات السيارة فقط لتقديم خدمة الونش بدقة، ويُستخدم موقعك الجغرافي أثناء الطلب لتحديد موقعك وتقديم الخدمة بشكل أسرع، ولا نقوم بمشاركة بياناتك مع أي طرف ثالث دون موافقتك، كما نستخدم تقنيات آمنة لحماية معلوماتك من أي وصول غير مصرح به، ونحتفظ بالبيانات فقط للمدة اللازمة لتقديم وتحسين الخدمة، ويمكنك طلب حذف بياناتك في أي وقت عبر التواصل معنا من داخل التطبيق، وباستخدامك التطبيق فإنك توافق على هذه السياسة، ونحتفظ بحقنا في تعديلها في أي وقت مع إشعارك بالتحديثات، ولمزيد من الاستفسارات يمكنك التواصل معنا من خلال قسم "اتصل بنا". ',
                      lines: 100,
                      size: 16.sp,
                    ),
                    Container(height: 120.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
