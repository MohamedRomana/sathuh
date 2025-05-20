import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/screens/start/types/types_view.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../gen/assets.gen.dart';

class CustomAuthHeader extends StatelessWidget {
  const CustomAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Image.asset(
            Assets.img.logo.path,
            height: 300.h,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        PositionedDirectional(
          top: 30.h,
          start: 16.w,
          child: IconButton(
            onPressed: () {
              AppRouter.navigateAndFinish(context, const TypesView());
            },
            icon: const Icon(Icons.logout_outlined, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
