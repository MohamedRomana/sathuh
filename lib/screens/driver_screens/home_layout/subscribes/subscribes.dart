import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/custom_subscrip.dart';

class Subscribes extends StatelessWidget {
  const Subscribes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
              Column(
                children: [
                  CustomAppBar(
                    title: LocaleKeys.packages.tr(),
                    isHomeLayout: true,
                  ),
                  const CustomSubscriptions(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

