import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import 'package:sathuh/core/widgets/custom_app_bar.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../map/map.dart';
import 'widgets/custom_another_problem.dart';
import 'widgets/problems_list.dart';

final _problemController = TextEditingController();

class ProblemType extends StatefulWidget {
  final String carId;
  final String serviceId;

  const ProblemType({super.key, required this.carId, required this.serviceId});

  @override
  State<ProblemType> createState() => _ProblemTypeState();
}

class _ProblemTypeState extends State<ProblemType> {
  @override
  void initState() {
    AppCubit.get(context).changeSelectedProblem(index: -1);
    AppCubit.get(context).changeIndexs(index: -1);
    AppCubit.get(context).carProblems();
    _problemController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          resizeToAvoidBottomInset: true,
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
                    CustomAppBar(title: LocaleKeys.problem_type.tr()),
                    const ProblemsList(),
                    CustomAnotherProblem(problemController: _problemController),
                    AppButton(
                      onPressed: () {
                        if (AppCubit.get(
                          context,
                        ).selectedProblemIndexes.contains(-1)) {
                          showFlashMessage(
                            message: LocaleKeys.select_problem.tr(),
                            type: FlashMessageType.warning,
                            context: context,
                          );
                        } else {
                          AppRouter.navigateTo(
                            context,
                            OpenStreetMapView(
                              problemId:
                                  AppCubit.get(
                                    context,
                                  ).carProblemsList[AppCubit.get(
                                    context,
                                  ).selectedProblemIndexes[0]]['_id'],
                              problemController: _problemController,
                              carsId: widget.carId,
                              serviceId: widget.serviceId,
                            ),
                          );

                          debugPrint(
                            'problem id: ${AppCubit.get(context).carProblemsList[AppCubit.get(context).selectedProblemIndexes[0]]['_id']}',
                          );
                        }
                      },
                      top: 24.h,
                      child: AppText(
                        text: LocaleKeys.next.tr(),
                        color: Colors.white,
                        size: 21.sp,
                        family: FontFamily.tajawalBold,
                      ),
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
