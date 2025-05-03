import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import 'widgets/custom_another_problem.dart';
import 'widgets/problems_list.dart';

final _problemController = TextEditingController();

class ProblemType extends StatefulWidget {
  const ProblemType({super.key});

  @override
  State<ProblemType> createState() => _ProblemTypeState();
}

class _ProblemTypeState extends State<ProblemType> {
  @override
  void initState() {
    AppCubit.get(context).changeSelectedProblem(index: -1);
    AppCubit.get(context).changeIndexs(index: -1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
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
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const CustomAppBar(title: 'نوع المشكله'),
                    const ProblemsList(),
                    CustomAnotherProblem(problemController: _problemController),
                    AppButton(
                      onPressed: () {
                        showFlashMessage(
                          message: 'اختر المشكله',
                          type: FlashMessageType.warning,
                          context: context,
                        );
                      },
                      top: 24.h,
                      child: AppText(
                        text: 'التالي',
                        color: Colors.white,
                        size: 21.sp,
                        family: FontFamily.tajawalBold,
                      ),
                    ),
                    SizedBox(height: 120.h),
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
