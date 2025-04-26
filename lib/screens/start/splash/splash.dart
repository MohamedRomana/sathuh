// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/assets.gen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/fonts.gen.dart';
import '../language/language_view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _shakeController;
  late Animation<Offset> _slidingAnimation;
  late Animation<double> _shakeAnimation;
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
      begin: 400.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 1000), () {
      _controller.forward();
    });

    super.initState();
    _customAnimation();
    _customNavigation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _slidingAnimation,
              builder: (context, child) {
                return SlideTransition(
                  position: _slidingAnimation,
                  child: AnimatedBuilder(
                    animation: _shakeAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_shakeAnimation.value, 0),
                        child: Image.asset(
                          Assets.img.logo.path,
                          height: 162.h,
                          width: 180.w,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation.value),
                child: child,
              );
            },
            child: AppText(
              top: 15.h,
              textAlign: TextAlign.center,
              text: 'سطحه',
              size: 30.sp,
              color: AppColors.primary,
              family: FontFamily.tajawalBold,
            ),
          ),
        ],
      ),
    );
  }

  Future _customNavigation() {
    return Future.delayed(const Duration(seconds: 3), () {
      _shakeController.forward();

      AppRouter.navigateAndPop(context, const LanguageView());
      // CacheHelper.getLang() != ""
      //     ? CacheHelper.getUserId() != ""
      //         ? CacheHelper.getUserType() == "client"
      //             ? AppRouter.navigateAndPop(context, const HomeLayout())
      //             : AppRouter.navigateAndPop(
      //                 context, const ProviderHomeLayout())
      //         : AppCubit.get(context).showImage
      //             ? AppRouter.navigateAndPop(context, const TypeScreen())
      //             : AppRouter.navigateAndPop(context, const HomeLayout())
      //     : AppRouter.navigateAndPop(context, const OnBoarding());
    });
  }

  void _customAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _slidingAnimation = Tween<Offset>(
      begin: const Offset(5, 5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutExpo),
    );

    _animationController.forward();

    // Shake animation controller
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _shakeAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: -10,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -10,
          end: 10,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 10,
          end: -10,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -10,
          end: 10,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 10,
          end: 0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
    ]).animate(_shakeController);
    Future.delayed(const Duration(milliseconds: 1800), () {
      _shakeController.forward();
    });
  }
}
