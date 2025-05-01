import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/assets.gen.dart';

class CustomAuthHeader extends StatelessWidget {
  const CustomAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Image.asset(
        Assets.img.logo.path,
        height: 300.h,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
