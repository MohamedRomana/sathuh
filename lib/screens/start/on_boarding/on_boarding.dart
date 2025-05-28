// ignore_for_file: deprecated_member_use

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/cache/cache_helper.dart';
import 'package:sathuh/core/widgets/custom_lottie_widget.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import 'widgets/on_boarding_buttons.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double currPage = 0.0;
  PageController pageController = PageController(initialPage: 0);
  List pagesList = [
    {
      "image1": Assets.img.time,
      "title":
          CacheHelper.getLang() == "en"
              ? "With you 24 hours"
              : "معاك علي مدار 24 ساعة",
      "desc":
          CacheHelper.getLang() == "en"
              ? "All services are available 24/7, all days of the week and official holidays."
              : "جميع الخدمات متاحه علي مدار 24/7 جميع أيام الأسبوع والعطلات الرسمية",
    },
    {
      "image1": Assets.img.easy,
      "title":
          CacheHelper.getLang() == "en"
              ? "Ease of handling"
              : "سهولة في التعامل",
      "desc":
          CacheHelper.getLang() == "en"
              ? "With simple and easy steps, you can order and enjoy all services."
              : "بخطوات بسيطة وسهله تقدر تطلب وتستمتع بجميع الخدمات",
    },
    {
      "image1": Assets.img.mony,
      "title":
          CacheHelper.getLang() == "en"
              ? "Save your time and money"
              : "توفير لوقتك وفلوسك",
      "desc":
          CacheHelper.getLang() == "en"
              ? "With simple and easy steps, you can order and enjoy all services."
              : "بخطوات بسيطة وسهله تقدر تطلب وتستمتع بجميع الخدمات",
    },
    {
      "image1": Assets.img.car,
      "title":
          CacheHelper.getLang() == "en"
              ? "Safety for you and your car"
              : "أمان ليك ولعربيتك",
      "desc":
          CacheHelper.getLang() == "en"
              ? "The rescue unit is monitored moment by moment, and the number of minutes until it reaches the customer is known, and the car is monitored by an online camera."
              : "يتم متابعة وحدة الإنقاذ لحظة بلحظة ومعرفة عدد الدقائق لحين وصولها للعميل ويتم مراقبة السياره بكاميرا تصوير أونلاين",
    },
  ];

  @override
  void initState() {
    super.initState();
    // AppCubit.get(context).intro();
    pageController = PageController(initialPage: 0)..addListener(() {
      setState(() {
        currPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body:
          // state is GetIntroLoading
          //     ? const Center(
          //         child: CircularProgressIndicator(color: AppColors.primary),
          //       )
          //     :
          Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: pagesList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Container(height: 60.h),
                          CustomLottieWidget(
                            lottieName: pagesList[index]['image1'],
                          ),
                          AppText(
                            top: 74.h,
                            bottom: 5.h,
                            start: 26.w,
                            end: 26.w,
                            lines: 2,
                            textAlign: TextAlign.center,
                            text: pagesList[index]['title'],
                            size: 30.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            textAlign: TextAlign.center,
                            text: pagesList[index]['desc'],
                            lines: 3,
                            start: 26.w,
                            end: 26.w,
                            size: 14.sp,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      CustomOnBoardingButtons(
                        pagesList: pagesList,
                        currPage: currPage,
                        pageController: pageController,
                      ),
                    ],
                  );
                },
              ),
              PositionedDirectional(
                bottom: 150.h,
                end: 20.w,
                start: 20.w,
                child: DotsIndicator(
                  dotsCount: pagesList.length,
                  position: currPage,
                  decorator: DotsDecorator(
                    activeColor: AppColors.primary,
                    color: const Color(0xff878787).withOpacity(0.3),
                    size: Size.square(12.r),
                    activeSize: Size(20.w, 12.h),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
