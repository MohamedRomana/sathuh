import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/assets.gen.dart';
import 'widgets/custom_driver_near_you.dart';
import 'widgets/custom_services.dart';
import 'widgets/custom_swiper.dart';
import 'widgets/custom_top_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 61.h),
                const CustomTopBar(),
                const CustomSwiper(),
                const CustomServices(),
                const CustomDriverNearYou(),
                SizedBox(height: 120.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
