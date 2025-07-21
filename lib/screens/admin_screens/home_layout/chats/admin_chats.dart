import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/adm_previous_chats.dart';

class AdminChats extends StatelessWidget {
  const AdminChats({super.key});

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
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(title: LocaleKeys.chats.tr()),
                const AdmPreviousChats(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
